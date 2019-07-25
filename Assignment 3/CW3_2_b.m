clear all;close all;clc;

% number of samples
N = 1500;
n = 1:N;
% sampling frequency
fs = 1500;
%white noise
sigma2 = 0.05;
eta = wgn(N, 1, pow2db(0.05), 'complex');

f = arrayfun(@frequency, n);
phi = cumsum(f);
% signal
y = exp(j * (2 * pi * phi.' / fs)) + eta;
x = [0;y];
x = x(1:N);
mu = 0.01;
K = 1024;

[y_hat,error,h_clms] = CLMS(x,y,mu,1);

% spectrum estimate cache
H = zeros(K, N); 
% power spectrum estimation
for i = 1:N        
    % estimation
    [h, w] = freqz(1, [1; -conj(h_clms(i))], K, fs);
    % storage
    H(:, i) = abs(h).^2;
end
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
ylim([0 700]);
grid on; grid minor;