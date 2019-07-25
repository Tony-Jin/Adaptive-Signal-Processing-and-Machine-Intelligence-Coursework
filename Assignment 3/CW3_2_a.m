clear all; close all; clc;

% number of samples
N = 1500;
n = 1:N;
% sampling frequency
fs = 1500;
%white noise
sigma2 = 0.05;
eta = wgn(N, 1, pow2db(0.05), 'complex');

f = arrayfun(@frequency, n);
phi = cumsum(f);
figure;
plot(n,f);
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time index",'FontSize',20,'FontWeight','bold');
ylabel("frequency",'FontSize',20,'FontWeight','bold');
grid on; grid minor;
figure;
plot(n, wrapTo2Pi(phi))
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time index",'FontSize',20,'FontWeight','bold');
ylabel("Angle",'FontSize',20,'FontWeight','bold');
% xlim([1 500]);
grid on; grid minor;

% signal
y = exp(1j * (2 * pi * phi.' / fs)) + eta;
%AR(1)
a = aryule(y,1);
% power density estimate
[h, w] = freqz(1, a, N, fs);
% psd
psd = mag2db(abs(h));
figure;
plot(w,psd);
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Frequency",'FontSize',20,'FontWeight','bold');
ylabel("Power Spectrum Density(dB)",'FontSize',20,'FontWeight','bold');
grid on; grid minor;

for i = 1:3
    s = y(1+(i-1)*500:i*500);
    %AR(1)
    a = aryule(s,1);
    % power density estimate
    [h, w] = freqz(1, a, N, fs);
    % psd
    psd = mag2db(abs(h));
    figure;
    plot(w,psd);
    set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
    xlabel("Frequency",'FontSize',20,'FontWeight','bold');
    ylabel("Power Spectrum Density(dB)",'FontSize',20,'FontWeight','bold');
    grid on; grid minor;
end
