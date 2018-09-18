% Script for analyzing/plotting the output of the C program from task 2 of
% lab 1. For this script to work, the .csv output of the C program must be
% present in the same directory (run the C program first)
%
% Authors: (ECE 486 Group 8, Spring 2018)
%   Christian Auspland, Matt Blanchard, Ben Grooms

% Test 1: A ramp function. Plot the input dataset vs. the output dataset
input_ramp = csvread('input_ramp.csv');
output_ramp = csvread('output_ramp.csv');
figure(1);
hold 'on';
grid 'on';
plot(0:499, input_ramp);
plot(0:499, output_ramp);
title("Task 2 Test Case: Ramp Function");
legend("Input", "Output");
xlabel("Sample");
ylabel("Value");

% Test 2: A sine waves of 25-100 samples/cycle. Plot the input dataset vs. the output dataset
sine_input_100 = csvread('input_sine_100.csv');
sine_input_75 = csvread('input_sine_75.csv');
sine_input_50 = csvread('input_sine_50.csv');
sine_input_25 = csvread('input_sine_25.csv');

sine_output_100 = csvread('output_sine_100.csv');
sine_output_75 = csvread('output_sine_75.csv');
sine_output_50 = csvread('output_sine_50.csv');
sine_output_25 = csvread('output_sine_25.csv');

figure(2);
subplot(2,2,4);
hold 'on';
grid 'on';
plot(0:499, sine_input_100);
plot(0:499, sine_output_100);
title("F = 100 samples/cycle");
xlabel("Sample");
ylabel("Amplitude");
legend("Input", "Output");

subplot(2,2,3);
hold 'on';
grid 'on';
plot(0:499, sine_input_75);
plot(0:499, sine_output_75);
title("F = 75 samples/cycle");
xlabel("Sample");
ylabel("Amplitude");
legend("Input", "Output");

subplot(2,2,2);
hold 'on';
grid 'on';
plot(0:499, sine_input_50);
plot(0:499, sine_output_50);
title("F = 50 samples/cycle");
xlabel("Sample");
ylabel("Amplitude");
legend("Input", "Output");

subplot(2,2,1);
hold 'on';
grid 'on';
plot(0:499, sine_input_25);
plot(0:499, sine_output_25);
title("F = 25 samples/cycle");
xlabel("Sample");
ylabel("Amplitude");
legend("Input", "Output");