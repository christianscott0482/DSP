function varargout = window_editor_taylor(varargin)
% WINDOW_EDITOR_TAYLOR MATLAB code for window_editor_taylor.fig
%      WINDOW_EDITOR_TAYLOR, by itself, creates a new WINDOW_EDITOR_TAYLOR or raises the existing
%      singleton*.
%
%      H = WINDOW_EDITOR_TAYLOR returns the handle to a new WINDOW_EDITOR_TAYLOR or the handle to
%      the existing singleton*.
%
%      WINDOW_EDITOR_TAYLOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WINDOW_EDITOR_TAYLOR.M with the given input arguments.
%
%      WINDOW_EDITOR_TAYLOR('Property','Value',...) creates a new WINDOW_EDITOR_TAYLOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before window_editor_taylor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to window_editor_taylor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help window_editor_taylor

% Last Modified by GUIDE v2.5 16-Apr-2018 09:26:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @window_editor_taylor_OpeningFcn, ...
                   'gui_OutputFcn',  @window_editor_taylor_OutputFcn, ...
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


% --- Executes just before window_editor_taylor is made visible.
function window_editor_taylor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to window_editor_taylor (see VARARGIN)

% Choose default command line output for window_editor_taylor
handles.output = hObject;

% Update handles structure
set(handles.edit1,'string',evalin('base','WindowLangthTaylor'));
set(handles.edit2,'string',evalin('base','WindowAmplitudeTaylor'));
set(handles.edit3,'string',evalin('base','WindowBetaTaylor'));
set(handles.edit4,'string',evalin('base','WindowSidelobeLevelTaylor'));
guidata(hObject, handles);

% UIWAIT makes window_editor_taylor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = window_editor_taylor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
WindowLangthTaylor = str2num(get(hObject,'String'));
assignin('base','WindowLangthTaylor',WindowLangthTaylor);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
WindowAmplitudeTaylor = str2num(get(hObject,'String'));
assignin('base','WindowAmplitudeTaylor',WindowAmplitudeTaylor);


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
WindowAmplitudeTaylor = evalin('base','WindowAmplitudeTaylor');
WindowLangthTaylor = evalin('base','WindowLangthTaylor');
WindowBetaTaylor = evalin('base','WindowBetaTaylor');
WindowSidelobeLevelTaylor = evalin('base','WindowSidelobeLevelTaylor');
plot((0:WindowLangthTaylor-1),taylorwin(WindowLangthTaylor,WindowBetaTaylor,WindowSidelobeLevelTaylor).*WindowAmplitudeTaylor);
title('Time Domaine');
xlabel('Samples');
ylabel('Amplitude');
assignin('base','Window_num',taylorwin(WindowLangthTaylor,WindowBetaTaylor,WindowSidelobeLevelTaylor).*WindowAmplitudeTaylor);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
delete(gcf);

function edit3_Callback(hObject, eventdata, handles)
WindowBetaTaylor = str2num(get(hObject,'String'));
assignin('base','WindowBetaTaylor',WindowBetaTaylor);

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
WindowSidelobeLevelTaylor = str2num(get(hObject,'String'));
assignin('base','WindowSidelobeLevelTaylor',WindowSidelobeLevelTaylor);


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
