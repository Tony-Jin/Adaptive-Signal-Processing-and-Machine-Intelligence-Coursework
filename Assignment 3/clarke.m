function vc = clarke(v)
% Clarke Matrix
C = sqrt(2/3) * [sqrt(2)/2 sqrt(2)/2 sqrt(2)/2; 1 -1/2 -1/2; 0 sqrt(3)/2 -sqrt(3)/2 ];
% Clarke Transformation
vc = C * v; 
end