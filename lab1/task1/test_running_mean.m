% Test Script for the running_mean signal processing functions.
% This script generates a few input signals and processes them using the
% running_mean functions. Input/output signals are plotted for comparison
% to verify the functions' operation.
%
% Authors: (ECE 486 Group 8, Spring 2018)
%   Christian Auspland, Matt Blanchard, Ben Grooms

% Test 1: A staircase function running from 1 - 50. Blocksize is set to 10
% and mean range is set to 5.

% Generate input samples
staircase_input = 1:1:50;

% Run the staircase signal through running_mean
staircase_output = process_running_mean(staircase_input, 10, 5);

% Plot both the input and output signals
figure(1);
hold 'on';
grid 'on';
plot(1:50, staircase_input);
plot(1:50, staircase_output);
legend('Input', 'Output');
title('Running Mean - Staircase Function (Block Size = 10, M = 5)');
xlabel('Sample');
ylabel('Amplitude');

% Test 2: A sine wave with an amplitude of 10 and a frequency of 50
% samples/cycle. Blocksize is 100, mean range is varied from 25 to 100 in
% increments of 25.
n = 1:200;
sine_input = sin((2.*pi./50).*n);

% Run each the sine wave through running_mean with each mean range
figure(2);
hold 'on';
grid 'on';
plot(n, sine_input);
for k = 1:4
    sine_output = process_running_mean(sine_input, 100, 25.*k);
    plot(n, sine_output);
end
legend('Input', 'Output M=25', 'Output M=50', 'Output M=75', 'Output M=100');
title('Running Mean - Sine Function (Block Size = 100, M = 25-100)');
xlabel('Sample');
ylabel('Amplitude');

% Test 3: A set of sine waves of of amplitude 10, with frequency
% increasing from 100 samples/cycle to 25 samples/cycle. Block size is 100,
% mean range is 15
n = 1:300;

figure(3);

sine_input_100 = 10.*sin(2.*pi./100.*n);
sine_input_75 = 10.*sin(2.*pi./75.*n);
sine_input_50 = 10.*sin(2.*pi./50.*n);
sine_input_25 = 10.*sin(2.*pi./25.*n);

sine_output_100 = process_running_mean(sine_input_100, 100, 15);
sine_output_75 = process_running_mean(sine_input_75, 100, 15);
sine_output_50 = process_running_mean(sine_input_50, 100, 15);
sine_output_25 = process_running_mean(sine_input_25, 100, 15);

subplot(2,2,4);
hold 'on';
grid 'on';
plot(n, sine_input_100);
plot(n, sine_output_100);
title("F = 100 samples/cycle");
xlabel("Sample");
ylabel("Amplitude");
legend("Input", "Output");

subplot(2,2,3);
hold 'on';
grid 'on';
plot(n, sine_input_75);
plot(n, sine_output_75);
title("F = 75 samples/cycle");
xlabel("Sample");
ylabel("Amplitude");
legend("Input", "Output");

subplot(2,2,2);
hold 'on';
grid 'on';
plot(n, sine_input_50);
plot(n, sine_output_50);
title("F = 50 samples/cycle");
xlabel("Sample");
ylabel("Amplitude");
legend("Input", "Output");

subplot(2,2,1);
hold 'on';
grid 'on';
plot(n, sine_input_25);
plot(n, sine_output_25);
title("F = 25 samples/cycle");
xlabel("Sample");
ylabel("Amplitude");
legend("Input", "Output");