function [  ] = saveDatabase( im, inputname)
%Summary of this function goes here

%Pre-Processing Operation for ORIGINAL images goes here
%Images pre-processed here are saved to the Database
clc;
%RESIZE ORIGINAL IMAGE 
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

%SAVING TO PRE-PROCESSED ORIGINAL IMAGE TO DATABASE
a = struct('feature',fet,'name',inputname);
if exist ('im')
    if (exist('imageDatabase.mat')==2)
        load('imageDatabase.mat','-mat');
        qty=qty+1;
        qImage{qty,1} = fet;
        qImage{qty,2} = inputname;
        save('imageDatabase.mat','qImage','qty','-append');
        msgbox('Image succesfully added','Database result','help');
        clear('im');
    else
        qty=1;
        qImage{qty,1} = fet;
        qImage{qty,2} = inputname;
        dataset;
        save('imageDatabase.mat','qImage','qty');
        msgbox (sprintf('Database has just been created\nImage succesfully added'),'Database result','help');
        clear('im');
    end
end
end
