% Script to design Elliptic IIR filters
%
% Authors: (ECE 486 Group 8, Spring 2018)
%   Christian Auspland, Matt Blanchard, Ben Grooms, Hunter Smith

Fs = 48e+3;             % Sampling frequency
n  = 7;                 % Filter order
Rp = 0.1;               % Passband ripple (dB)
Rs = 70;                % Stopband ripple (dB)
Fp = [12e+3 15e+3];     % Cutoff frequencies
Wp = (2 * Fp / Fs);     % Cutoff frequencies (normalized)
ftype = 'bandpass';     % Filter type
k = 10.^(10/20);        % Passband gain

[b, a] = ellip(n, Rp, Rs, Wp, ftype);

figure(1);
clf;
freqz(b, a);

f = 0:1e-2:(Fs/2);
z = exp(1j .* 2 .* pi .* (f/Fs));
H = k .* (polyval(b, z) ./ polyval(a, z));
Hdb = 20 .* log10(abs(H));
Hphase = angle(H);

figure(2);
clf;
subplot(2, 1, 1);

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
xlim([0 Fs/2/1e+3]);
ylim([-80 20]);

subplot(2, 1, 2);
plot(f./1e+3, Hphase);
grid 'on';
title 'Phase of H(f)'
xlabel 'Frequency (kHz)';
ylabel 'Phase (degrees)';

