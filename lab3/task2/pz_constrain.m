function newPos = pz_constrain(curPos)
%PZ_CONSTRAIN Callback function to constrain movement of the PZ impoints
%
% Authors:
%   Christian Auspland
%   Matthew Blanchard
%   Ben Grooms
%
% This function constains pole/zero movement by forcing them to be stable
% (within and not on the unit circle). If a pole/zero is moved outside the
% unit circle, this function will preserve their angle while forcing them
% to a magnitude of 0.9900

% X represents the real part, Y the imaginary part
point = curPos(1) + 1j.*curPos(2);

% If the magnitude of the point is greater than or equal to 1, reduce it to
% 0.9999 while preserving the angle
if (abs(point) >= 1)
    point = point ./ (abs(point));
    point = point .* 0.9900;
end

newPos(1) = real(point);
newPos(2) = imag(point);

end

