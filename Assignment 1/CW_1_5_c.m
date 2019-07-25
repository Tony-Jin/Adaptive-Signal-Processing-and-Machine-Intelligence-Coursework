clear all; close all; clc;
load RRI_t;

RRI = {xRRI1; xRRI2; xRRI3};
nfft = 1024;
f = -1:(2/nfft):1-(1/nfft);

for i = 1:3
% i=2
    N = length(RRI{i});
    x = RRI{i}.*hamming(N)';
%     X = abs(fftshift(fft(x,nfft)));
%     Pxx = pow2db(X.^2 / (N));
    [Pxx, f] = periodogram(RRI{i}, hamming(N), nfft, fsRRI, 'onesided');
    figure(i)
    plot(f, pow2db(Pxx),"DisplayName", "Standard");
    %AR model
    for order = 5:5:30 %60 for speed up
        hold on;
        [Pxx,F] = pyulear(x,order,N,4);
        plot(F,pow2db(Pxx),"DisplayName", sprintf("order: %d",order));  
    end
    set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
    lgd = legend("show",'FontSize',15,'FontWeight','bold');
    lgd.NumColumns = 2;
    xlim([0,1]);
    xlabel("frequency (Hz)",'FontSize',15,'FontWeight','bold');
    ylabel("PSD(dB)",'FontSize',15,'FontWeight','bold');
    grid on; grid minor;
end