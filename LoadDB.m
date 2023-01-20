function [  ] = LoadDB( )
%Option to load Database created from Selected Object/Image directory
% folder_name = uigetdir('D:\MSc\Finals\CBIRS', 'Select the directory of images');
% % D = 'D:\MSc\Finals\CBIRS';
% S = load(fullfile(folder_name,'coilDB.mat'));
S = load('D:\MSc\Finals\CBIRS\coilDB.mat');
imgs = S.imgs;
N = numel(imgs);
for k = 1:N
    I = imresize(imgs(k).image,[128,128]);
  %SEPERATE CHANNELS
 r_channel=I(:,:,1);
 b_channel=I(:,:,2);
 g_channel=I(:,:,3);

%DENOISE EACH CHANNEL 2-D MEDIAN FILTERING
 r_channel=medfilt2(r_channel);
 g_channel=medfilt2(g_channel);
 b_channel=medfilt2(b_channel);

%RESTORE CHANNELS
 rgbim(:,:,1)=r_channel;
 rgbim(:,:,2)=g_channel;
 rgbim(:,:,3)=b_channel;
 J = cat(3,r_channel,g_channel,b_channel); % concatenate
    imgs(k).fat = getExtFeatures(J);
end
F = {imgs.fat};
C = {imgs.name};
fat = [F(:),C(:)];
H = {imgs.image};
real = [H(:)];
save ('imageReal.mat','real');
save('imageFAT.mat','fat');
save('imageFEAT.mat','imgs');
msgbox('Database Loaded Successfully .','Database Result','help');


