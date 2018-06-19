function [B] = Convolution(A,H)
%clear all;
%close all;
%clc;
%A=imread('house.jpg');
%A=rgb2gray(A);
%A=im2bw(A);

%H=[-1 0 1; -2 0 2; -1 0 1];
%D=conv2(A,H);
% msize=3;
% msigma=4;

%%
%%Main Convolution code
[r c] = size(A);
[m n] = size(H);
p=floor(m/2);

A=padarray(A,[p,p]);

% for x=2:r-1
%     for y=2:c-1
%          for  i=2:1:m-1;
%              j=i;
%                C1(x,y)=((A(x-1,y-1)*H(i-1,j-1))+(A(x-1,y)*H(i-1,j))+(A(x-1,y+1)*H(i-1,j+1))+(A(x,y-1)*H(i,j-1))+(A(x,y)*H(i,j))+(A(x,y+1)*H(i,j+1))+(A(x+1,y-1)*H(i+1,j-1))+(A(x+1,y)*H(i+1,j))+(A(x+1,y+1)*H(i+1,j+1)));
%          
%              end
%     end
% end
%%
B = zeros(r , c);
Matpad=padarray(A,[1,1]);
for x = 1 : r
    for y = 1 : c
        for i = 1 : m
            for j = 1 : n
                q = x-1;
                w = y-1;
                B(x,y) = B(x,y) + (Matpad(i + q, j + w) * H(i,j));
                
 
            end
        end
    end
end
r
c
[m n] = size(B)
B = B(p:m,p:n);

%h1 = rot90(B1, 2)
%B1=sqrt(B.^2);
%subplot(2,2,1);
%imshow(B);
%subplot(2,2,2);
%imshow(D);
end