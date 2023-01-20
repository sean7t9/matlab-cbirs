function [L,Y,B ] = queryImageFromLoadedDB(queImage)
%Query Image from Loaded DB created by CreateDBFromFolder.m
clc;
[filename, file] = uigetfile ({'*.png';'*.jpg';'*.*'},'Select a query image');
if filename ~= 0
    fFileName = fullfile(file,filename); 
    queImage=imread(fFileName);
%     axes(handles.axes7),imshow(queImage);
    msgbox('Image successfully selected','Query Remark','help');
    %RESIZE ORIGINAL IMAGE 
    im=imresize(queImage,[128 128]);

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
    load('imageFEAT.mat','-mat');
    %database of features of extracted images (query image inclusive) 
     R=length(imgs);
     for j=1:R
         D(j)=dist(fet',imgs(j).fat);
     end
     [value,index]=min(D);
       [sortedD, sortidx] = sort(D);
        ten_best_D = sortedD(1:10);
        ten_best_idx = sortidx(1:10);
%         montage(imgs(ten_best_idx), 'Size', [2 5], 'Parent', handles.axes6);
for g = 1:length(ten_best_idx)
    L(g) ={imgs(ten_best_idx(g)).name};
end
addpath(genpath('D:\MSc\Finals\CBIRS\ImageDatabase'))
% addpath(genpath('D:\MSc\Finals\CBIRS\IMAGES2'))
% IQ = montage(L, 'Size', [2 5]);
% imshow (IQ);
h = waitbar(0,'Searching Database for A Match...');
steps = 200;
for step = 1:steps
    waitbar(step / steps)
end
close(h) 
    if value<.001
         Y =(imgs(index).image);
         B = (imgs(index).name);
%                  imdisp (L);
     else
         Y = '';
         B = 'Image Not Recognised/No Matches Found';
       
     end
else
        msgbox('No Directory Selected.','Database result','help');
        B = 'No database';
end
end

