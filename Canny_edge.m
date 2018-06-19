 function [ edge_final ] = Canny_edge(PATHNAME,msize,msigma,Thresh_Low,Thresh_High)

%Input image --------------------------- HARDCODED (CHANGE)----------------

% file = fopen('Band8.bin', 'r');
% A = fread(file, 256*256, 'uint16=>uint16');
% A = reshape(A, 256, 256).';
% figure, imshow(A);

img = imread (PATHNAME);
%Displaying the input image
img = rgb2gray(img);
img = double (img);

% Thresholding --------------------------- HARDCODED(CHANGE)---------------
%Thresh_Low = 0.075;
%Thresh_High = 0.175;

[H] = Gaussian_mask(msigma,msize);

%Convolution of image by Gaussian filter Coefficient
%A=conv2(img, H, 'same');
size(img)
A=Convolution(img, H);
size(A)
%figure, imshow(A);
%Filter for horizontal and vertical direction (sobel operator)
Grad_x = [-1, 0, 1;
          -2, 0, 2;
          -1, 0, 1];
Grad_y = [1, 2, 1;
          0, 0, 0; 
         -1, -2, -1];

%Convolution by image by horizontal and vertical filter
%Grad_X = conv2(A, Grad_x, 'same');
Grad_X = Convolution(A, Grad_x);
%Grad_Y = conv2(A, Grad_y, 'same');
Grad_Y = Convolution(A, Grad_y);

%Calculate directions/orientations
Orientation = atan2 (Grad_Y, Grad_X);
Orientation = Orientation*180/pi; %radians

width=size(A,1);
length=size(A,2);

%Adjustment for negative directions, making all directions positive
for i=1:width
    for j=1:length
        if (Orientation(i,j)<0) 
            Orientation(i,j)=360+Orientation(i,j);
        end;
    end;
end;

Orient_new=zeros(width, length);

%Adjusting directions to nearest 0, 45, 90, or 135 degree in all the
%quadrants
for i = 1  : width
    for j = 1 : length
        if ((Orientation(i, j) >= 0 ) && (Orientation(i, j) < 22.5) || (Orientation(i, j) >= 157.5) && (Orientation(i, j) < 202.5) || (Orientation(i, j) >= 337.5) && (Orientation(i, j) <= 360))
            Orient_new(i, j) = 0;
        elseif ((Orientation(i, j) >= 22.5) && (Orientation(i, j) < 67.5) || (Orientation(i, j) >= 202.5) && (Orientation(i, j) < 247.5))
            Orient_new(i, j) = 45;
        elseif ((Orientation(i, j) >= 67.5 && Orientation(i, j) < 112.5) || (Orientation(i, j) >= 247.5 && Orientation(i, j) < 292.5))
            Orient_new(i, j) = 90;
        elseif ((Orientation(i, j) >= 112.5 && Orientation(i, j) < 157.5) || (Orientation(i, j) >= 292.5 && Orientation(i, j) < 337.5))
            Orient_new(i, j) = 135;
        end;
    end;
end;

%figure, imagesc(Orient_new); colorbar;

%Calculate magnitude and normalise it
magnitude = (Grad_X.^2) + (Grad_Y.^2);
magnitude2 = sqrt(magnitude);

BW = zeros (width, length);

%Non-Maximum Supression
for i=2:width-1
    for j=2:length-1
        if (Orient_new(i,j)==0)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i,j+1), magnitude2(i,j-1)]));
        elseif (Orient_new(i,j)==45)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j-1), magnitude2(i-1,j+1)]));
        elseif (Orient_new(i,j)==90)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j), magnitude2(i-1,j)]));
        elseif (Orient_new(i,j)==135)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j+1), magnitude2(i-1,j-1)]));
        end;
    end;
end;
 size(BW)
  BW = BW.*magnitude2;
  %figure, imshow(BW);
 
 %Hysteresis Thresholding
 Thresh_Low = Thresh_Low * max(max(BW));
 Thresh_High = Thresh_High * max(max(BW));
 
 T_res = zeros (width, length);
 
 for i = 1  : width
     for j = 1 : length
         if (BW(i, j) < Thresh_Low)
             T_res(i, j) = 0;
         elseif (BW(i, j) > Thresh_High)
             T_res(i, j) = 1;
         %Using 8-connected components for joining
         elseif ( BW(i+1,j)>Thresh_High || BW(i-1,j)>Thresh_High || BW(i,j+1)>Thresh_High || BW(i,j-1)>Thresh_High || BW(i-1, j-1)>Thresh_High || BW(i-1, j+1)>Thresh_High || BW(i+1, j+1)>Thresh_High || BW(i+1, j-1)>Thresh_High)
            T_res(i,j) = 1;
        end;
    end;
end;

edge_final = uint8(T_res.*255);
%Show final edge detection result
%figure, imshow(edge_final);
imwrite(edge_final, 'Canny.jpg');

 end




