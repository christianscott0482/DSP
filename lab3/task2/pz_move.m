function pz_move(curPos)
%PZ-MOVE Callback function for impoint movement on the PZ diagram. 
%
% Authors:
%   Chrisitan Auspland
%   Matthew Blanchard
%   Ben Grooms
%
% This callback is attached to the pole/zero impoints, and will run each
% time one of the poles/zeros is moved. This function converts all
% poles/zeros to complex conjugate pairs, then uses them to construct/plot
% the filter response.

% Global variales
global pole_num;            % Number of poles
global filt_poles;          % Collection of pole impoints
global zero_num;            % Number of zeros
global filt_zeros;          % Collection of zero impoints
global placement_complete;  % Flag indicating if pole/zero placement is complete
global ax_response;         % Axes for the filter response plot
global true_poles;          % The true values of the poles
global true_zeros;          % The true values of the zeros

% If poles/zeros haven't all been placed yet, we can't create the response
if (placement_complete ~= true) 
   return; 
end

% Contruct the poles/zeros. For each pole/zero, use the x coordinate as the real part 
% and the y coordinate as the imaginary part. Add the complex conjugate
% pair to the array
true_poles = zeros(1, pole_num * 2);
for k = 1:pole_num
    pole_pos = filt_poles(k).getPosition();
    true_poles(2*k - 1) = pole_pos(1) + 1j*pole_pos(2);
    true_poles(2*k) = conj(true_poles(2*k - 1));
end

true_zeros = zeros(1, zero_num * 2);
for k = 1:zero_num
    zero_pos = filt_zeros(k).getPosition();
    true_zeros(2*k - 1) = zero_pos(1) + 1j*zero_pos(2);
    true_zeros(2*k) = conj(true_zeros(2*k - 1));
end

% Plot the frequency response of the entire filter
filt_num = poly(true_zeros);
filt_den = poly(true_poles);
k = 1 ./ filternorm(filt_num, filt_den);

f = -0.5:1e-3:0.5;
z = exp(-1j .* 2 .* pi .* f);
H = k .* (polyval(filt_num, z) ./ polyval(filt_den, z));
Hdb = 20 .* log10(abs(H));

cla(ax_response);
plot(ax_response, f, Hdb);

% Add regions of interest
region_1 = fill(ax_response, [0, 0, 0.1, 0.1], [-500, -40, -40, -500], 'k');
set(region_1, 'facealpha', 0.2);
region_2 = fill(ax_response, [0.15, 0.15, 0.2, 0.25, 0.25, 0.2], [1, -1, -6, -1, 1, -4], 'k');
set(region_2, 'facealpha', 0.2);
region_3 = fill(ax_response, [0.35, 0.35, 0.5, 0.5], [-500, -50, -50, -500], 'k');
set(region_3, 'facealpha', 0.2);

end

