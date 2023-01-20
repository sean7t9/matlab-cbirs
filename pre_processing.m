function [] = pre_processing (im)

%Pre-Processing Operation goes here

im=imresize(im,[128 128]);

%SEPERATE CHANNELS
 r_channel=im(:,:,1);
 b_channel=im(:,:,2);
 g_channel=im(:,:,3);

 %DENOISE EACH CHANNEL 2-D MEDIAN FILTERING
 r_channel=medfilt2(r_channel);
 g_channel=medfilt2(g_channel);
 b_channel=medfilt2(b_channel);

 %RESTORE CHANNELS
 rgbim(:,:,1)=r_channel;
 rgbim(:,:,2)=g_channel;
 rgbim(:,:,3)=b_channel;
