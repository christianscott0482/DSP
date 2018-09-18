function varargout = new_gui(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @new_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @new_gui_OutputFcn, ...
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


% --- Executes just before new_gui is made visible.
function new_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to new_gui (see VARARGIN)

% Choose default command line output for new_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes new_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = new_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = cellstr(get(hObject,'String'));% returns popupmenu1 contents as cell array
Window = contents{get(hObject,'Value')};% returns selected item from popupmenu1
assignin('base','Window',Window);


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

function PassF_Callback(hObject, eventdata, handles)
% hObject    handle to PassF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PassBands = str2num(get(hObject,'String'));
assignin('base','PassBands',PassBands);




% --- Executes during object creation, after setting all properties.
function PassF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PassF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function StopF_Callback(hObject, eventdata, handles)
% hObject    handle to StopF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
StopBands = str2num(get(hObject,'String'));
assignin('base','StopBands',StopBands);



% --- Executes during object creation, after setting all properties.
function StopF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StopF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in ContinueButton0.
function ContinueButton0_Callback(hObject, eventdata, handles)
evalin('base','fir_calc');

% --- Executes on button press in ExitButton0.
function ExitButton0_Callback(hObject, eventdata, handles)
% hObject    handle to ExitButton0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
evalin('base','clear WindowAmplitudeBartlett');
evalin('base','clear WindowLangthBartlett');
evalin('base','clear WindowAmplitudeBlackman');
evalin('base','clear WindowLangthBlackman');
evalin('base','clear WindowAmplitudeBoxcar');
evalin('base','clear WindowLangthBoxcar');
evalin('base','clear WindowSidelobeChebyshev');
evalin('base','clear WindowLangthChebyshev');
evalin('base','clear WindowAmplitudeHamming');
evalin('base','clear WindowLangthHamming');
evalin('base','clear WindowTypeHamming');
evalin('base','clear WindowAmplitudeHann');
evalin('base','clear WindowLangthHann');
evalin('base','clear WindowTypeHann');
evalin('base','clear WindowAmplitudeTaylor');
evalin('base','clear WindowLangthTaylor');
evalin('base','clear WindowBetaTaylor');
evalin('base','clear WindowSidelobeLevelTaylor');
evalin('base','clear WindowAmplitudeKaiser');
evalin('base','clear WindowLangthKaiser');
evalin('base','clear WindowAmplitudeKaiser');
evalin('base','clear WindowBetaBaiser');
evalin('base','clear WindowBetaKaiser');
evalin('base','clear a');
evalin('base','clear b');
evalin('base','clear f');
evalin('base','clear F');
evalin('base','clear Fs');
evalin('base','clear H');
evalin('base','clear Hd');
evalin('base','clear Hdr');
evalin('base','clear k');
evalin('base','clear M');
evalin('base','clear N');
evalin('base','clear NormalizedPassBands');
evalin('base','clear NormalizedStopBands');
evalin('base','clear PassBands');
evalin('base','clear StopBands');
evalin('base','clear SamplingFrequency');
evalin('base','clear StopGain');
evalin('base','clear PassGain');
evalin('base','clear hd');
evalin('base','clear Window');
evalin('base','clear Window_num');
delete(gcf);



function PassG_Callback(hObject, eventdata, handles)
% hObject    handle to PassG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PassGain = str2num(get(hObject,'String'));
assignin('base','PassGain',PassGain);



% --- Executes during object creation, after setting all properties.
function PassG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PassG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over ExitButton0.
function ExitButton0_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to ExitButton0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function StopG_Callback(hObject, eventdata, handles)
% hObject    handle to StopG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StopG as text
%        str2double(get(hObject,'String')) returns contents of StopG as a double
StopGain = str2num(get(hObject,'String'));
assignin('base','StopGain',StopGain);




% --- Executes during object creation, after setting all properties.
function StopG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StopG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SamplingFrequency_Callback(hObject, eventdata, handles)
% hObject    handle to SamplingFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SamplingFrequency as text
%        str2double(get(hObject,'String')) returns contents of SamplingFrequency as a double
SamplingFrequency = str2num(get(hObject,'String'));
assignin('base','SamplingFrequency',SamplingFrequency);




% --- Executes during object creation, after setting all properties.
function SamplingFrequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SamplingFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% Normalize the frequencies.
PassBands = evalin('base','PassBands');
StopBands = evalin('base','StopBands');
PassGain = evalin('base','PassGain');
StopGain = evalin('base','StopGain');
SamplingFrequency = evalin('base','SamplingFrequency');

if PassBands(1) > 1 && StopBands(1) > 1
    PassBands = PassBands/SamplingFrequency;
    StopBands = StopBands/SamplingFrequency;
    assignin('base','PassBands',PassBands);
    assignin('base','StopBands',StopBands);
end

figure;
hold on;
title('Desired Frequency Responce');
xlabel('Frequency (Hz)');
ylabel('Magnitude H_d(f)');

for a = 1:2:(size(PassBands,2))
    patch([PassBands(a+1) PassBands(a) PassBands(a) PassBands(a+1)],[PassGain(a+1) PassGain(a+1) PassGain(a) PassGain(a)], 0.7*[1,1,1]);
end

for b = 1:2:(size(StopBands,2))
    patch([StopBands(b+1) StopBands(b) StopBands(b) StopBands(b+1)],[StopGain(b+1) StopGain(b+1) StopGain(b) StopGain(b)], 0.7*[0,1,1]);
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
PassBands = evalin('base','PassBands');
StopBands = evalin('base','StopBands');
PassGain = evalin('base','PassGain');
StopGain = evalin('base','StopGain');
SamplingFrequency = evalin('base','SamplingFrequency');

if PassBands(1) > 1 || StopBands(1) > 1
    PassBands = PassBands/SamplingFrequency;
    StopBands = StopBands/SamplingFrequency;
    assignin('base','NormalizedPassBands',PassBands);
    assignin('base','NormalizedStopBands',StopBands);
end

figure;
hold on;
title('Desired Frequency Responce');
xlabel('Frequency (Hz)');
ylabel('Magnitude H_d(f)');

for a = 1:2:(size(PassBands,2))
    patch([PassBands(a+1) PassBands(a) PassBands(a) PassBands(a+1)],[PassGain(a+1) PassGain(a+1) PassGain(a) PassGain(a)], 0.7*[1,1,1]);
end

for b = 1:2:(size(StopBands,2))
    patch([StopBands(b+1) StopBands(b) StopBands(b) StopBands(b+1)],[StopGain(b+1) StopGain(b+1) StopGain(b) StopGain(b)], 0.7*[0,1,1]);
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
my_windower


% --- Executes during object creation, after setting all properties.
function pushbutton5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit7_Callback(hObject, eventdata, handles)
N = str2num(get(hObject,'String'));
assignin('base','N',N);


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
