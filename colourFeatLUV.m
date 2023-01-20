function colfet=colourFeatLUV(rgb_im)
%Three Color Moments,Mean,Color Variance And Color Skewness In Each Channel
%(L,U And V Respectively)
%Total 9-D Color Moments
%Input Image Should Be A RGB Image,


%Matlab does not have a direct function to convert RGB2LUV 
%directly so we perform a RGB2XYZ then XYZ2UVL
%WHY LUV USE LUV COLOR SPACE?
%LUV was designed to be 'perceptually linear'. LUV tends to decouple the "colour" (chromaticity, the UV part) and "lightness" (luminance, the L part) of colour

%CONVERT RGB TO XYZ COLORSPACE
xyzTransformation = makecform('srgb2xyz');
xyzI = applycform(rgb_im,xyzTransformation);

% X = XyzI(:,:,1); #first plane or channel
% Y = XyzI(:,:,2);
% Z = XyzI(:,:,3);
% figure, imshow(X) , title('X');
% figure, imshow(Y) , title('Y');
% figure, imshow(Z) , title('Z');
% xyz = cat(3, X,Y,Z);
% figure, imshow(xyz) , title('xyz');

%CONVERT XYZ TO LUV COLORSPACE
warning('off');
luvTransformation = makecform('xyz2uvl');
luvI = applycform(xyzI,luvTransformation);
%figure,imshow(luvI,'initialmagnification','fit');

%SEPERATE L,U,V
L=luvI(:,:,1);
U=luvI(:,:,2);
V=luvI(:,:,3);

% figure, imshow(L) , title('L');
% figure, imshow(U) , title('U');
% figure, imshow(V) , title('V');
 
%FIND MEAN, COLOR VARIANCE AND COLOR SKEWNESS FOR EACH CHANNEL
% Turned each channel to a single column matrix before moment calc are
% done
 colfet(1)= mean(L(:)); 
 colfet(2) = std(L(:))^2;
 colfet(3)= skewness(L(:));
 colfet(4) = mean(U(:));
 colfet(5) = std(U(:))^2;
 colfet(6) = skewness(U(:));
 colfet(7) = mean(V(:));
 colfet(8) = std(V(:))^2;
 colfet(9) = skewness(V(:));
 
colfet=colfet';
end

