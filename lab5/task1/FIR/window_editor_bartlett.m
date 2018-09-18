function varargout = window_editor_bartlett(varargin)
% WINDOW_EDITOR_BARTLETT MATLAB code for window_editor_bartlett.fig
%      WINDOW_EDITOR_BARTLETT, by itself, creates a new WINDOW_EDITOR_BARTLETT or raises the existing
%      singleton*.
%
%      H = WINDOW_EDITOR_BARTLETT returns the handle to a new WINDOW_EDITOR_BARTLETT or the handle to
%      the existing singleton*.
%
%      WINDOW_EDITOR_BARTLETT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WINDOW_EDITOR_BARTLETT.M with the given input arguments.
%
%      WINDOW_EDITOR_BARTLETT('Property','Value',...) creates a new WINDOW_EDITOR_BARTLETT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before window_editor_bartlett_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to window_editor_bartlett_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help window_editor_bartlett

% Last Modified by GUIDE v2.5 15-Apr-2018 21:59:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @window_editor_bartlett_OpeningFcn, ...
                   'gui_OutputFcn',  @window_editor_bartlett_OutputFcn, ...
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


% --- Executes just before window_editor_bartlett is made visible.
function window_editor_bartlett_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to window_editor_bartlett (see VARARGIN)

% Choose default command line output for window_editor_bartlett
handles.output = hObject;

% Update handles structure
set(handles.edit1,'string',evalin('base','WindowLangthBartlett'));
set(handles.edit2,'string',evalin('base','WindowAmplitudeBartlett'));
guidata(hObject, handles);

% UIWAIT makes window_editor_bartlett wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = window_editor_bartlett_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
WindowLangthBartlett = str2num(get(hObject,'String'));
assignin('base','WindowLangthBartlett',WindowLangthBartlett);

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
WindowAmplitudeBartlett = str2num(get(hObject,'String'));
assignin('base','WindowAmplitudeBartlett',WindowAmplitudeBartlett);


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
WindowAmplitudeBartlett = evalin('base','WindowAmplitudeBartlett');
WindowLangthBartlett = evalin('base','WindowLangthBartlett');
plot((0:WindowLangthBartlett-1),bartlett(WindowLangthBartlett).*WindowAmplitudeBartlett);
title('Time Domaine');
xlabel('Samples');
ylabel('Amplitude');
assignin('base','Window_num',bartlett(WindowLangthBartlett).*WindowAmplitudeBartlett);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
delete(gcf);
