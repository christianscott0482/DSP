% Test Script for evaluating the receiver front end for Lab 4 Task 1
%
% Authors: (ECE 486 Group 8, Spring 2018)
%   Christian Auspland, Matt Blanchard, Ben Grooms
%
% Date: 3/25/2018

fc = 12e+3;                 % Carrier frequency
fs = 50e+3;                 % Sampling frequency

real_data = csvread('task1_test_r.csv');
im_data = csvread('task1_test_i.csv');

% Test Case: Pure 12kHz sine wave
n = 0:1023;
input_1 = sin(2.*pi.*n.*12e+3./fs);

% Mixer stage
[mixer_1_re, mixer_1_im] = mixer(input_1, fc./fs, 0);

% Plotting
figure(1);
hold on;
title("Test Case: Pure 12kHz Sinusoid Real");
xlabel("Sample");
ylabel("Amplitude");
axis([0 124 -0.6 0.6]);
grid("on");
plot(n(1:128), mixer_1_re(1:128), 'LineWidth', 5);
plot(n(1:128), real_data(1:128), 'LineWidth', 2);
legend("Matlab", "C");


figure(2);
hold on;
title("Test Case: Pure 12kHz Sinusoid Imaginary");
xlabel("Sample");
ylabel("Amplitude");
axis([0 124 -0.1 1.1]);
grid on;
plot(n(1:128), mixer_1_im(1:128), 'LineWidth', 5);
plot(n(1:128), im_data(1:128), 'LineWidth', 2);
legend("Matlab", "C");
