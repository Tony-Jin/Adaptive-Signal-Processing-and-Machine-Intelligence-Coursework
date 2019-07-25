clear all; close all; clc;
%number of samples
N = 1000;
%number of realizations
t = 100;
%Coefficients
mu = [0.05 0.01];
a = [0.1 0.8];
sigma2 = 0.25;
gamma = 0.1;
%simulation
model = arima("Constant", 0, "AR", a, "Variance", sigma2);
x = simulate(model, N, "NumPaths", t);
[m,n] = size(x);
error1 = zeros(size(x));
error2 = zeros(size(x));
W1 = zeros(1000,2);
W2 = zeros(1000,2);
for i = 1:100
    [e1,wmat1] = Leakylms(x(:,i),mu(1),2,gamma);
    W1 = W1 + wmat1;
    error1(:,i) = e1;
    MSE1(i) = mean(e1(400:end).^2);
    Memse1(i) =  MSE1(i)/sigma2 - 1;
end

for ii = 1:100
    [e2,wmat2] = Leakylms(x(:,ii),mu(2),2,gamma);
    W2 = W2 + wmat2;
    error2(:,ii) = e2;
    MSE2(ii) = mean(e2(400:end).^2);
    Memse2(ii) =  MSE2(ii)/sigma2 - 1;
end
%Calculate the mean of coefficients
step = 1:1000;
W1 = W1./100;
W2 = W2./100;
%Draw figures
plot(step,W2(:,1),"DisplayName",sprintf("lms-a2"),'LineWidth',2);
hold on
plot(step,W2(:,2),"DisplayName",sprintf("lms-a1"),'LineWidth',2);
hold on
plot([1 1000],[0.8 0.8],'--',"DisplayName",sprintf("a1"),'LineWidth',2);
hold on
plot([1,1000],[0.1 0.1],'--',"DisplayName",sprintf("a2"),'LineWidth',2);
title(sprintf("mu:%.2f  gamma:%.1f", mu(2),gamma),'FontSize',15,'FontWeight','bold');
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
lgd = legend("show",'FontSize',15,'FontWeight','bold');
xlabel("Time Index",'FontSize',20,'FontWeight','bold');
ylabel("Filter Weights",'FontSize',20,'FontWeight','bold');
ylim([-0.1 0.9]);
yticks(-0.1:0.2:0.9);
grid on; grid minor;