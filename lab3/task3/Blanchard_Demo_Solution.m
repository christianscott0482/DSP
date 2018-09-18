% This script is intended to take an arbitrary collection of poles, zeros,
% and a gain coefficient to be formatted into second-order sections for use
% in C code.
%
% Authors: (ECE 486 Group 8, Spring 2018)
%   Christian Auspland, Matt Blanchard, Ben Grooms

% Set of zeros(arbitrary)
z = [ ...
-0.823729791394465 + 0.549153194262977i, ...
-0.823729791394465 - 0.549153194262977i, ...
-0.957725947521866 + 0.262390670553936i, ...
-0.957725947521866 - 0.262390670553936i, ...
];

% Set of poles(arbitrary)
p = [ ...
0.319241982507289 + 0.437317784256560i, ...
0.319241982507289 - 0.437317784256560i, ...
-0.205539358600583 + 0.953352769679301i, ...
-0.205539358600583 - 0.953352769679301i, ...
];

% Gain factor(arbitrary)
k = 0.1202;

sos = zp2sos(z, p, k);

for i = 1 : ceil(size(z, 2) / 2)
    coeff((5*i - 4) : 5*i)= sos(i, [1:3,5:6]);
end
    
csvwrite('task_3.csv', coeff);
    

