clear all;close all;clc;

load 'time-series.mat';
%Parameters
N = length(y);
mu = 10^-7;
M = 4; %order
a = 50;

%pre-training
winit = zeros(1,M);
winit1 = zeros(1,M+1);
ypre = y(1:20);
for i = 1:100
    [~,~,wpre] = lms5_2(ypre,mu,M,a,winit1);
    winit1 = wpre(end,:);
end

[y_pre,e,wmat] = lms5_2(y,mu,4,50,winit1);
plot(y,'DisplayName','zero-mean signal');hold on;
plot(y_pre,'DisplayName','prediction signal');
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time index",'FontSize',20,'FontWeight','bold');
ylabel("Amplitude",'FontSize',20,'FontWeight','bold');
legend('show','FontSize',15,'FontWeight','bold');
grid on; grid minor;
%Calculate MSE
MSE = mean(e.^2);
sigma2_e = var(e(600:end));
sigma2_yp = var(y_pre(600:end));
Rp = pow2db(sigma2_yp/sigma2_e);

figure(2);
plot(e.^2);
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time index",'FontSize',20,'FontWeight','bold');
ylabel("Square Error",'FontSize',20,'FontWeight','bold');
grid on; grid minor;