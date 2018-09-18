% butter_iir.m
% Authors: Christian Auspland, Matthew Blanchard, Ben Grooms, Hunter Smith
Fs = 48e3;              % Sampling Frequency
lband = (11.85e3/Fs)*2;  % Left Normalized Cutoff Frequency
rband = (15.15e3/Fs)*2;  % Right Normalized Frequency
n = 16;                 % Filter order
k = 10.^(10.05/20);      % Passband Gain

[b,a] = butter(n,[lband rband],'bandpass');

f = 0:1e-2:(Fs/2);
z = exp(1j .* 2 .* pi .* (f/Fs));
H = k .* (polyval(b, z) ./ polyval(a, z));
Hdb = 20 .* log10(abs(H));

figure(2);
% Lower stopband
patch([0  11.2 11.2 0], [-100 -100 -60 -60], [0.6 0.6 0.6]);
hold 'on';

% Passband
patch([12 15 15 12], [9.9 9.9 10.1 10.1], [0.6 0.6 0.6]);

% Upper stopband
patch([16  Fs/2/1e+3 Fs/2/1e+3 16], [-100 -100 -60 -60], [0.6 0.6 0.6]);

plot(f./1e+3, Hdb);
grid 'on';
title 'Gain of H(f)'
xlabel 'Frequency (kHz)';
ylabel '|H(f)| (dB)';
%xlim([0 Fs/2/1e+3]);
ylim([-80 20]);
