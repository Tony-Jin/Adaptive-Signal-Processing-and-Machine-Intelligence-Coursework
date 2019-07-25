clear all; close all; clc;

%number of sample
N = 1000;
%signal
a = 1;
b = [1 0.9];
sigma2 = 0.5;
%GASS
ro = 0.05;
mu0 = 0.1;
%GNGD
mu = 1;

weight1 = zeros(N,2);
weight2 = zeros(N,2);
error1 = zeros(N,1);
error2 = zeros(N,1);

for r = 1:100
    %input signal
    noise = random('Normal', 0, sigma2, N, 1);
    %desired signal
    x = filter(b, a, noise);
    
    % Benveniste
    [e1,wmat1] = GASS(noise,x,mu0,ro,'benvenist',2);
    error1(:,r) = e1;
    weight1 = wmat1 + weight1;
    
    [e2, wmat2] = GNGD(noise,x,mu,ro,2);
    error2(:,r) = e2;
    weight2 = wmat2 + weight2;
end
%Calculate the weights
weight1 = weight1/100;
weight2 = weight2/100;
w0 = 0.9*ones(N,2);
w1 = w0 - weight1;
w2 = w0 - weight2;
%Draw figures
figure
plot(w1(:,1),'LineWidth',2,"DisplayName","GASS");hold on;
plot(w2(:,1),'LineWidth',2,"DisplayName","GNGD");
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time Index",'FontSize',20,'FontWeight','bold');
ylabel("Filter Weights Error",'FontSize',20,'FontWeight','bold');
lgd = legend("show",'FontSize',15,'FontWeight','bold');
xlim([0 100]);
grid on; grid minor;
%Calculate the MSE
mse1 = pow2db(mean(error1.^2,2));
mse2 = pow2db(mean(error2.^2,2));
figure
plot(mse1,'LineWidth',2,"DisplayName","GASS");hold on;
plot(mse2,'LineWidth',2,"DisplayName","GNGD");
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time Index",'FontSize',20,'FontWeight','bold');
ylabel("Square Error(dB)",'FontSize',20,'FontWeight','bold');
lgd = legend("show",'FontSize',15,'FontWeight','bold');
xlim([0 350]);
grid on; grid minor;
