clear all;close all;clc;
load 'PCR/PCAPCR.mat'
%OLS
Bols = inv(Xnoise.'*Xnoise)*Xnoise.'*Y;
error_ols = [];
for i = 1:50
    [Yp_hat,Yo] = regval(Bols);
    e_ols = (norm(Yp_hat - Yo,2).^2);
    error_ols = [error_ols; e_ols];
end

%PCR
[u_noise, s_noise, v_noise] = svd(Xnoise);
error_pcr = [];
for r = 1:10
    e_iter = [];
    Bpcr = v_noise(:,1:r)*inv(s_noise(1:r,1:r))*u_noise(:,1:r).'*Y;
    for ii = 1:50
        [Yp_hat,Yp] = regval(Bpcr);
        ep = (norm(Yp_hat-Yp,2).^2);
        e_iter = [e_iter ep];
    end
    error_pcr = [error_pcr;e_iter]; 
end

figure
for iii = 1:50
    plot([1 10],[error_ols(iii), error_ols(iii)],'g','LineWidth',0.5);
    hold on
    plot(1:10,error_pcr(:,iii),'y','LineWidth',0.5);
    hold on
end
plot([1 10],[[mean(error_ols) mean(error_ols)]],'r','LineWidth',2);
hold on
plot(1:10, mean(error_pcr,2),'b','LineWidth',2);
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("r",'FontSize',15,'FontWeight','bold');
ylabel("error",'FontSize',15,'FontWeight','bold');
xlim([1,10]);
grid on; grid minor;