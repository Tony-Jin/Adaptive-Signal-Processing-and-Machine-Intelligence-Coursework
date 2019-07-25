clear all; close all; clc;
%length of window
nfft = 128;
f1 = 0.3;
f2 = 0.33;
figure(1);
sample = 30;
% for i = 1:5
    n = 0:(sample-1);
    % noise
    noise = 0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n)));
    % signal
    x = exp(1j*2*pi*f1*n) + exp(1j*2*pi*f2*n) + noise;
    %PSD
    [Pxx, f] = periodogram(x, rectwin(sample), nfft, 1);
%     X = abs(fftshift(fft([(x .* (rectwin(sample).')) zeros(1, nfft - sample)])));
%     Px = pow2db(X.^2 / (sample));
%     f_ = -1:2/nfft:1-1/nfft;
%     hold on;
%     plot(f_, Px);
    hold on;
    plot(f,pow2db(Pxx),'LineWidth',2);
    set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
    xlabel("Frequency(Hz)",'FontSize',15,'FontWeight','bold');
    ylabel("PSD",'FontSize',15,'FontWeight','bold');
    title(sprintf("Window length %d \n frequency difference 0.03", sample),'FontSize',15,'FontWeight','bold');
    sample = sample + 3;
    xlim([0,1]);
    grid on; grid minor;
% end