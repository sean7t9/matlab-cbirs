function [ image_name ] = regImage( im )
%Summary of this function goes here
%Pre-Processing Operation for TEST images goes here

clc;
if (exist('imageDatabase.mat')==2) 
% pre_processing(im);
%RESIZE TEST IMAGE
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

 %FEATURES EXTRACTION
fet=getExtFeatures(rgbim);

%WAITBAR DIALOG
h = waitbar(0,'Searching Database for A Match...');
steps = 200;
for step = 1:steps
    waitbar(step / steps)
end
load('imageDatabase.mat','-mat');
close(h) 
    %msgbox('Searching in Database','Database result','help');
    k=length(qImage);
    for j=1:k
        D(j)=dist(fet',qImage{j,1});
    end
    [value,index]=min(D);
%     [sortedD, sortidx] = sort(D);
%         ten_best_D = sortedD(1:10);
%         ten_best_idx = sortidx(1:10);
% for g = 1:length(ten_best_idx)
%     L(g) ={qImage(ten_best_idx(g)),2};
% end
% addpath(genpath('D:\MSc\Finals\CBIRS\ImageDatabase'))
% IQ = montage(L, 'Size', [2 5]);
    if value<.001
        image_name=qImage(index,2);
        
    else
        image_name = 'Image Not Recognised/No Matches Found';
    end
else
    msgbox('Database is empty.','Database result','help');
    image_name = 'No database';
end
end

