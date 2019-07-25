clear all;close all;clc;

%number of samples
N = 1000;
%signal
a = 1;
b = [1 0.9];
sigma2 = 0.5;
L=2;
% LMS
mu = [0.01 0.05 0.1];
%GASS
ro = 0.005;
mu0 = 0.1;
% type
algo = {'benvenist', 'ang_farhang', 'matthews_xie'};
error1 =  zeros(N,100);
error2 =  zeros(N,100);
error3 =  zeros(N,100);
error4 =  zeros(N,100);
error5 =  zeros(N,100);
error6 =  zeros(N,100);
weight1 = zeros(N,L);
weight2 = zeros(N,L);
weight3 = zeros(N,L);
weight4 = zeros(N,L);
weight5 = zeros(N,L);
weight6 = zeros(N,L);

for r = 1:100
    %input signal
    noise = random('Normal', 0, sigma2, N, 1);
    %desired signal
    x = filter(b, a, noise);
    % constant 0.01
    [e1,wmat1] = lms2(noise,x,mu(1),L);
    error1(:,r) = e1;
    weight1 = wmat1 + weight1;
    
    % constant 0.05
    [e6,wmat6] = lms2(noise,x,mu(2),L);
    error6(:,r) = e6;
    weight6 = wmat6 + weight6;
    
    % constant 0.1
    [e2,wmat2] = lms2(noise,x,mu(3),L);
    error2(:,r) = e2;
    weight2 = wmat2 + weight2;
 %{'benvenist', 'ang_farhang', 'matthews_xie'}   
    % Benveniste
    [e3,wmat3] = GASS(noise,x,mu0,ro,'benvenist',L);
    error3(:,r) = e3;
    weight3 = wmat3 + weight3;
    
    % ang_farhang
    [e4,wmat4] = GASS(noise,x,mu0,ro,'ang_farhang',2);
    error4(:,r) = e4;
    weight4 = wmat4 + weight4;
    
    % matthews_xie
    [e5,wmat5] = GASS(noise,x,mu0,ro,'matthews_xie',L);
    error5(:,r) = e5;
    weight5 = wmat5 + weight5;
end
%Calculate the weight
weight1 = weight1/100;
weight2 = weight2/100;
weight3 = weight3/100;
weight4 = weight4/100;
weight5 = weight5/100;
weight6 = weight6/100;
w0 = 0.9*ones(N,L);
w1 = w0 - weight1;
w2 = w0 - weight2;
w3 = w0 - weight3;
w4 = w0 - weight4;
w5 = w0 - weight5;
w6 = w0 - weight6;
%Draw figures
figure(1)
plot(w1(:,1),'LineWidth',2,"DisplayName","mu: 0.01");hold on;
plot(w6(:,1),'LineWidth',2,"DisplayName","mu: 0.05");hold on;
plot(w2(:,1),'LineWidth',2,"DisplayName","mu: 0.1");hold on;
plot(w3(:,1),'LineWidth',2,"DisplayName","benvenist");hold on;
plot(w4(:,1),'LineWidth',2,"DisplayName","ang-farhang");hold on;
plot(w5(:,1),'LineWidth',2,"DisplayName","matthews-xie");hold on;
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time Index",'FontSize',20,'FontWeight','bold');
ylabel("Filter Weights Error",'FontSize',20,'FontWeight','bold');
lgd = legend("show",'FontSize',15,'FontWeight','bold');
grid on; grid minor;

mse1 = pow2db(mean(error1.^2,2));
mse2 = pow2db(mean(error2.^2,2));
mse3 = pow2db(mean(error3.^2,2));
mse4 = pow2db(mean(error4.^2,2));
mse5 = pow2db(mean(error5.^2,2));
mse6 = pow2db(mean(error6.^2,2));
figure(2)
plot(mse1,'LineWidth',2,"DisplayName","mu: 0.01");hold on;
plot(mse6,'LineWidth',2,"DisplayName","mu: 0.05");hold on;
plot(mse2,'LineWidth',2,"DisplayName","mu: 0.1");hold on;
plot(mse3,'LineWidth',2,"DisplayName","benvenist");hold on;
plot(mse4,'LineWidth',2,"DisplayName","ang-farhang");hold on;
plot(mse5,'LineWidth',2,"DisplayName","matthews-xie");hold on;
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time Index",'FontSize',20,'FontWeight','bold');
ylabel("Square Error(dB)",'FontSize',20,'FontWeight','bold');
lgd = legend("show",'FontSize',15,'FontWeight','bold');
grid on; grid minor;