% ECE 486 Lab #3 - Task #2
% Authors:
%   Christian Auspland
%   Matthew Blanchard
%   Ben Grooms
% 
% This script stores the working pole/zero values obtained from the
% filter_design or filter_design_alt scripts, for plotting and later
% reference.

final_poles = [ ...
    0.404069767441861 + 0.773255813953489i, ...
    0.404069767441861 - 0.773255813953489i, ...
    0.578488372093023 + 0.767441860465116i, ...
    0.578488372093023 - 0.767441860465116i, ...
   -0.148255813953488 + 0.982558139534884i, ...
   -0.148255813953488 - 0.982558139534884i, ...
    0.159883720930233 + 0.813953488372094i, ...
    0.159883720930233 - 0.813953488372094i, ...
   -0.0145348837209303 + 0.674418604651163i, ...
   -0.0145348837209303 - 0.674418604651163i, ...
];

final_zeros = [ ...
    0.886627906976744 + 0.308139534883721i, ...
    0.886627906976744 - 0.308139534883721i, ...
    0.787790697674418 + 0.552325581395349i, ...
    0.787790697674418 - 0.552325581395349i, ...
   -0.845930232558140 + 0.383720930232558i, ...
   -0.845930232558140 - 0.383720930232558i, ...
   -0.592185053361829 + 0.793357966226374i, ...
   -0.592185053361829 - 0.793357966226374i, ...
    0.264534883720930 + 0.813953488372093i, ...
    0.264534883720930 - 0.813953488372093i, ...
];

% Unit circle
w = 0:1e-2:2*pi;
unit_circle = 1.0 .* exp(1j .* w);

% Pole-zero diagram
fig_pz_final = figure();
ax_pz_final = axes('Parent', fig_pz_final);
hold(ax_pz_final, 'on');
plot(ax_pz_final, real(unit_circle), imag(unit_circle));
plot(ax_pz_final, real(final_poles), imag(final_poles), 'rx');
plot(ax_pz_final, real(final_zeros), imag(final_zeros), 'go');
axis(ax_pz_final, 'square');
axis(ax_pz_final, [-1.5 1.5 -1.5 1.5]);
grid(ax_pz_final, 'on');
xlabel(ax_pz_final, 'Real');
ylabel(ax_pz_final, 'Imaginary');
title(ax_pz_final, 'Pole-zero Diagram');

% Create plot for the filter response
fig_response_final = figure();
ax_response_final = axes('Parent', fig_response_final);
hold(ax_response_final, 'on');
xlim(ax_response_final, [0 0.5]);
ylim(ax_response_final, [-60 30]);
xlabel(ax_response_final, 'Normalized Frequency');
ylabel(ax_response_final, 'Gain (dB)');
title(ax_response_final, 'Frequency Response');
grid(ax_response_final, 'on');

% Plot the frequency response of the entire filter
filt_num = poly(final_zeros);
filt_den = poly(final_poles);
k = 1 ./ filternorm(filt_num, filt_den);

f = -0.5:1e-3:0.5;
z = exp(-1j .* 2 .* pi .* f);
H = k .* (polyval(filt_num, z) ./ polyval(filt_den, z));
Hdb = 20 .* log10(abs(H));

cla(ax_response_final);
plot(ax_response_final, f, Hdb);

% Add regions of interest
region_1 = fill(ax_response_final, [0, 0, 0.1, 0.1], [-500, -40, -40, -500], 'k');
set(region_1, 'facealpha', 0.2);
region_2 = fill(ax_response_final, [0.15, 0.15, 0.2, 0.25, 0.25, 0.2], [1, -1, -6, -1, 1, -4], 'k');
set(region_2, 'facealpha', 0.2);
region_3 = fill(ax_response_final, [0.35, 0.35, 0.5, 0.5], [-500, -50, -50, -500], 'k');
set(region_3, 'facealpha', 0.2);
