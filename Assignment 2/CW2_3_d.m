clear all;close all;clc;
load 'EEG_Data_Assignment2.mat';

%number of observation
N = length(POz);
%fs: sampling frequency
%POz:original signal

% noise define
A = 1;
f0 = 50;
t = 1:N;
sigma_2 = 0.01;
sine = A * sin(2*pi*(f0/fs)*t);
corrupted_noise = sine + random('Normal', 0, sigma_2, 1, N);

% spectrogram parameters
K = 2^13;
L = 2^11;
% overlap as a percentage
overlap=0.5;    %0.33-0.5(recommend)

% step-size
mu = [0.1 0.01 0.001];
% model order
M = [2 10 15 30];

% figure - reference spectrogram
fig = figure("Name", sprintf("Original"));
spectrogram(POz, hamming(L), round(overlap * L), K, fs, 'yaxis');
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
title(sprintf("Original Spectrogram"));
ylim([0 60]);
c = colorbar;
c.Label.String = "Power (dB)";

% varying order
for i = 1:length(M)  
    % varying step
    for j = 1:length(mu)
        % ANC
        [noise_e,e2,W2] = ANC(corrupted_noise,POz,mu(j),M(i));
        x_hat = POz' - noise_e;
        
        % ANC spectrogram
        fig = figure("Name", sprintf("M_%d and mu_%.3f", M(i), mu(j)));
        spectrogram(x_hat, hamming(L), round(overlap * L), K, fs, 'yaxis');
        set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
        title(sprintf("Order: %d, Step: %.4f", M(i), mu(j)));
        ylim([0 60]);
        c = colorbar;
        c.Label.String = "Power (dB)";
    end  
end

% best parameters
Mopt = 10;
muopt = 0.001;
%ANC
[noise_e,e2,W2] = ANC(corrupted_noise,POz,muopt,Mopt);
x_hat = POz' - noise_e;

% Original
[Pxx, wx] = periodogram(POz, hamming(N), K, fs, 'onesided');
% denoised
[Pdd, wd] = periodogram(x_hat, hamming(N), K, fs, 'onesided');

% figure - periodogram
figure;
plot(wx, pow2db(Pxx), "DisplayName", "POz");
hold on;
plot(wd, pow2db(Pdd), "DisplayName", "ANC");
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
title("Periodogram",'FontSize',20,'FontWeight','bold');
xlabel("Frequency (Hz)",'FontSize',20,'FontWeight','bold');
ylabel("Power Density (dB)",'FontSize',20,'FontWeight','bold');
grid on; grid minor;
xlim([0 60]);
legend("show", "Location", "SouthWest");

% figure - periodogram error
figure;
plot(wx, pow2db(abs(Pxx - Pdd)))
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
title("Periodogram Error",'FontSize',20,'FontWeight','bold');
xlabel("Frequency (Hz)",'FontSize',20,'FontWeight','bold');
ylabel("Power Density (dB)",'FontSize',20,'FontWeight','bold');
grid on; grid minor;
xlim([0 60]);
