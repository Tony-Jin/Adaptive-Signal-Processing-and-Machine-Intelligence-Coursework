clear all;close all;clc;
load 'PCR/PCAPCR.mat'

[u_noise, s_noise, v_noise] = svd(Xnoise);
error = [];
for r = 1:10
    X_denoise = u_noise(:,1:r)*s_noise(1:r,1:r)*v_noise(:,1:r).';
    e = norm(X_denoise - X,'fro');
    error = [error e];
end
plot(1:10,error);
hold on;
plot([1,10], [error(10), error(10)]);
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("r",'FontSize',15,'FontWeight','bold');
ylabel("error",'FontSize',15,'FontWeight','bold');
xlim([1,10]);
grid on; grid minor;
% en = norm(Xnoise - X,'fro');