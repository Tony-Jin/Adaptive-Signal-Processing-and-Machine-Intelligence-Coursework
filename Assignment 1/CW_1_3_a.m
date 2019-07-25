clear all;close all;clc;

%set the number of samples
N = 2096;
filter_size = 5;
%Signal 
WGN = wgn(N, 1, 1);
SIN = sin(linspace(0, N, N))';
noise_sin = awgn(SIN,5,'measured');
% SIN = sin(linspace(0, N, N))' + random('Normal', 0, 1, N, 1);
WGN_fil = filter(ones(1,filter_size)/filter_size, 1, WGN);
signal = WGN_fil;  % signal can be WGN, noise_sin and WGN_fil

% autocorrelation
[r_biased, lag_biased] = xcorr(signal, 'biased');
[r_unbiased, lag_unbiased] = xcorr(signal, 'unbiased');
figure(1)
hold on;
plot(lag_unbiased,r_unbiased,'r');
hold on;
plot(lag_biased,r_biased,'b');
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Frequency(Hz)",'FontSize',15,'FontWeight','bold');
ylabel("ACF",'FontSize',15,'FontWeight','bold');
grid on; grid minor;

%power spectral 
% move the ACF negative part to right
acf_r_biased = ifftshift(r_biased);
acf_r_unbiased = ifftshift(r_unbiased);
%Power estimator
P_biased = real(fftshift(fft(acf_r_biased)))/(2*pi);
P_unbiased = real(fftshift(fft(acf_r_unbiased)))/(2*pi);
normal = (length(lag_biased)-1)/2;
f_normalized = lag_biased./normal;
figure(2)
hold on;
plot(f_normalized,P_unbiased,'r');
hold on;
plot(f_normalized,P_biased,'b');
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Frequency(Hz)",'FontSize',15,'FontWeight','bold');
ylabel("PSD",'FontSize',15,'FontWeight','bold');
grid on; grid minor;
