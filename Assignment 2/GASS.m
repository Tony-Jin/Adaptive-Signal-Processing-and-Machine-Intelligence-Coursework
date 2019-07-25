function [e, W] = GASS(x, d, mu_0, rho, algo,L)
%x is the input signal;
%d is the desired signal;
%mu_0 is the initial step;
%rho is the learning rate;
%algo is the type of phi updating method
%L is the order of system
N = length(x);
e = zeros(N,1);
W = zeros(N+1,L);
mu = zeros(N+1,1);
mu(1) = mu_0;
y = zeros(N,1);
phi = zeros(L,N+1);
alpha = 0.8;

X = zeros(N+L-1,1);
X(L:N+L-1) = x;

for i = 1:N
    xn = zeros(L,1);
    xn = X(i:i+L-1);
    y(i) = W(i,:)*xn;
    e(i) = d(i) - y(i);
    W(i+1,:) = W(i,:) + mu(i)*(xn.')*e(i);
    mu(i+1) = mu(i) + rho*e(i)*(xn.')*phi(:,i);
    switch algo
       case "benvenist"
           phi(:, i+1) = (eye(L) - mu(i) * xn * (xn.')) * phi(:, i) + e(i) * xn;
       case "ang_farhang"
           phi(:, i+1) = alpha * phi(:, i) + e(i) * xn;
       case "matthews_xie"
           phi(:,i+1) = e(i)*xn;
    end
    
end

W = W(2:end,:);

end