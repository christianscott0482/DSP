function [real, imag] = mixer(input, f0, nstart)
%MIXER Mixes a signal block, multiplying it by exp(-j2pi*f0*n)

cos_factor = cos(2.*pi.*f0.* (nstart + [0:length(input)-1]));
sin_factor = sin(2.*pi.*f0.* (nstart + [0:length(input)-1]));

real = input .* cos_factor;
imag = input .* sin_factor;

end
