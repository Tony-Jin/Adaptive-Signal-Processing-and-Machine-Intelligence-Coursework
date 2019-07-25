clear all; close all; clc;

A = [0.5 0.3];
f = [0.8 1.4];
fs = 10; %sampling frequency
n = 0:1/(2*fs):10;
L = 512;
%generate the input signal
signal = A(1).*sin(2*pi*f(1)*n) + A(2).*sin(2*pi*f(2).*n);
Signal = [signal zeros(1,L-length(n))];
P_total = [];
figure(1);
for i = 1:100
    noise_sig = awgn(Signal,5,'measured');
%     noise_sig = noise - mean(noise);
    %correlation
    [r_biased, lag_biased] = xcorr(noise_sig, 'biased');
    acf_r_biased = ifftshift(r_biased);
    normal = (length(lag_biased)-1)/2;
    f_normalized = lag_biased./normal;
    P_biased = real(fftshift(fft(acf_r_biased)))/(2*pi);
    hold on;
    plot(f_normalized*fs,P_biased,'g','LineWidth', 0.5);
    P_total = [P_total; P_biased];
end

P_mean = real(mean(P_total));
plot(f_normalized*fs,P_mean,'r','LineWidth',2);
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Frequency(Hz)",'FontSize',15,'FontWeight','bold');
ylabel("PSD",'FontSize',15,'FontWeight','bold');
grid on; grid minor;
xlim([0.0, 2]);
% ylim([0,8]);

%standard deviation
figure(2);
P_std = std(real(P_total));
plot(f_normalized*fs,P_std,'b','LineWidth',2);
xlim([0.0, 2]);
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Frequency(Hz)",'FontSize',15,'FontWeight','bold');
ylabel("STD",'FontSize',15,'FontWeight','bold');
grid on; grid minor;
% ylim([0 0.2]);