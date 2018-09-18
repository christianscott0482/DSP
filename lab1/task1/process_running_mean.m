function out_vals = process_running_mean(in_vals, blocksize, M)
%PROCESS_RUNNING_MEAN Runs an input signal through the running_mean system.
% out_vals = process_running_mean(in_vals, blocksize, M) runs input signal
% in_vals through the running_mean system with parameters blocksize and M.
%   in_vals: Vector of sample values from the input signal
%   blocksize: The blocksize of samples to be used during processing
%   M: The range the running mean should be taken over

% Authors: Christian Auspland
%          Matt Blanchard
%          Ben Grooms
% ECE 486 - Running Mean Processing Function
% February 3rd, 2018

out_vals = zeros(1, length(in_vals));

% Initialize with the inter-block structure with the given mean range and
% blocksize.
s = init_running_mean(M, blocksize);

% Run the input signal through the running_mean system block by block.
for i = 1:blocksize:(length(in_vals) - blocksize + 1)
    [y, s] = calc_running_mean(in_vals(i:(i+blocksize-1)), s);
    out_vals(i:(i+blocksize-1)) = y;
end
end

