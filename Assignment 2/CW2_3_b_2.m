% This code is used to find the dependence between order with MSPE
clear all; close all; clc;

N = 1000;
Fs = 1;
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
% delta = 3;
%LMS
mu = 0.01; 
% L = 5;
t0 = 500;
s = zeros(N,R);
X = zeros(N,R);
plts = [];
mspe = zeros(R,10);
MSPE = zeros(25,4);
for m = 1:20
    L = m;
    for i = 1:25
        delta = i;
%         figure(i);
        for r = 1:R
            % guassian noise
            white_noise = random('Normal', 0, sigma_2, N, 1);
            % signal
            x = signal' + filter(b, a, white_noise);
            s(:,r) = x;
            [x_hat,e,W] = ALE(x',mu,L,delta);
            X(:,r) = x_hat';
            % MSE
            mse(r) = mean((signal(t0:end) - x_hat(t0:end)).^2);            
        end

        mspe(:,i) = mse; 
    end
    MSPE(:,m) = mean(mspe);
end
%MSE vs order
figure; 
m = 1:20;
plot(m,MSPE(3,:));
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Order",'FontSize',20,'FontWeight','bold');
ylabel("MSPE",'FontSize',20,'FontWeight','bold');
grid on; grid minor;