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
for ii = 1:100
    [e1,wmat] = lms(x(:,ii),mu(1),2);
    error1(:,ii) = e1;
end

for ii = 1:100
    [e2,wmat] = lms(x(:,ii),mu(2),2);
    error2(:,ii) = e2;
end
%Calculate the MSE
sqerror1 = error1.^2;
sqerror2 = error2.^2;
mean_e1 = sum(sqerror1,2)/100;
mean_e2 = sum(sqerror2,2)/100;
step = 1:N;
%Draw figure
figure(2);
plot(step,pow2db(mean_e1),"DisplayName",sprintf("mu=%.2f",mu(1)));
hold on;
plot(step,pow2db(mean_e2),"DisplayName",sprintf("mu=%.2f",mu(2)));
lgd = legend("show",'FontSize',15,'FontWeight','bold');
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time Index",'FontSize',20,'FontWeight','bold');
ylabel("Squared Prediction Error (dB)",'FontSize',20,'FontWeight','bold');
grid on; grid minor;
figure(1);
plot(pow2db(mean(e1.^2,2)),"DisplayName",sprintf("mu=%.2f",mu(1)));
hold on;
plot(pow2db(mean(e2.^2,2)),"DisplayName",sprintf("mu=%.2f",mu(2)));
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
lgd = legend("show",'FontSize',15,'FontWeight','bold');
xlabel("Time Index",'FontSize',20,'FontWeight','bold');
ylabel("Squared Prediction Error (dB)",'FontSize',20,'FontWeight','bold');
grid on; grid minor;

