clear all; close all; clc;
load RRI_t;

RRI = {xRRI1; xRRI2; xRRI3};
fsRRI = 4;
nfft = 1024;
%% standard periodogram
for i = 1:length(RRI)
    N = length(RRI{i});
    [Pxx, f] = periodogram(RRI{i}, hamming(N), nfft, fsRRI, 'onesided');
    figure(i)
    plot(f, pow2db(Pxx),'LineWidth',2);
    set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
    xlabel("Frequency",'FontSize',15,'FontWeight','bold');
    ylabel("PSD",'FontSize',15,'FontWeight','bold');
    grid on; grid minor;
end
%% averaged periodogram
window = [50 150];
for ii = 1:length(RRI)
    figure(ii+3)
    for iii = 1:length(window)
%         seg_len = window(iii)*fsRRI;
        [P_avg, f_avg]= pwelch(RRI{ii}, hamming(window(iii)), 0, nfft, fsRRI, 'onesided');
        plot(f_avg, pow2db(P_avg), "DisplayName", sprintf("Window length %d", window(iii)));
        hold on;
    end
    set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
    xlabel("Frequency",'FontSize',15,'FontWeight','bold');
    ylabel("PSD",'FontSize',15,'FontWeight','bold');
    legend("show", "Location", "north",'FontSize',10,'FontWeight','bold');
    grid on; grid minor;
end

