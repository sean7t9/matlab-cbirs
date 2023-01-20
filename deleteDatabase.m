function [  ] = deleteDatabase(  )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
clc;
if (exist('imageDatabase.mat')==2)
    button = questdlg('Do you really want to remove the Database?','Remove Database');
    if strcmp(button,'Yes')
        delete('imageDatabase.mat');
        msgbox('Database was succesfully removed from the current directory.','Database removed','help');
    end
else
    warndlg('Database is empty.',' Warning ')
end

end

