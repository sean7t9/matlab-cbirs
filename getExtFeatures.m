function [ features ] = getExtFeatures( rgbim )
%FEATURES EXTRACTION PROCESS GOES HERE 

 %COLOR FEATURE
 fet1=colourFeatLUV(rgbim);
 
 %EDGE FEATURE
 fet2=edgeOTHistogram(rgbim);
 
 %TEXTURE FEATURE
 %GLCM-GRAY LEVEL CO OCCURRENCE MATRIX
 glcm=graycomatrix(rgb2gray(rgbim));
 fet3=glcm(:);
 
 %FEATURES
 features=[fet1;fet2;fet3];
end

