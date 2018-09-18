function [y,s] = calc_running_mean(x,s)
%CALC_RUNNING_MEAN Calculate running mean of the input data block
% [y,s] = calc_running_mean(x,s) calculates the running mean of a given 
% block of samples, outputing to y, using stored values/parameters in 
% structure s. Structure s is updated for future calls
%  x: Input block of samples
%  s: Structure containing parameters/storage
%  y: Output block of samples

% Authors: Christian Auspland
%          Matt Blanchard
%          Ben Grooms
% ECE 486 - Running Mean Calculation Function
% February 3rd, 2018

% Allocate space for the output block
y = zeros(1, s.blocksize);

% Throw an error if the size of X does not match the blocksize
if (length(x) ~= s.blocksize)
    error("Size of input block does not match block size");
end

% Iterate through each value of x to create the running mean in y
for i = 1:length(x)
    
    sum = 0;  % Reset the sum to 0
    
    % If there are not enough previous values in x, some from the saved 
    % vector in s must be used
    if (i < s.M)
        
        % Add values from the vector stored in s
        for j = s.M:-1:(i+1)
           sum = sum + s.previous(j);
        end
        
        % Add remaining previous values from block x
        for j = i:-1:1
           sum = sum + x(j);
        end
    else 
        
        % Add M previous values (including the current value) of x
        for j = i:-1:(i - s.M + 1)
            sum = sum + x(j);
        end
    end
    
    % Compute the running mean and assign it to the corresponding y value
    y(i) = sum ./ s.M;
end

% Save values from this input block to s for future calls. If the blocksize
% is smaller than the size of the previous values vector, move older values
% back.
if (s.blocksize < s.M)
    for i = s.M:-1:(s.blocksize + 1)
       s.previous(i - s.blocksize) = s.previous(i); 
    end
    for i = 1:1:s.blocksize
       s.previous(s.M - s.blocksize + 1) = x(i);
    end
else
    for i = s.blocksize:-1:(s.blocksize - s.M + 1)
       s.previous(i - s.blocksize + s.M) = x(i); 
    end
end   
end

