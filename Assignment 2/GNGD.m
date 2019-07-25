function [e,wmat] = GNGD(x,d,mu,rho,L)
%x is the input signal
%d is the desired signal;
%mu is the step size
%rho is the learning rate
%L is the order of the system
N = length(x);
e = zeros(N,1);
X = zeros(N+L-1,1);
X(L:N+L-1) = x;
y = zeros(N,1);
wmat = zeros(N+1,L);
theta = ones(N+1,1)/mu;
% theta(1) = 1/mu;
xn = zeros(L,N);
for i = 1:N
%     if i>1
%         xnp = xn;
%     end
    xn(:,i) = X(i:i+L-1);
    y(i) = wmat(i,:)*xn(:,i);
    e(i) = d(i) - y(i);
    wmat(i+1,:) = wmat(i,:) + (e(i)*xn(:,i)/(theta(i)+(xn(:,i).')*xn(:,i))).';
    if i > 1
        theta(i+1) = theta(i) - rho*mu*e(i)*e(i-1)*(xn(:,i).')*xn(:,i-1)/(theta(i-1)+(xn(:,i-1).')*xn(:,i-1)).^2;
    end
end

wmat = wmat(2:end,:);

end