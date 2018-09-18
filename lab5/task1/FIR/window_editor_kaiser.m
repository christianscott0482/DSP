function varargout = window_editor_kaiser(varargin)
% WINDOW_EDITOR_KAISER MATLAB code for window_editor_kaiser.fig
%      WINDOW_EDITOR_KAISER, by itself, creates a new WINDOW_EDITOR_KAISER or raises the existing
%      singleton*.
%
%      H = WINDOW_EDITOR_KAISER returns the handle to a new WINDOW_EDITOR_KAISER or the handle to
%      the existing singleton*.
%
%      WINDOW_EDITOR_KAISER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WINDOW_EDITOR_KAISER.M with the given input arguments.
%
%      WINDOW_EDITOR_KAISER('Property','Value',...) creates a new WINDOW_EDITOR_KAISER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before window_editor_kaiser_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to window_editor_kaiser_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help window_editor_kaiser

% Last Modified by GUIDE v2.5 16-Apr-2018 00:50:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @window_editor_kaiser_OpeningFcn, ...
                   'gui_OutputFcn',  @window_editor_kaiser_OutputFcn, ...
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


% --- Executes just before window_editor_kaiser is made visible.
function window_editor_kaiser_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to window_editor_kaiser (see VARARGIN)

% Choose default command line output for window_editor_kaiser
handles.output = hObject;

% Update handles structure
set(handles.edit1,'string',evalin('base','WindowLangthKaiser'));
set(handles.edit2,'string',evalin('base','WindowAmplitudeKaiser'));
set(handles.edit3,'string',evalin('base','WindowBetaKaiser'));
guidata(hObject, handles);

% UIWAIT makes window_editor_kaiser wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = window_editor_kaiser_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
WindowLangthKaiser = str2num(get(hObject,'String'));
assignin('base','WindowLangthKaiser',WindowLangthKaiser);

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
WindowAmplitudeKaiser = str2num(get(hObject,'String'));
assignin('base','WindowAmplitudeKaiser',WindowAmplitudeKaiser);


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
WindowAmplitudeKaiser = evalin('base','WindowAmplitudeKaiser');
WindowLangthKaiser = evalin('base','WindowLangthKaiser');
WindowBetaKaiser = evalin('base','WindowBetaKaiser');
plot((0:WindowLangthKaiser-1),kaiser(WindowLangthKaiser,WindowBetaKaiser).*WindowAmplitudeKaiser);
title('Time Domaine');
xlabel('Samples');
ylabel('Amplitude');
assignin('base','Window_num',kaiser(WindowLangthKaiser,WindowBetaKaiser).*WindowAmplitudeKaiser);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
delete(gcf);

function edit3_Callback(hObject, eventdata, handles)
WindowBetaKaiser = str2num(get(hObject,'String'));
assignin('base','WindowBetaKaiser',WindowBetaKaiser);

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
