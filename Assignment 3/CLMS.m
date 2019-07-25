function [y,error,H] = CLMS(x,d,mu,M)
N = length(x);
X = zeros(M+N-1,1);
X(M:end) = x;
H = zeros(M,N+1);
error = zeros(N,1);
y = zeros(N,1);

for i = 1:N
    xn = X(i:i+M-1);
%     xn = xn.';
    y(i) = H(:,i)'*xn;
    error(i) = d(i) - y(i);
    H(:,i+1) = H(:,i) + mu*conj(error(i))*xn;
end
H = H(:, 2:end);
end
