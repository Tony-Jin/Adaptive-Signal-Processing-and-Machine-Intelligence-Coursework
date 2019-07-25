clear all;close all;clc;

load 'time-series.mat';
%Parameter
mu = 10^-5;
y_z = y - mean(y);
[y_pre,e,wmat] = lms(y_z,mu,4);

figure(1);
plot(y_z,'DisplayName','zero-mean signal');hold on;
plot(y_pre,'DisplayName','prediction signal');
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time index",'FontSize',20,'FontWeight','bold');
ylabel("Amplitude",'FontSize',20,'FontWeight','bold');
legend('show','FontSize',15,'FontWeight','bold');
grid on; grid minor;
%Calculate MSE
MSE = mean(e.^2);
sigma2_e = var(e(500:end));
sigma2_yp = var(y_pre(500:end));
Rp = pow2db(sigma2_yp/sigma2_e);

figure(2);
plot(e.^2);
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time index",'FontSize',20,'FontWeight','bold');
ylabel("Square Error",'FontSize',20,'FontWeight','bold');
grid on; grid minor;
