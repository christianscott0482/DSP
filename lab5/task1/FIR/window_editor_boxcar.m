function varargout = window_editor_boxcar(varargin)
% WINDOW_EDITOR_BOXCAR MATLAB code for window_editor_boxcar.fig
%      WINDOW_EDITOR_BOXCAR, by itself, creates a new WINDOW_EDITOR_BOXCAR or raises the existing
%      singleton*.
%
%      H = WINDOW_EDITOR_BOXCAR returns the handle to a new WINDOW_EDITOR_BOXCAR or the handle to
%      the existing singleton*.
%
%      WINDOW_EDITOR_BOXCAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WINDOW_EDITOR_BOXCAR.M with the given input arguments.
%
%      WINDOW_EDITOR_BOXCAR('Property','Value',...) creates a new WINDOW_EDITOR_BOXCAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before window_editor_boxcar_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to window_editor_boxcar_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help window_editor_boxcar

% Last Modified by GUIDE v2.5 15-Apr-2018 23:37:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @window_editor_boxcar_OpeningFcn, ...
                   'gui_OutputFcn',  @window_editor_boxcar_OutputFcn, ...
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


% --- Executes just before window_editor_boxcar is made visible.
function window_editor_boxcar_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to window_editor_boxcar (see VARARGIN)

% Choose default command line output for window_editor_boxcar
handles.output = hObject;

% Update handles structure
set(handles.edit1,'string',evalin('base','WindowLangthBoxcar'));
set(handles.edit2,'string',evalin('base','WindowAmplitudeBoxcar'));
guidata(hObject, handles);

% UIWAIT makes window_editor_boxcar wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = window_editor_boxcar_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
WindowLangthBoxcar = str2num(get(hObject,'String'));
assignin('base','WindowLangthBoxcar',WindowLangthBoxcar);

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
WindowAmplitudeBoxcar = str2num(get(hObject,'String'));
assignin('base','WindowAmplitudeBoxcar',WindowAmplitudeBoxcar);


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
WindowAmplitudeBoxcar = evalin('base','WindowAmplitudeBoxcar');
WindowLangthBoxcar = evalin('base','WindowLangthBoxcar');
plot((0:WindowLangthBoxcar-1),boxcar(WindowLangthBoxcar).*WindowAmplitudeBoxcar);
title('Time Domaine');
xlabel('Samples');
ylabel('Amplitude');
assignin('base','Window_num',boxcar(WindowLangthBoxcar).*WindowAmplitudeBoxcar);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
delete(gcf);
