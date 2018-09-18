% Test Script for evaluating the receiver front end for Lab 4 Task 2
%
% Authors: (ECE 486 Group 8, Spring 2018)
%   Christian Auspland, Matt Blanchard, Ben Grooms
%
% Date: 3/25/2018

fc = 12e+3;                 % Carrier frequency
fs = 50e+3;                 % Sampling frequency
lowpass = lowpass_filter(); % Lowpass filter

% Test Case 1: Pure 13kHz sine wave
n = 0:1023;
input_1 = sin(2.*pi.*n.*13e+3./fs);

% Mixer stage
[mixer_1_re, mixer_1_im] = mixer(input_1, fc./fs, 0);

% Lowpass filter stage
output_1_re = filter(lowpass, mixer_1_re);
output_1_im = filter(lowpass, mixer_1_im);

% Plotting
figure(1);
title("Test Case 1: Pure 12kHz Sinusoid");
xlabel("Sample");
ylabel("Amplitude");
axis([0 1000 -0.6 0.6]);
grid("on");
hold("on");
plot(n, output_1_re);
plot(n, output_1_im);
legend("Real", "Imaginary");

% Test Case 2: Sum of cosines and sines
n = 0:1023;
input_2 = ...
    0.25.*cos(2.*pi.*n.*10.5e+3./fs) ...
  + 0.45.*sin(2.*pi.*n.*11.0e+3./fs) ...
  + 0.65.*cos(2.*pi.*n.*11.5e+3./fs) ...
  + 0.70.*sin(2.*pi.*n.*12.0e+3./fs) ...
  + 0.80.*sin(2.*pi.*n.*12.5e+3./fs) ...
  + 0.15.*sin(2.*pi.*n.*13.0e+3./fs) ...
  + 0.30.*sin(2.*pi.*n.*11.0e+3./fs);

% Mixer stage
[mixer_2_re, mixer_2_im] = mixer(input_2, fc./fs, 0);

% Lowpass filter stage
output_2_re = filter(lowpass, mixer_2_re);
output_2_im = filter(lowpass, mixer_2_im);

% Plotting
figure(2);
title("Test Case 1: Sum of sine & cosines");
xlabel("Sample");
ylabel("Amplitude");
axis([0 1000 -0.6 0.6]);
grid("on");
hold("on");
plot(n, output_2_re);
plot(n, output_2_im);
legend("Real", "Imaginary");

