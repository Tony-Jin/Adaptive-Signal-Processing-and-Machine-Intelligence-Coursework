clear all;close all;clc;
load 'PCR/PCAPCR.mat'

xs = svd(X);
xs_n = svd(Xnoise);
r = rank(X);
rn = rank(Xnoise);

e = (xs - xs_n).^2;
figure(1)
stem([xs,xs_n]);
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("singular value index",'FontSize',15,'FontWeight','bold');
ylabel("singular value magnitude",'FontSize',15,'FontWeight','bold');
grid on; grid minor;
figure(2)
stem(e);
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("singular value index",'FontSize',15,'FontWeight','bold');
ylabel("square error",'FontSize',15,'FontWeight','bold');
grid on; grid minor;
% bar([xs,xs_n]);
% bar(e);

