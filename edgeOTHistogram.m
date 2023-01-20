function edhist= edgeOTHistogram(rgb_im)
%EDGE DIRECTIONAL HISTOGRAM
%Input image should be a RGB image,
%a 1x5 edge orientation histogram is computed (horizontal, vertical,
% 2 diagonals and 1 non-directional)
 
%CONVERT RGB COLOR SPACE INTO YCBCR COLORSPACE
new_im=rgb2ycbcr(rgb_im);

%EXTRACT ONLY Y COMPONENT, SINCE Y IS HAVING MASSIVE EDGE INFORMATION,
% Y COMPONENT IS CHOSEN AND EXTRACTED FROM Y, CB, CR
y=double(new_im(:,:,1));
%figure,imshow(y,'initialmagnification','fit');

%DEFINE THE FILTERS FOR THE 5 TYPES OF EDGES
f1 = zeros(3,3,5); %3 ROWS 3 COLUMN 5 PLANES 
f1(:,:,1) = [1 2 1;0 0 0;-1 -2 -1]; %HORIZONTAL
f1(:,:,2) = [-1 0 1;-2 0 2;-1 0 1];   %VERTICAL
f1(:,:,3) = [2 2 -1;2 -1 -1; -1 -1 -1];% 45 DIAGONAL
f1(:,:,4) = [-1 2 2; -1 -1 2; -1 -1 -1];%135 DIAGONAL
f1(:,:,5) = [-1 0 1;0 0 0;1 0 -1]; % NON DIRECTIONAL

% ITERATE OVER THE POSSIBLE DIRECTIONS
for i = 1:5
% APPLY THE SOBEL MASK
g_im(:,:,i) = filter2(f1(:,:,i),y);
end
% CALCULATE THE MAX SOBEL GRADIENT AND INDEX  OF THE ORIENTATION
[m, p] = max(g_im,[],3);
% JUST THE INDEX (TYPE) OF THE ORIENTATION
% AND IGNORE THE VALUE OF THE GRADIENT

%DETECT THE EDGES USING CANNY
edim = edge(y, 'canny');
%figure,imshow(edim,'initialmagnification','fit');

%multiply edge image with the types of orientations detected
% by the Sobel masks
im2 =(p.*edim);

%FIND HISTOGRAM
edhist=hist(im2(:),5)';

end








