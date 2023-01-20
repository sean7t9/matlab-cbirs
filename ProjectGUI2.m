function varargout = ProjectGUI2(varargin)
% PROJECTGUI2 MATLAB code for ProjectGUI2.fig
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProjectGUI2_OpeningFcn, ...
                   'gui_OutputFcn',  @ProjectGUI2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ProjectGUI2 is made visible.
function ProjectGUI2_OpeningFcn(hObject, eventdata, handles, varargin)
%Create tab group
handles.tgroup = uitabgroup('Parent', handles.figure1,'TabLocation', 'top');
handles.tab1 = uitab('Parent', handles.tgroup, 'Title', 'Query Panel');
handles.tab2 = uitab('Parent', handles.tgroup, 'Title', 'Manage Database');
%handles.tab3 = uitab('Parent', handles.tgroup, 'Title', 'My Tab Label 3');
%Place panels into each tab
%Reposition each panel to same location as panel 1
set(handles.uipanel1,'Parent',handles.tab1)
set(handles.pushbutton1,'Parent',handles.tab1)
set(handles.uipanel4,'Parent',handles.tab1)
set(handles.uipanel2,'Parent',handles.tab2)
set(handles.uipanel3,'Parent',handles.tab2)
set(handles.uipanel5,'Parent',handles.tab2)
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = ProjectGUI2_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
varargout{1} = handles.output;


%READ IMAGE BUTTON
function pushbutton1_Callback(hObject, eventdata, handles)
clc;
%[filename, file] = uigetfile('*', '');
[filename, file] = uigetfile ({'*.jpg';'*.png';'*.*'},'Select a query image');
%filename = uigetfile displays a modal dialog box that lists files in the current folder and
%enables you to select or enter the name of a file. If the file name is 
%valid (and the file exists), uigetfile returns the file name when you click Open. 
%If you click Cancel (or the window's close box), uigetfile returns 0.
if filename ~= 0
    fFileName = fullfile(file,filename); 
    % Create a Full File Path on Windows 
    %|fullfile| returns a character vector containing the full path to the file.
    f=imread(fFileName);
    axes(handles.axes7),imshow(f);
    msgbox('Image succesfully selected','Query Remark','help');    
else
    warndlg('Input image must be selected.',' Warning ')
end


%SAVE INPUTNAME BUTTON
function pushbutton2_Callback(hObject, eventdata, handles) 
sampleimage = getimage(handles.axes6);
samplename = get(handles.edit1,'String');
set(handles.edit1,'string',"");
pause(1);
cla(handles.axes6)
if isempty(samplename)
    warndlg('Invalid Input',' Warning ');
else
    saveDatabase(sampleimage,samplename);
end

%DATABASE INFO BUTTON
function pushbutton3_Callback(hObject, eventdata, handles)
getDatabaseInfo();

%DELETE DATABASE BUTTON
function pushbutton4_Callback(hObject, eventdata, handles)
deleteDatabase();

%TEXTBOX TAKES IMAGE INPUT NAME
function edit1_Callback(hObject, eventdata, handles)

%TEXTBOX TAKES IMAGE INPUT NAME
function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% QUERY IMAGE BUTTON
function pushbutton5_Callback(hObject, eventdata, handles)
image = getimage(handles.axes7);
set(handles.text6,'string',"");
result = regImage(image);
axes(handles.axes1),imshow(image);
set(handles.text6,'string',result);


% --------------------------------------------------------------------
function about_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function author_Callback(hObject, eventdata, handles)
msgbox(sprintf('Project Title: Content-Based Image Retrieval System using Combined Features of Edge, Colour and Texture\nName: ALO, Oluwaseun Adewunmi\nMatric No: 201549\nSession Admitted: 2016/2017\nSupervised by: Dr. A. R. Zubair\n© 2018'),'Author','Help');


% --------------------------------------------------------------------
function manage_database_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function database_info_Callback(hObject, eventdata, handles)
getDatabaseInfo();


% DELETE DATABASE BUTTON--------------------------------------------------------------------
function delete_database_Callback(hObject, eventdata, handles)
deleteDatabase();


%SELECT QUERY IMAGE
function pushbutton11_Callback(hObject, eventdata, handles)

clc;
%[filename, file] = uigetfile('*', '');
[filename, file] = uigetfile ({'*.jpg';'*.png';'*.*'},'Select an image');
%filename = uigetfile displays a modal dialog box that lists files in the current folder and
%enables you to select or enter the name of a file. If the file name is 
%valid (and the file exists), uigetfile returns the file name when you click Open. 
%If you click Cancel (or the window's close box), uigetfile returns 0.
if filename ~= 0
    fFileName = fullfile(file,filename); 
    j=imread(fFileName);
    p = waitbar(0,'Please Wait...');
steps = 200;
for step = 1:steps
    waitbar(step / steps)
end
close(p) 
    axes(handles.axes6),imshow(j);
    msgbox('Image succesfully selected','Query Remark','help');     
else
    warndlg('Input image must be selected.',' Warning ')
end

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)


function edit3_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
CreateDBFromFolder();


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
LoadDB();


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
cla(handles.axes1)
set(handles.text6,'string',"");
[LQ,  Pic, Str] = queryImageFromLoadedDB();
axes(handles.axes1),imshow(Pic);
set(handles.text6,'string',Str);
pause(3);
% Construct a questdlg with two options
if strcmp(Str,'Image Not Recognised/No Matches Found')
  else
MontageChoice = questdlg('Would you like to view the 10 other similar objects?', ...
	'Alert', ...
	'Yes, Show Me','No thank you','Yes, Show Me');
% Handle response
        switch MontageChoice
            case 'Yes, Show Me'
                disp([MontageChoice ' Coming Up.'])
                try
                    axes(handles.axes1), montage (LQ, 'Size', [2 5]);
                catch
                    msgbox({'Montaged Images can not fit into the display Panel' 
                        'Images to be displayed are not the same dimensions/sizes' 
                        'Click OK or Press any key to display images in an external window'},'CBIRS Tip','warn');
                    w = waitforbuttonpress;
                    if w == 0
                    disp('Button click')
                     imdisp(LQ);
                    else
                    disp('Key press')
                     imdisp(LQ);
                    end
        %             imdisp(LQ);
                end

            case 'No thank you'
                disp('Ok')
        end
end


% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
close (ProjectGUI2);
