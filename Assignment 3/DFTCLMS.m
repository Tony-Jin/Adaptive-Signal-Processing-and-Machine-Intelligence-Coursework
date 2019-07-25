function [y, error, H] = DFTCLMS(x, d, mu, gamma)
% sizes
[m, n] = size(x);
% filter output: init
y = zeros(size(d));
% prediction error: init
error = zeros(size(d));
% CLMS filter weights: init
H = zeros(m, n);
    
% iterate over time
for i=1:n
    % filter output n, y(n)
    y(i) = H(:, i)' * x(:, i);
    % prediction error n, e(n)
    error(i) = d(i) - y(i);
    % weights update rule
    H(:, i+1) = (1 - gamma * mu) *H(:, i) + mu * conj(error(i)) * x(:, i);
end
H = H(:, 2:end);
end