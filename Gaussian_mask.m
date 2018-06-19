function [H] = Gaussian_mask(msigma,msize)
k=floor(msize/2);
sum=0;

for i=1:2*k+1
    for j=1:2*k+1
H(i,j)=((1/(((2*pi))*(msigma^2)))*(exp((-(((i-(k+1))^2)+((j-(k+1))^2)))/(2*(msigma^2)))));
sum = sum + H(i,j);
    end
end
H = 1/sum.*H;

end

