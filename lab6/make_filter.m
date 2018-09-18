function Hd = make_filter
%RADAR_FILTER Generates coefficients for the lowpass filter for the DSP
%system for a doppler radar.

% Authors: (ECE 486 Group 8, Spring 2018)
%   Christian Auspland, Matt Blanchard, Ben Grooms, Hunter Smith

% All frequency values are in Hz.
Fs = 50e3;      % Sampling Frequency

Fpass = 2e3;    % Passband Frequency
Fstop = 6e3;   % Stopband Frequency
Apass = 0.5;     % Passband Ripple (dB)
Astop = 72;      % Stopband Attenuation (dB)
match = 'both';  % Band to match exactly

% Construct an FDESIGN object and call its ELLIP method.
h  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
Hd = design(h, 'ellip', 'MatchExactly', match);

for i = 1 : ceil(size(Hd.sosMatrix, 1))
    coeff((5*i - 4) : 5*i)= Hd.sosMatrix(i, [1:3,5:6]);
end
    
csvwrite('lowpass_coeff.csv', coeff);

% [EOF]
