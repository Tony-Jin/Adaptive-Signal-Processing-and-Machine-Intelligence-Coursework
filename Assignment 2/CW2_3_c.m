clear all;close all;clc;
%1 for ALE; %2 for ANG
N = 1000;
% Fs = 1;
R = 50;
%signal
A = 1;
fw = 0.01*pi;
t = 0:N-1;
signal = sin(fw*t);
%noise
sigma_2 = 1;
%filter
b = [1 0 0.5];
a = 1;
%LMS
mu = 0.005; 
% L = 5;
t0 = 500;
s = zeros(N,R);
X2 = zeros(N,R);
X1 = zeros(N,R);
plts = [];
mspe1 = zeros(R,10);
mspe2 = zeros(R,10);
MSPE1 = zeros(25,4);
MSPE2 = zeros(25,4);
L = 5;
delta = 3;
 for r = 1:R
    % guassian noise
    white_noise = random('Normal', 0, sigma_2, N, 1);
    eta = filter(b, a, white_noise);
    epsilon = eta * 0.8 + 0.08;
    % signal
    x = signal' + eta;
    s(:,r) = x;
    %ALE
    [x_hat1,e1,W1] = ALE(x',mu,L,delta);
    X1(:,r) = x_hat1';
    % MSE
    mse1(r) = mean((signal(t0:end) - x_hat1(t0:end)).^2);
    % ANC
    [noise_e,e2,W2] = ANC(epsilon,x,mu,L);
    x_hat2 = x' - noise_e;
    X2(:,r) = x_hat2;
    % MSE
    mse2(r) = mean((signal(t0:end) - x_hat2(t0:end)).^2);
 end
 MSPE1 = mean(mse1);
 MSPE2 = mean(mse2);
%ALE
figure(1);
for r = 1:R
    plts(1)=plot(t,s(:,r),'b',"DisplayName","Input signal");
    hold on;
end
for r = 1:R
    plts(2)=plot(t,X1(:,r),'r',"DisplayName","ALE");
    hold on;
end
plts(3)=plot(t,signal,'y',"DisplayName","clean signal");
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time Index",'FontSize',20,'FontWeight','bold');
ylabel("Amplitude",'FontSize',20,'FontWeight','bold');
title(sprintf("delta = %d,order = %d, MSPE=%.4f", delta, L, MSPE1));
lgd = legend(plts,'FontSize',15,'FontWeight','bold');
grid on; grid minor;

%ANC
figure(2);
for r = 1:R
    plts(1)=plot(t,s(:,r),'b',"DisplayName","Input signal");
    hold on;
end
for r = 1:R
    plts(2)=plot(t,X2(:,r),'r',"DisplayName","ANC");
    hold on;
end
plts(3)=plot(t,signal,'y',"DisplayName","clean signal");
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time Index",'FontSize',20,'FontWeight','bold');
ylabel("Amplitude",'FontSize',20,'FontWeight','bold');
title(sprintf("Order = %d, MSPE=%.4f", L, MSPE2));
lgd = legend(plts,'FontSize',15,'FontWeight','bold');
grid on; grid minor;
%Compare ALE, ANC and clean sinal
figure(3)
ALE = mean(X1,2);
ANC = mean(X2,2);
plot(t,signal,"DisplayName","clean signal");hold on;
plot(t,ALE,"DisplayName","ALE");hold on;
plot(t,ANC,"DisplayName","ANC");
xlabel("Time Index",'FontSize',20,'FontWeight','bold');
ylabel("Amplitude",'FontSize',20,'FontWeight','bold');
lgd = legend("show",'FontSize',15,'FontWeight','bold');
grid on; grid minor;