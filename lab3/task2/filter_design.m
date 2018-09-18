% ECE 486 Lab #3 - Task #2
% Authors:
%   Christian Auspland
%   Matthew Blanchard
%   Ben Grooms
% 
% This script is designed to aid in the creation of a filter matching
% a set of requirements given in the lab handout

% Poles
filt_poles = [ ... 
    0.50 .* exp(1j .* 2 .* pi .* [-1, 1] .* 0.12), ...
    0.50 .* exp(1j .* 2 .* pi .* [-1, 1] .* 0.15), ...
    0.50 .* exp(1j .* 2 .* pi .* [-1, 1] .* 0.15), ...
    0.50 .* exp(1j .* 2 .* pi .* [-1, 1] .* 0.25), ...
    0.50 .* exp(1j .* 2 .* pi .* [-1, 1] .* 0.30), ...
];

% Zeros
filt_zeros = [ ... 
    0.99 .* exp(1j .* 2 .* pi .* [-1, 1] .* 0.00), ...
    0.99 .* exp(1j .* 2 .* pi .* [-1, 1] .* 0.10), ...
    0.50 .* exp(1j .* 2 .* pi .* [-1, 1] .* 0.20), ...
    0.99 .* exp(1j .* 2 .* pi .* [-1, 1] .* 0.35), ...
    0.99 .* exp(1j .* 2 .* pi .* [-1, 1] .* 0.50), ...
];

% Unit circle
w = 0:1e-2:2.*pi;
unit_circle = 1.0 .* exp(1j .* w);

% Pole-zero diagram
figure(1);
hold 'on';
plot(real(unit_circle), imag(unit_circle));
plot(real(filt_poles), imag(filt_poles), 'x');
plot(real(filt_zeros), imag(filt_zeros), 'o');
axis square;
axis([-1.5 1.5 -1.5 1.5]);
grid 'on';
xlabel 'Real';
ylabel 'Imaginary';
title 'Pole-zero diagram';

% Plot the frequency response of the entire filter
filt_num = poly(filt_zeros);
filt_den = poly(filt_poles);
k = 1 ./ filternorm(filt_num, filt_den);

f = -0.5:1e-3:0.5;
z = exp(-1j .* 2 .* pi .* f);
H = k .* (polyval(filt_num, z) ./ polyval(filt_den, z));
Hdb = 20 .* log10(abs(H));

figure(2);
hold 'on';
plot(f, Hdb);
xlim([0 0.5]);
ylim([-60 30]);
xlabel('Normalized Frequency');
ylabel('Gain (dB)');
title('Frequency Response');
grid 'on';

% Add regions of interest
region_1 = fill([0, 0, 0.1, 0.1], [-500, -40, -40, -500], 'k');
set(region_1, 'facealpha', 0.2);
region_2 = fill([0.15, 0.15, 0.2, 0.25, 0.25, 0.2], [1, -1, -6, -1, 1, -4], 'k');
set(region_2, 'facealpha', 0.2);
region_3 = fill([0.35, 0.35, 0.5, 0.5], [-500, -50, -50, -500], 'k');
set(region_3, 'facealpha', 0.2);

% Plot the impact of the gain
h = refline(0, (20 .* log10(k)));
h.LineStyle = '--';
h.Color = 'r';

% Plot the impact of all the poles
for i = 1:5
    poly_p = poly([filt_poles(2.*i - 1), filt_poles(2.*i)]);
    H_p = 1 ./ polyval(poly_p, z);
    H_pdb = 20 .* log10(abs(H_p));
    plot(f, H_pdb, ':');
end

% Plot the impact of all the poles
for j = 1:5
    poly_z = poly([filt_zeros(2.*j - 1), filt_zeros(2.*j)]);
    H_z = polyval(poly_z, z);
    H_zdb = 20 .* log10(abs(H_z));
    plot(f, H_zdb, ':');
end


