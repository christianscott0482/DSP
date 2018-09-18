%  ECE 486 Lab #5 - Task #1
%
%  Authors:
%   Christian Auspland
%   Matthew Blanchard
%   Ben Grooms
%   Hunter Smith
% 
%  This script calls a script that edits the default window paramiters.

Window = evalin('base','Window');

switch Window
    case 'Bartlett'
        window_editor_bartlett
    case 'Blackman'
        window_editor_blackman
    case 'Boxcar'
        window_editor_boxcar
    case 'Chebyshev'
        window_editor_chebyshev
    case 'Hamming'
        window_editor_hamming
    case 'Hann'
        window_editor_hann
    case 'Kaiser'
        window_editor_kaiser
    case 'Taylor'
        window_editor_taylor
    otherwise
       disp('Select A Window Method First!');
end