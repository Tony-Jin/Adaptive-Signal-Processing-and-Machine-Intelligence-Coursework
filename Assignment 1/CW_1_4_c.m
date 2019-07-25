clear all; close all;clc

%generate the AR model
a = [2.76 -3.81 2.65 -0.92];
%w ~ N(0,1)
AR = arima('Constant', 0, 'AR', a, 'Variance', 1);
N1 = 500;%for transient output of the filter
N2 = 10000;
N = N1+N2;%number of sample
X = simulate(AR, N);
x = X(N1+1:N);%remove first 500 samples
% ideal model
[H, w] = freqz(1, [1 -a], N2);
sigma_w = [];

for order = 2:14
    [a_est, sigma] = aryule(x, order);
    sigma_w = [sigma_w; sigma];%sigma is estimated variance of the white noise input
    %estimate model
    [H_est,w_est] = freqz(sqrt(sigma), a_est, N2);
    
    figure(order-1)
    plot(w/(2*pi), pow2db(abs(H).^2),'LineWidth',2);
    hold on;
    plot(w_est/(2*pi), pow2db(abs(H_est).^2),'LineWidth',2);
    set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
    xlabel('Normalised Frequency','FontSize',15,'FontWeight','bold');
    ylabel('PSD','FontSize',15,'FontWeight','bold');
    title(sprintf("order:%d", order),'FontSize',15,'FontWeight','bold');
    grid on; grid minor;
end
figure(order);
plot(2:14,sigma_w,'LineWidth',2);
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel('order','FontSize',15,'FontWeight','bold'); 
ylabel('error','FontSize',15,'FontWeight','bold');
grid on; grid minor;

