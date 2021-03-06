% This script is intended to take an arbitrary collection of poles, zeros,
% and a gain coefficient to be formatted into second-order sections for use
% in C code.
%
% Authors: (ECE 486 Group 8, Spring 2018)
%   Christian Auspland, Matt Blanchard, Ben Grooms

% Set of zeros(arbitrary)
z = [ ...
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

% Set of poles(arbitrary)
p = [ ...
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

% Gain factor(arbitrary)
k = 0.0212;

sos = zp2sos(z, p, k);

for i = 1 : ceil(size(z, 2) / 2)
    coeff((5*i - 4) : 5*i)= sos(i, [1:3,5:6]);
end
    
csvwrite('task_3.csv', coeff);
    

