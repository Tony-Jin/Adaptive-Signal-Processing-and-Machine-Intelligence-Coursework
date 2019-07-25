function [y,e,wmat] = lms4_2(x,u,L,a)
%e is the error; L*1
%wmat represents the weight vector; N*L
%x is the adaptive filter input% N*1
%d is he desired response signal% N*1
%u is the adaptation gain; scalar
%L is the order of filter; scalar
N = length(x);
e = zeros(N,1);    %e(k) is the error of kth iteration
X = zeros(N+L,1);
X(L+1:N+L) = x;
wmat1 = zeros(N,L+1);
bias = 1;
for i = 1:N
    xn = zeros(L,1);
    xn = [bias;X(i+L-1:-1:i)];
    s = wmat1(i,:)*xn;
    y(i) = a*tanh(s);
    d = X(i+L);
    e(i) = d - y(i);
    %Update weights
%     wmat1(i+1,:) = wmat1(i,:) + u*(xn.')*e(i);
    wmat1(i+1,:) = wmat1(i,:) + u*a*(1-(tanh(s).^2))*(xn.')*e(i);
    %wmat1(i+1,:) = (1-u*0.2)*wmat1(i,:) + u*(xn.')*e(i);
end

wmat = wmat1(2:N+1,:);

end