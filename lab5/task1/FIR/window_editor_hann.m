function varargout = window_editor_hann(varargin)
% WINDOW_EDITOR_HANN MATLAB code for window_editor_hann.fig
%      WINDOW_EDITOR_HANN, by itself, creates a new WINDOW_EDITOR_HANN or raises the existing
%      singleton*.
%
%      H = WINDOW_EDITOR_HANN returns the handle to a new WINDOW_EDITOR_HANN or the handle to
%      the existing singleton*.
%
%      WINDOW_EDITOR_HANN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WINDOW_EDITOR_HANN.M with the given input arguments.
%
%      WINDOW_EDITOR_HANN('Property','Value',...) creates a new WINDOW_EDITOR_HANN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before window_editor_hann_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to window_editor_hann_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help window_editor_hann

% Last Modified by GUIDE v2.5 16-Apr-2018 00:34:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @window_editor_hann_OpeningFcn, ...
                   'gui_OutputFcn',  @window_editor_hann_OutputFcn, ...
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


% --- Executes just before window_editor_hann is made visible.
function window_editor_hann_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to window_editor_hann (see VARARGIN)

% Choose default command line output for window_editor_hann
handles.output = hObject;

% Update handles structure
set(handles.edit1,'string',evalin('base','WindowLangthHann'));
set(handles.edit2,'string',evalin('base','WindowAmplitudeHann'));
guidata(hObject, handles);

% UIWAIT makes window_editor_hann wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = window_editor_hann_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function edit1_Callback(hObject, eventdata, handles)
WindowLangthHann = str2num(get(hObject,'String'));
assignin('base','WindowLangthHann',WindowLangthHann);

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
WindowAmplitudeHann = str2num(get(hObject,'String'));
assignin('base','WindowAmplitudeHann',WindowAmplitudeHann);

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
WindowAmplitudeHann = evalin('base','WindowAmplitudeHann');
WindowLangthHann = evalin('base','WindowLangthHann');
WindowTypeHann = evalin('base','WindowTypeHann');
plot((0:WindowLangthHann-1),hann(WindowLangthHann,WindowTypeHann)*WindowAmplitudeHann);
title('Time Domaine');
xlabel('Samples');
ylabel('Amplitude');
assignin('base','Window_num',hann(WindowLangthHann,WindowTypeHann)*WindowAmplitudeHann);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
delete(gcf);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject,'String'));% returns popupmenu1 contents as cell array
WindowTypeHann = contents{get(hObject,'Value')};% returns selected item from popupmenu1
assignin('base','WindowTypeHann',WindowTypeHann);

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
