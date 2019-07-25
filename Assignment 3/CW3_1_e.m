clear all; close all;clc;

% amplitude
V = ones(3,1);
%phase
phi = [0; 2*pi/3; -2*pi/3];
delta = zeros(3,1);
%systam frequency
f0 = 50;
%sampling frequency
fs = 5000;
%sample number 
N = 3000;
n = 1:N;

m=1;
mu = 0.05;

v = V.*cos(2*pi*f0*n/fs + phi + delta);
vc = clarke(v);
%clark voltage
v_clark = complex(vc(2,:),vc(3,:));

x = [0 v_clark];
x = x(1:N).';
d = v_clark.';

[output1,e1,h1] = CLMS(x,d,mu,m);
[output2,e2,h2,g] = ACLMS(x,d,mu,m);

MSE1 = pow2db(abs(e1).^2);
MSE2 = pow2db(abs(e2).^2);

figure;
plot(n,MSE1,'DisplayName','CLMS');
hold on;
plot(n,MSE2,'DisplayName','ACLMS');
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time index",'FontSize',20,'FontWeight','bold');
ylabel("Mean square error(dB)",'FontSize',20,'FontWeight','bold');
lgd = legend('show','FontSize',15,'FontWeight','bold');
grid on; grid minor;

f1 = fs/(2*pi) * atan( imag(h1) ./ real(h1) );
f2 = fs/(2*pi) * atan( sqrt( imag(h2).^2 - abs(g).^2 ) ./ real(h2) );
figure;
plot(n,f1,'DisplayName','CLMS');
hold on;
plot(n,f2,'DisplayName','ACLMS');
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time index",'FontSize',20,'FontWeight','bold');
ylabel("frequency",'FontSize',20,'FontWeight','bold');
lgd = legend('show','FontSize',15,'FontWeight','bold');
grid on; grid minor;

%% unbalance
%unbalance
% voltage amplitudes
V2 = [0.5; 1; 1.5];
%phase
phi = [0; 2*pi/3; -2*pi/3];
delta2 = [0; 2; 0.5];
%systam frequency
f0 = 50;
%sampling frequency
fs = 5000;
%sample number 
N = 3000;
n = 1:N;

m=1;
mu = 0.05;

v2 = V2.*cos(2*pi*f0*n/fs + phi + delta2);
vc2 = clarke(v2);
%clark voltage
v_clark2 = complex(vc2(2,:),vc2(3,:));

x2 = [0 v_clark2];
x2 = x2(1:N).';
d2 = v_clark2.';

[output_u1,eu1,hu1] = CLMS(x2,d2,mu,m);
[output_u2,eu2,hu2,gu] = ACLMS(x2,d2,mu,m);

uMSE1 = pow2db(abs(eu1).^2);
uMSE2 = pow2db(abs(eu2).^2);

figure;
plot(n,uMSE1,'DisplayName','CLMS');
hold on;
plot(n,uMSE2,'DisplayName','ACLMS');
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time index",'FontSize',20,'FontWeight','bold');
ylabel("Mean square error(dB)",'FontSize',20,'FontWeight','bold');
lgd = legend('show','FontSize',15,'FontWeight','bold');
grid on; grid minor;

f1 = fs/(2*pi) * atan( imag(hu1) ./ real(hu1) );
f2 = fs/(2*pi) * atan( sqrt( imag(hu2).^2 - abs(gu).^2 ) ./ real(hu2) );
figure;
plot(n,f1,'DisplayName','CLMS');
hold on;
plot(n,f2,'DisplayName','ACLMS');
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time index",'FontSize',20,'FontWeight','bold');
ylabel("frequency",'FontSize',20,'FontWeight','bold');
lgd = legend('show','FontSize',15,'FontWeight','bold');
grid on; grid minor;

