clear all;close all;clc;
load 'EEG_Data_Assignment1.mat';

%number of observation
N = 1200;
n = 1:N;
%fs: sampling frequency
%POz:original signal
% length of DFT: 5 DFT samples per Hz
K = 1024;
w = (0:(K-1)) .* (fs / K);

%cenerted signal
a = 10000;
Y = POz(a:a+N-1);
y = detrend(Y - mean(Y));

mu = 1;
% data preprocessing
X = (1 / K) * exp(1j * (1:N)' * pi * (0:(K-1)) / K)';

[output, e, h] = DFTCLMS(X, y', mu, 0.001);
H = abs(h).^2;
% H = H(:,4801:end);
%Remove outpiers in the matrix H
medianH = 100*median(median(H));
H(H>medianH) = medianH;
surf(n, w, H, "LineStyle", "none");
view(2);
c = colorbar;
c.Label.String = "Power Spectral Density";
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time index",'FontSize',20,'FontWeight','bold');
ylabel("Frequency",'FontSize',20,'FontWeight','bold');
ylim([0 60]);
grid on; grid minor;