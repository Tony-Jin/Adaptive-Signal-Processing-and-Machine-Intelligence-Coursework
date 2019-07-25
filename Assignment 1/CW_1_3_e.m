clear all; close all; clc;
%length of window
nfft = 40;
f1 = 0.3;
f2 = 0.32;
sample = 30;
n = 0:(sample-1);
spectrum = [];
figure(1)
for i = 1:100
    % noise
    noise = 0.2/sqrt(2)*(randn(1,nfft)+1j*randn(1,nfft));
    % signal
    x = [exp(1j*2*pi*f1*n) + exp(1j*2*pi*f2*n) zeros(1, nfft - sample)];
    signal = x + noise;
    %MUSIC
    [X,R] = corrmtx(signal,14,'mod');
    [S,F] = pmusic(R,2,[],1,'corr');
    spectrum = [spectrum; S.'];
    hold on
    plot(F,S,'g','linewidth',0.5); 
end

plot(F, mean(spectrum), 'r', 'linewidth',2);
xlim([0.25 0.40]);
grid on; grid minor; 
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Frequency(Hz)",'FontSize',15,'FontWeight','bold');
ylabel('Power/frequecy','FontSize',15,'FontWeight','bold');

figure(2)
plot(F, std(spectrum));
xlim([0.25 0.40]);
grid on; grid minor; 
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Frequency(Hz)",'FontSize',15,'FontWeight','bold');
ylabel('STD','FontSize',15,'FontWeight','bold');