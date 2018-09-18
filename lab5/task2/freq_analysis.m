% ECE 486 Lab #5 - Task #2
% Authors:
%   Christian Auspland
%   Matthew Blanchard
%   Ben Grooms
%   Hunter Smith
% 
% This script analyses an arbitrary array of sampled signal data to
% decompose it into its component signals, using DFT, windowing, and zero
% padding techniques

x_n = csvread('data.txt');
Fs = 500e+3;

% Take the 2^22 point DFT of the data
N = 2.^22;
X_k = fft(x_n, N);

% Determine the frequency each sample corresponds with
n = 0:N-1;      % 2^22 samples
f_n = n ./ N;   % Normalized freq
f = f_n .* Fs;  % Actual frequency

% Plot the result and observe the peaks
figure(1);
plot(f./1000, 20.*log10(abs(X_k)));
xlim([0 Fs/2000]);
grid 'on';
ylabel('Amplitude (dB)');
xlabel('Frequency (kHz)');
title("2^{24} Point DTFT of x[n]");

npeaks = 2;
windows = [85e+3 90e+3 95e+3 100e+3];
for i = 1:npeaks
    n_low = ceil((windows(2*i-1) ./ Fs) * N);
    n_high = ceil((windows(2*i) ./ Fs) * N);
    [mag_peak, n_peak] = max(abs(X_k(n_low:n_high)));
    f_peak(i) = f(n_low + n_peak);
    A_peak(i) = abs(mag_peak) * 2 / N;
    
    figure(1 + i);
    plot(f./1000, 20.*log10(abs(X_k)));
    hold 'on';
    xlim([windows(2*i-1)/1e+3 windows(2*i)/1e+3]);
    grid 'on';
    ylabel('Amplitude (dB)');
    xlabel('Frequency (kHz)');
    title("2^{24} Point DTFT of x[n]");
 end