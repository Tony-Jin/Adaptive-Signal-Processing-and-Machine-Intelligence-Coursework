clear all;close all;clc;

% number of samples
N = 1500;
n = 1:N;
% sampling frequency
fs = 1500;
% segment length
K = 1024;
%white noise
sigma2 = 0.05;
eta = wgn(N, 1, pow2db(0.05), 'complex');

f = arrayfun(@frequency, n);
w = (0:(K-1)) .* (fs / K);
phi = cumsum(f);
% signal
y = exp(j * (2 * pi * phi.' / fs)) + eta;

mu = 1;

% data preprocessing
X = (1 / K) * exp(1j * (1:N)' * pi * (0:(K-1)) / K)';

[output, e, h] = DFTCLMS(X, y', mu, 0.5);
H = abs(h).^2;
%Remove outpiers in the matrix H
medianH = 50*median(median(H));
H(H>medianH) = medianH;
surf(n, w, H, "LineStyle", "none");
view(2);
c = colorbar;
c.Label.String = "Power Spectral Density";
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time index",'FontSize',20,'FontWeight','bold');
ylabel("Frequency",'FontSize',20,'FontWeight','bold');
% ylim([0 700]);
grid on; grid minor;