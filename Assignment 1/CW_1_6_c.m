clear all;close all;clc;
load 'PCR/PCAPCR.mat'

%OLS method
Bols = Xnoise.'*Xnoise\Xnoise.'*Y;
Yols = Xnoise*Bols;
Yols_test = Xtest*Bols;
%MSE
e_ols = norm(Yols - Y,'fro');
e_ols_test = norm(Yols_test - Ytest, 'fro');

%PCR
[u_noise, s_noise, v_noise] = svd(Xnoise);
[u_test, s_test, v_test] = svd(Xtest);
error_pcr = [];
error_pcr_test = [];

for r = 1:10
    Bpcr = v_noise(:,1:r)/(s_noise(1:r,1:r))*u_noise(:,1:r).'*Y;
    X_denoise = u_noise(:,1:r)*s_noise(1:r,1:r)*v_noise(:,1:r).';
    X_denoise_t = u_test(:,1:r)*s_test(1:r,1:r)*v_test(:,1:r).';
    
    Ypcr = X_denoise*Bpcr;
    Ypcr_test = X_denoise_t*Bpcr;
    e_pcr = norm(Ypcr - Y, 'fro');
    e_pcr_test = norm(Ypcr_test-Ytest, 'fro');
    error_pcr = [error_pcr e_pcr];
    error_pcr_test = [error_pcr_test e_pcr_test];
end
figure(1)
plot(1:10, error_pcr);
hold on
plot([1 10],[e_ols e_ols],'-.','LineWidth',2);
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("r",'FontSize',15,'FontWeight','bold');
ylabel("error",'FontSize',15,'FontWeight','bold');
xlim([1,10]);
grid on; grid minor;

figure(2)
plot(1:10, error_pcr_test);
hold on
plot([1 10],[e_ols_test e_ols_test],'-.','LineWidth',2);
set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
xlabel("r",'FontSize',15,'FontWeight','bold');
ylabel("error",'FontSize',15,'FontWeight','bold');
xlim([1,10]);
grid on; grid minor;


