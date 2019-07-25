% This code is used to find the dependence between delay with MSPE
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
t0 = 500;%Used to calculate the Rp from the 500th term
s = zeros(N,R);
X = zeros(N,R);
plts = [];
mspe = zeros(R,10);
MSPE = zeros(25,4);
for m = 5:5:20
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
            plts(1) = plot(t,x,'b',"DisplayName","input signal");
            hold on;

        end
        for r = 1:R
            plts(2)=plot(t,X(:,r),'r',"DisplayName","ALE");
            hold on;
        end
        plts(3)=plot(t,signal,'y',"DisplayName","clean signal");
        set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
        xlabel("Time Index",'FontSize',20,'FontWeight','bold');
        ylabel("Amplitude",'FontSize',20,'FontWeight','bold');
        title(sprintf("%d realization, delta = %d, order = %d", R, delta, L));
        lgd = legend(plts,'FontSize',15,'FontWeight','bold');
        grid on; grid minor;

        mspe(:,i) = mse; 
    end
    MSPE(:,m/5) = mean(mspe);
end
% MSE VS delay
figure;
for m = 5:5:20
    plot(MSPE(:,m/5),"DisplayName",sprintf("Order = %d",m));
    set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
    xlabel("delta",'FontSize',20,'FontWeight','bold');
    ylabel("MSPE",'FontSize',20,'FontWeight','bold');
    lgd = legend("show",'FontSize',15,'FontWeight','bold');
    grid on; grid minor;
    hold on;
end