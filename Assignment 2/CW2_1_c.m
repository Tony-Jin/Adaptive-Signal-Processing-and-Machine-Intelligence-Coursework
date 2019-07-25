clear all; close all; clc;
%number of samples
N = 1000;
%number of realizations
t = 100;
%Coefficients
mu = [0.05 0.01];
a = [0.1 0.8];
sigma2 = 0.25;
%simulation
model = arima("Constant", 0, "AR", a, "Variance", sigma2);
x = simulate(model, N, "NumPaths", t);
[m,n] = size(x);
error1 = zeros(size(x));
error2 = zeros(size(x));
for i = 1:100
    [e1,wmat] = lms(x(:,i),mu(1),2);
    error1(:,i) = e1;
    MSE1(i) = mean(e1(600:end).^2);
    Memse1(i) =  (MSE1(i)/sigma2) - 1;
end

for ii = 1:100
    [e2,wmat] = lms(x(:,ii),mu(2),2);
    error2(:,ii) = e2;
    MSE2(ii) = mean(e2(400:end).^2);
    Memse2(ii) =  (MSE2(ii)/sigma2) - 1;
end
%Calculate mean EMSE
MEMSE1 = mean(Memse1);%0.0462
MEMSE2 = mean(Memse2);%0.0076