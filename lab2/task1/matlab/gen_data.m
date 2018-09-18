% Test Script for running the FIR filtering functions. Generates sets
% of impulse coefficients which can be imported to the C test program.
% Plots the results of the C program's operations on the filter impulse
% response against the results calulated by MATLAB
%
% Authors: (ECE 486 Group 8, Spring 2018)
%   Christian Auspland, Matt Blanchard, Ben Grooms

% Test 1: 20 coefficient bandpass filter with cutoff freqs 10kHz and 20kHz
filter_1 = designfilt('bandpassfir','FilterOrder',19, ...
         'CutoffFrequency1',10e3,'CutoffFrequency2',20e3, ...
         'SampleRate',48e3);
%fvtool(filter_1)

[h_1, t_1] = impz(filter_1);      % Impulse coefficients (for use in C program)

% Test against a 10kHz sine wave
x_1 = sin(2.*pi.*(0:499).*10e3./48e3);
y_1 = filter(filter_1, x_1);
y_1c = csvread('output_20.csv');

% Plot & Compare Test 1 
figure(1);
grid 'on';
hold 'on';
plot(0:49, x_1(1:50), '-*');
plot(0:49, y_1(1:50), '-o');
plot(0:49, y_1c(1:50), '-x');
legend('Input', 'Output', 'C Program Output');
title('20 Coefficient FIR Bandpass Filter (Passband 10kHz -> 20kHz)');
xlabel('Sample');
ylabel('Amplitude');

% Test 2: 15 coefficient lowpass filter with cutoff freqs @ 1kHz
filter_2 = designfilt('lowpassfir','FilterOrder',14, ...
         'PassbandFrequency',1e3, 'StopbandFrequency', 2e3, ...
         'SampleRate', 48e3);
%fvtool(filter_2)

[h_2, t_2] = impz(filter_2);      % Impulse coefficients (for use in C program)

% Test against a 2kHz sine wave
x_2 = sin(2.*pi.*(0:499).*2e3./48e3);
y_2 = filter(filter_2, x_2);
y_2c = csvread('output_15.csv');

% Plot & Compare Test 2 
figure(2);
grid 'on';
hold 'on';
plot(0:49, x_2(1:50), '-*');
plot(0:49, y_2(1:50), '-o');
plot(0:49, y_2c(1:50), '-x');
legend('Input', 'Output', 'C Program Output');
title('15 Coefficient FIR Lowpass (Cutoff 1kHz)');
xlabel('Sample');
ylabel('Amplitude');

% Test 3: 10 coefficient highpass filter with cutoff freqs @ 3kHz
filter_3 = designfilt('highpassfir','FilterOrder', 9, ...
         'PassbandFrequency',3e3, 'StopbandFrequency', 300, ...
         'SampleRate', 48e3);
%fvtool(filter_3);

[h_3, t_3] = impz(filter_3);      % Impulse coefficients (for use in C program)

% Test against a 2kHz sine wave
x_3 = sin(2.*pi.*(0:499).*2e3./48e3);
y_3 = filter(filter_3, x_3);
y_3c = csvread('output_10.csv');

% Plot & Compare Test 3
figure(3);
grid 'on';
hold 'on';
plot(0:49, x_3(1:50), '-*');
plot(0:49, y_3(1:50), '-o');
plot(0:49, y_3c(1:50), '-x');
legend('Input', 'Output', 'C Program Output');
title('10 Coefficient FIR Highpass (Cutoff 3kHz)');
xlabel('Sample');
ylabel('Amplitude');

