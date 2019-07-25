clear all; close all; clc;
load sunspot.dat
%read the year and the number of sunspot
year = sunspot(:,1);
num = sunspot(:,2);
time = length(year);
%% 1.2.a.1
%remove the trend and mean
x1 = detrend(num-mean(num));
%logarithms
x_log = log(num + eps);
x2 = x_log - mean(x_log);
%figure plot
figure(1);
plot(year,num,'LineWidth',2);
hold on;
plot(year,x1,'LineWidth',2);
hold on;
plot(year,x2,'LineWidth',2);
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Time",'FontSize',15,'FontWeight','bold');
ylabel("Number of Sunspots",'FontSize',15,'FontWeight','bold');
grid on; grid minor;
legend("original signal","remove trend and mean","logarithms without mean and trend",'FontSize',12,'FontWeight','bold');
%% 1.2.a.2
%length of signal with padding zero
nfft = 2^10;
h_win = hamming(time);
%original signal
X = abs(fftshift(fft([(num .* h_win)' zeros(1, nfft - time)])));
[X_,f_] = periodogram(num,h_win,1024,2);
Px_=10*log10(X_);
Px = pow2db(X.^2 / (time));
% one-side periodogram
Px_one = Px((length(Px)/2 + 1):end);

%remove mean and trend
X1 = abs(fftshift(fft([(x1.*h_win)' zeros(1,nfft-time)])));
[X1_,f1_] = periodogram(x1,h_win,1024,2);
Px1_=10*log10(X1_);
Px1 = pow2db(X1.^2/(time));
Px1_one = Px1((length(Px1)/2+1):end);

%logarithm
X2 = abs(fftshift(fft([(x2.*h_win)' zeros(1,nfft-time)])));
[X2_,f2_] = periodogram(x2,h_win,1024,2);
Px2_=10*log10(X2_);
Px2 = pow2db(X2.^2/(time));
Px2_one = Px2((length(Px2)/2+1):end);

f = 0:2/nfft:1-1/nfft;

figure(2);
hold on;
plot(f,Px_one,'LineWidth',2);
hold on;
plot(f,Px1_one,'LineWidth',2);
hold on;
plot(f,Px2_one,'LineWidth',2);
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("Normalised Frequency",'FontSize',15,'FontWeight','bold');
ylabel("Power",'FontSize',15,'FontWeight','bold');
legend("original signal","remove trend and mean","logarithms without mean and trend",'FontSize',12,'FontWeight','bold');
grid on; grid minor;

figure(3);
hold on;
plot(f_,Px_);
hold on;
plot(f_,Px1_);
hold on;
plot(f_,Px2_);
xlabel("Normalised Frequency");
ylabel("Power");
legend("original signal","remove trend and mean","logarithms without mean and trend");




