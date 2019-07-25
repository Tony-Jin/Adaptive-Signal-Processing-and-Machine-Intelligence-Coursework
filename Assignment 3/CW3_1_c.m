clear all; close all;clc;

% amplitude
V = ones(3,1);
%phase
phi = [0; 2*pi/3; -2*pi/3];
delta = zeros(3,1);
%systam frequency
f0 = 50;
%sampling frequency
fs = 10000;
%sample number 
N = 1000;
n = 1:N;

v = V.*cos(2*pi*f0*n/fs + phi + delta);
vc = clarke(v);
%clark voltage
v_clark = complex(vc(2,:),vc(3,:));
% balance
figure;
scatter(vc(2,:), vc(3,:), 'filled');
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Real Part",'FontSize',20,'FontWeight','bold');
ylabel("Imaginary Part",'FontSize',20,'FontWeight','bold');
grid on; grid minor;

%% unbalance

% magnitude
figure;
for dv = [0.2 0.4 0.6 0.8]

    % voltage amplitudes
    V2 = ones(3, 1) + [-dv; 0; +dv];
    % voltages
    v2 = V2 .* cos(2 * pi * (f0 / fs) * n + delta + phi);
    % Clarke voltages
    vc2 = clarke(v2);
    scatter(vc2(2,:), vc2(3,:), 'filled', "DisplayName", sprintf("V1 = %.1f", V2(1)));
    hold on;
    
end
xlabel("Real Part",'FontSize',20,'FontWeight','bold');
ylabel("Imaginary Part",'FontSize',20,'FontWeight','bold');
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
grid on; grid minor;
lgd = legend("show");
lgd.NumColumns = 4;

% phase
figure;
for dD = [0.2 0.4 0.6 0.8]

    % voltage amplitudes
    delta2 = zeros(3, 1) + [0; dD; -dD];
    % voltages
    v3 = V .* cos(2 * pi * (f0 / fs) * n + delta2 + phi);
    % Clarke voltages
    vc3 = clarke(v3);
    scatter(vc3(2,:), vc3(3,:), 'filled', "DisplayName", sprintf("delta2 = %.1f", delta2(2)));
    hold on;
    
end
xlabel("Real Part",'FontSize',20,'FontWeight','bold');
ylabel("Imaginary Part",'FontSize',20,'FontWeight','bold');
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
grid on; grid minor;
lgd = legend("show");
lgd.NumColumns = 4;

