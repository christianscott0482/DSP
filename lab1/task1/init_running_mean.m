function s = init_running_mean(M, blocksize)
%INIT_RUNNING_MEAN Initialize the parameter/storage structure for calc_running_mean.
% s = init_running_mean(M, blocksize)
%  M: The number of samples to calculate the running mean over
%  blocksize: Sample size of input blocks
%  s: Returned structure which will hold data between input blocks

% Authors: Christian Auspland
%          Matt Blanchard
%          Ben Grooms
% ECE 486 - Running Mean Initialization Function
% February 3rd, 2018

% The structure s stores a vector of M previous values of an input block,
% the blocksize, and the value of M for use in the calc_running_mean
% function.
s = struct('previous', zeros(1,M), 'blocksize', blocksize, 'M', M);

end

