clear all;close all;clc;

load high-wind.mat;
wind(:,1) = complex(v_east, v_north);
load low-wind.mat;
wind(:,2) = complex(v_east, v_north);
load medium-wind.mat;
wind(:,3) = complex(v_east, v_north);

for i = 1:3
    rho(i) = abs(mean((wind(:,i)).^2)/mean(abs(wind(:,i)).^2));
    
    figure(i);
    scatter(real(wind(:,i)), imag(wind(:,i)), "filled");
    set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
    xlabel("east",'FontSize',20,'FontWeight','bold');
    ylabel("north",'FontSize',20,'FontWeight','bold');
    grid on; grid minor;
end

mu = 0.005;

for i = 1:3
    error1 = zeros(5000,20);
    error2 = zeros(5000,20);
    x = [0; wind(:,i)];
    x = x(1:5000);
    for m = 1:20
        [~,e1,~] = CLMS(x,wind(:,i),mu,m);
        error1(:,m) = e1;
        [~,e2,~,~] = ACLMS(x,wind(:,i),mu,m);
        error2(:,m) = e2;
    end
    MSE1 = pow2db(mean(abs(error1).^2));
    MSE2 = pow2db(mean(abs(error2).^2));
    t = 1:20;
        
    figure(i+3);
    plot(t,MSE1,"DisplayName",'CLMS');hold on;
    plot(t,MSE2,"DisplayName",'ACLMS');
    set(gca,'FontSize',15,'Fontname', 'Times New Roman','FontWeight','bold');
    xlabel("Order",'FontSize',20,'FontWeight','bold');
    ylabel("Mean square error(dB)",'FontSize',20,'FontWeight','bold');
    lgd = legend('show','FontSize',15,'FontWeight','bold');
    grid on; grid minor;
end
