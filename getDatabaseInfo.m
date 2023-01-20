function [  ] = getDatabaseInfo(  )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
clc;
if (exist('imageDatabase.mat')==2)
    load('imageDatabase.mat','-mat');
    msgbox('Database is not empty','Database result','help');
else
    msgbox('Database is empty.','Database result','help');
end

end

