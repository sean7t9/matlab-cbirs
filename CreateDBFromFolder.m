function []= CreateDBFromFolder ()
%Option to Create database from a Object/Image Folder
folder_name = uigetdir(pwd, 'Select the directory of images');
% D = 'D:\MSc\Finals\CBIRS\ImageDatabase';
% imgs = dir(fullfile(folder_name,'obj*_*.png'));
imgs = [dir(fullfile(folder_name,'*.png')); dir(fullfile(folder_name,'*.jpg'))];

for k = 1:numel(imgs)
    imgs(k).image = imread(fullfile(folder_name,imgs(k).name));
end
save('coilDB.mat', 'imgs');
% msgbox('Database created Successfully, Proceed to LoadDB.','Database result','help');
Databasechoice = questdlg('Database Created Successfully, Would you like to Load It?', ...
	'Database Menu', ...
	'Yes','No','Yes');
% Handle response
switch Databasechoice
    case 'Yes'
        LoadDB();    
    case 'No thank you'
        disp('Ok')
end