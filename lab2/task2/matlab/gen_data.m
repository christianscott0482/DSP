% Test script to validate the functionality of the biquad filter functions.
% This script is tasked with generating filter data (coefficients, input
% values, output values) to test against the C program.
%
% Authors: (ECE 486 Group 8, Spring 2018)
%   Christian Auspland, Matt Blanchard, Ben Grooms

% Test 1: 6th order buttersworth filter @ 48ksps and a cutoff frequency of
% 1kHz
fc_1 = 1e3;           % Cutoff @ 1kHz
fs_1 = 48e3;          % 48ksps 

% Generate the filter
[z, p, k] = butter(6, fc_1/(fs_1/2));
SOS_1 = zp2sos(z, p, k);

Hd_1 = dfilt.df2sos(SOS_1);

% Pass a 2 kHz sine wave through
n_1 = 0:99;
x_1 = sin(2.*pi.*(2000./fs_1).*n_1);
y_1 = filter(Hd_1, x_1);

% Test 2: 10th order buttersworth @ 48ksps and a cutoff of 5kHz
fc_2 = 5e3;           % Cutoff @ 5kHz
fs_2 = 48e3;           % 48ksps 

% Generate the filter
[z, p, k] = butter(10, fc_2/(fs_2/2));
SOS_2 = zp2sos(z, p, k);

Hd_2 = dfilt.df2sos(SOS_2);

% Pass a 5 kHz sine wave through
n_2 = 0:99;
x_2 = sin(2.*pi.*(5000./fs_2).*n_2);
y_2 = filter(Hd_2, x_2);

% Read C output for comparison
y_1c = csvread('output_6.csv');
y_2c = csvread('output_10.csv');

% Plot/Compare
figure(1);
hold 'on';
grid 'on';
plot(n_1, x_1, '-*');
plot(n_1, y_1, '-o');
plot(n_1, y_1c, 'x');
legend('Input', 'Output', 'C Output');
title('IIR Lowpass Filter with cutoff @ 1kHz');
xlabel('Sample');
ylabel('Amplitude');
xlim([0e3 100]);
ylim([-1.5 1.5]);

figure(2);
hold 'on';
grid 'on';
plot(n_2, x_2, '-*');
plot(n_2, y_2, '-o');
plot(n_2, y_2c, '-x');
legend('Input', 'Output', 'C Output');
title('IIR Lowpass Filter with cutoff @ 5kHz');
xlabel('Sample');
ylabel('Amplitude');
xlim([0e3 100]);
ylim([-1.5 1.5]);


