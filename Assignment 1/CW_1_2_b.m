
clear all; close all; clc;
load('EEG_Data/EEG_Data/EEG_Data_Assignment1.mat');

%number of observation
N = length(POz);
%length of DFT
nfft = fs*10;
%duration
dur = [10 5 1];
%remove the mean
poz = POz;
% poz = POz - mean(POz);
%Periodograms

%standard approach
[Pxx, f] = periodogram(poz, hamming(N), nfft, fs, 'onesided');
% figure
figure(1)
plot(f, pow2db(Pxx),'LineWidth',2);
xlabel("Frequency",'FontSize',15,'FontWeight','bold');
ylabel("PSD",'FontSize',15,'FontWeight','bold');
grid on; grid minor;
xlim([0 60]);
ylim([-160 -80]);

%averaged periodogram
figure(2);
for i = 1:3
    %segment samples length
    seg_len = dur(i)*fs;
    [P_avg, f_avg]= pwelch(poz, hamming(seg_len), 1000, nfft, fs, 'onesided');
    plot(f_avg, pow2db(P_avg), "DisplayName", sprintf("Window length %d", dur(i)),'LineWidth',2);
    hold on;
end
xlabel("Frequency",'FontSize',15,'FontWeight','bold');
ylabel("PSD",'FontSize',15,'FontWeight','bold');
grid on; grid minor;
xlim([0 60]);
legend("show", "Location", "north");
%comparation 
for ii = 1:3
    figure(ii+2);
    seg_len = dur(ii)*fs;
    [P_avg, f_avg]= pwelch(poz, hamming(seg_len), 1000, nfft, fs, 'onesided');
    plot(f, pow2db(Pxx),'LineWidth',2);
    hold on;
    plot(f_avg, pow2db(P_avg),'LineWidth',2);
    set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
    xlabel("Frequency",'FontSize',15,'FontWeight','bold');
    ylabel("PSD",'FontSize',15,'FontWeight','bold');
    grid on; grid minor;
    xticks(0:10:60);
    xlim([0 60]);
    ylim([-160 -80]);    
end


