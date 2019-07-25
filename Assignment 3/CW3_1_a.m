clear all; close all; clc

% Number of samples
N = 1000;
% Number of simulation times
R = 100;
%Parameters
mu = 0.05;  %learning rate
M = 2;  %order

%wlma
sigma2 =1;
b1 = 1.5+1j; b2 = 2.5-0.5j;

error = zeros(N,R);
error2 = zeros(N,R);
% H = zeros(N,R);
y_hat = zeros(N,R);
y_hat2 = zeros(N,R);

for r = 1:R
    %input signal
    x = wgn(N,1,pow2db(sigma2),'complex');
    %desired signal
    y = zeros(size(x));
    y(1) = x(1);
    for i = 2:N
        y(i) = x(i) + b1*x(i-1) + b2*conj(x(i-1));
    end
    %CLMS
    [output,e,h] = CLMS(x,y,mu,M);
    y_hat(:,r) = output;
    error(:,r) = e;
    %ACLMS
    [output2, e2, h2, g] = ACLMS(x, y, mu, M);
    y_hat2(:,r) = output2;
    error2(:,r) = e2;
end

lc1 = pow2db(mean(abs(error).^2,2));
lc2 = pow2db(mean(abs(error2).^2,2));
figure(1);
plot(lc1,"DisplayName",'CLMS');
hold on;
plot(lc2,"DisplayName",'ACLMS');
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time Index",'FontSize',20,'FontWeight','bold');
ylabel("square error(dB)",'FontSize',20,'FontWeight','bold');
lgd = legend('show','FontSize',15,'FontWeight','bold');
grid on; grid minor;

figure(2);
scatter(real(y), imag(y), 30, "filled", "DisplayName", "WLMA(1)")
hold on
scatter(real(x), imag(x), 30, "filled", "DisplayName", "WGN")
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Real Part",'FontSize',20,'FontWeight','bold');
ylabel("Imaginary Part",'FontSize',20,'FontWeight','bold');
legend("show");
grid on; grid minor;

