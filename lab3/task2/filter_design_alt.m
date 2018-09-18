% ECE 486 Lab #3 - Task #2
% Authors:
%   Christian Auspland
%   Matthew Blanchard
%   Ben Grooms
% 
% This script is an alterantive to the original filter_design script.
% Instead of changing poles/zeros manually by changing values/reruning the
% script, this script makes use of impoints on the pole zero diagram to
% allow for real-time, interactive pole/zero modification.

% Global variables. These need to be global to be accessible from callbacks
global pole_num;        % Number of poles
pole_num = 5;
global filt_poles;      % Collection of pole impoints
global true_poles;      % The true values of the poles

global zero_num;        % Number of zeros
zero_num = 5;
global filt_zeros;      % Collection of zero impoints
global true_zeros;      % The true values of the zeros

global placement_complete;  % Flag indiciating if all poles/zeros have been placed
global ax_response;         % Response plot axes

% Unit circle
w = 0:1e-2:2*pi;
unit_circle = 1.0 .* exp(1j .* w);

% Pole-zero diagram
fig_pz = figure(1);
ax_pz = axes('Parent', fig_pz);
plot(ax_pz, real(unit_circle), imag(unit_circle));
hold(ax_pz, 'on');
axis(ax_pz, 'square');
axis(ax_pz, [-1.5 1.5 -1.5 1.5]);
grid(ax_pz, 'on');
xlabel(ax_pz, 'Real');
ylabel(ax_pz, 'Imaginary');
title(ax_pz, 'Pole-zero Diagram (Poles are RED, Zeros are GREEN)');



% Add poles and zeros as interactive "impoints"
pz_constrain_handle = @pz_constrain;
pz_move_handle = @pz_move;
placement_complete = false;
for i = 1:pole_num
    filt_poles(i) = impoint();
    filt_poles(i).setColor('r');
    setPositionConstraintFcn(filt_poles(i), pz_constrain_handle);
    addNewPositionCallback(filt_poles(i),pz_move_handle);
end
for i = 1:zero_num
    filt_zeros(i) = impoint();
    filt_zeros(i).setColor('g');
    setPositionConstraintFcn(filt_zeros(i), pz_constrain_handle);
    addNewPositionCallback(filt_zeros(i),pz_move_handle);
end
placement_complete = true;

% Create plot for the filter response
fig_response = figure(2);
ax_response = axes('Parent', fig_response);
hold(ax_response, 'on');
xlim(ax_response, [0 0.5]);
ylim(ax_response, [-60 30]);
xlabel(ax_response, 'Normalized Frequency');
ylabel(ax_response, 'Gain (dB)');
title(ax_response, 'Frequency Response');
grid(ax_response, 'on');
