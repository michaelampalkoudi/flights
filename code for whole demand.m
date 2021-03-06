%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%fortwsi oloklhrhs ths xronoseiras ths zhthshs%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T4=demandcentralsouthern
X4=table2array(T4)
figure(1)
plot(X4)
title('Time Series of demand of electricity at Central-Southern region ') 
var(X4)
mean(X4)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%metasxhmatismos logarithmou ths xronoseiras ths zhthshs%%%%%%%%%%%%%%%%%%%%%%%%%%%
X44=log(X4)
figure(2)
plot(X44)
title('Time Series of log demand of electricity at Central-Southern region ') 
var(X44)
mean(X44)

%%%%%%%%%%%%%%%%elegxos stasimothtas gia metasxhmatismenh xronoseira/ Dickey fuller test%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
df = adftest(X44);
[df,pValue]=adftest(X44)
%den exw stasimothta


%%%%%%%%%%%%%%%oi autosusxetiseis ths  metasxhmatismenhs xronoseiras%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxtau=220; 
alpha = 0.05;
zalpha = 1.96; 
acx1M = autocorrelation(X44,maxtau);
autlim = zalpha/sqrt(length(X44)); 
figure(5)
clf 
hold on
for i=1:maxtau   
    plot(acx1M(i+1,1)*[1 1],[0 acx1M(i+1,2)],'b','linewidth',1.5)
end
plot([0 maxtau+1],[0 0],'k','linewidth',1.5)
plot([0 maxtau+1],autlim*[1 1],'--c','linewidth',1.5)
plot([0 maxtau+1],-autlim*[1 1],'--c','linewidth',1.5)
xlabel('\tau') 
ylabel('r(\tau)')
title(sprintf('Autocorrelation of time series of log demand of electricity at Central-Southern region '))

%%%%%%%%%%%%%%%%%%%%%%%%oi merikes autosusxetiseis ths  metasxhmatismenhs xronoseiras%%%%%%%%%%%%%%%%%%%%%%%%%
display = 1;
pacfV = parautocor(X44,maxtau); 
figure(6)
clf
hold on
for i=1:maxtau  
    plot(acx1M(i+1,1)*[1 1],[0 pacfV(i)],'b','linewidth',1.5)
end
plot([0 maxtau+1],[0 0],'k','linewidth',1.5)
plot([0 maxtau+1],autlim*[1 1],'--c','linewidth',1.5)
plot([0 maxtau+1],-autlim*[1 1],'--c','linewidth',1.5)
xlabel('\tau') 
ylabel('\phi_{\tau,\tau}')
title('partial autocorrelation of time series of log demand of electricity at Central-Southern region')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%dokimh afairesh tashs me  diafores usterhshs 24%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%pairnw diafores usterhshs 24 sthn log price of electricity
taksh = 24
X24= zeros(length(X44)-taksh,1);
for t=1:length(X24)
    X24(t) = X44(t+taksh) - X44(t);
end
figure(4)
plot(X24)
title('difference of lag 24 of time series of log demand of electricity at Central-Southern region') 


%%%%%%%%%%%%%%%%%%%oi autosusxetiseis stis diafores usterhshs 24 sthn log demand of electricity%%%%%%%%%%%%%%%%%%%%%%%%
maxtau=550; 
alpha = 0.05;
zalpha = 1.96; 
acx1M = autocorrelation(X24,maxtau);
autlim = zalpha/sqrt(length(X24)); 
figure(5)
clf 
hold on
for i=1:maxtau   
    plot(acx1M(i+1,1)*[1 1],[0 acx1M(i+1,2)],'b','linewidth',1.5)
end
plot([0 maxtau+1],[0 0],'k','linewidth',1.5)
plot([0 maxtau+1],autlim*[1 1],'--c','linewidth',1.5)
plot([0 maxtau+1],-autlim*[1 1],'--c','linewidth',1.5)
xlabel('\tau') 
ylabel('r(\tau)')
title(sprintf('Autocorrelation of difference of lag 24 of time series of log demand of electricity at Central-Southern region '))

%%%%%%%%%%%%%%%%%%merikes autosusxetiseis gia diafores usterhshs 24 sth log demand%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
display = 1;
pacfV = parautocor(X24,maxtau);
figure(27)
clf
hold on
for i=1:maxtau
plot(acx1M(i+1,1)*[1 1],[0 pacfV(i)],'b','linewidth',1.5)
end
plot([0 maxtau+1],[0 0],'k','linewidth',1.5)
plot([0 maxtau+1],autlim*[1 1],'--c','linewidth',1.5)
plot([0 maxtau+1],-autlim*[1 1],'--c','linewidth',1.5)
xlabel('\tau')
ylabel('\phi_{\tau,\tau}')
title('partial autocorrelation of difference of lag 24 of time series of log demand of electricity at Central-Southern region')


%%%%%%%%%%%%% anazitisi montelou sarma (p,q)x(7,7)24 stis diafores usterhshs 24 %%%%%%%%%%%%%%%

%%%%%%%%%%%%  upologismos AIC kai diaforwn allwn statistikwn apo thn prosarmogi montelwn
%%%%%%%%%%%%  sarma (p,q)x(1,1)24 stis diafores usterhshs 24, me p,q apo to 0 ews to 10

n=length(X24)
 Tmax=1;
 AIC=NaN(10,10)
 ps=7;
 qs=7;
 s=24;
 for p=0:10;  
     for q=0:10;  
         [nrmseV,phiV,thetaV,SDz,aicS,fpeS]=fitSARMA(X24,p,q,ps,qs,s,Tmax);
         fprintf('===== SARMA model ===== \n');
         fprintf('Estimated coefficients of phi(B):\n');
         disp(phiV') 
         fprintf('Estimated coefficients of theta(B):\n');
         disp(thetaV') 
         fprintf('SD of noise: %f \n',SDz);
         fprintf('AIC: %f \n',aicS);
         fprintf('FPE: %f \n',fpeS); 
         fprintf('\t T \t\t NRMSE \n'); 
         disp([[1:Tmax]' nrmseV])
         AIC(p+1,q+1)=aicS; 
     end
 end
 AIC

%%%%%%%%%%%%%ta upoloipa tou montelou SARMA(10,7)x(7,7)24 sto 
%%%%%%%%%%%%%sunolo ekpaideusis 

Tmax=1;
nlast=876;
n=length(X24)
[nrmseV,preM] = predictSARMAnrmse(X24,10,7,7,7,24,1,nlast,'demand');
pragmatika = X24(1:(n-nlast));
problepseis= preM(1:(n-nlast));
residuals = pragmatika- problepseis;
length(residuals)

%%%%%%%%%%%%%%%%%to grafhma istorias twn upoloipwn tou montelou sto sunolo ekpaideusis einai

figure(2)
clf
plot(residuals)
title('residuals by fitting SARMA(10,7)x(7,7)24 on the training set')

%%%%%%%%%%%%%%%%%%oi autosusxetiseis twn upoloipwn tou montelou sto sunolo ekpaideusis

maxtau = 100;
acf = autocorrelation(residuals, maxtau);
autlim = 1.96/sqrt(length(residuals));
figure(12)
clf
hold on
for ii=1:maxtau
    plot(acf(ii+1,1)*[1 1],[0 acf(ii+1,2)],'b','linewidth',1.5)
end
plot([0 maxtau+1],[0 0],'k','linewidth',1.5)
plot([0 maxtau+1],autlim*[1 1],'--c','linewidth',1.5)
plot([0 maxtau+1],-autlim*[1 1],'--c','linewidth',1.5)
xlabel('\tau')
ylabel('r(\tau)')
title(sprintf('ACF for the residuals of SARMA(10,7)x(7,7)24 on the training set '))

%%%%%%%%%%%%%%%%%%Ljung-Box Test gia na dw an ta upoipa apoteloun leuko thorubo sto sunolo ekpaideushs%%%%%%%%%%%%%%%%%%%%%%%%

tittxt = sprintf('Ljung Box test for residuals');
figure(2)
clf
[h1V1,p1V1,Q1V1] = portmanteauLB(acf(2:maxtau+1,2),length(residuals),0.05,tittxt)

%%%%%%%%%%%%%%%%%%prosarmogi montelou  SARMA(10,7)x(7,7)24 sta dedomena kai upologismos diaforwn statistikwn%%%%%%%%%%%%%%%%%
[nrmseV,phiallV,thetaallV,SDz,aicS,fpeS]=fitSARMA(X24,10,7,7,7,24,1);
fprintf('===== SARMA model ===== \n');
fprintf('coefficients of phi(B) (including seasonal terms):\n');
disp(phiallV')
fprintf('coefficients of theta(B) (including seasonal terms):\n');
disp(thetaallV')
fprintf('SD of noise: %f \n',SDz);
fprintf('AIC: %f \n',aicS);
fprintf('FPE: %f \n',fpeS);
fprintf('\t T \t\t NRMSE \n');
disp([[1:Tmax]' nrmseV])
if Tmax>3
    figno = figno + 1;
    figure(figno)
    clf
    plot([1:Tmax]',nrmseV,'.-k')
    hold on
    plot([1 Tmax],[1 1],'y')
    xlabel('T')
    ylabel('NRMSE')
    title(sprintf('SARMA(%d,%d)x(%d,%d)_%d, fitting error',p,q,ps,qs,s))
end    


%%%%%%%%%%%%%%%%%%%%problepseis sto sunolo aksiologhshs me SARMA(10,7)x(7,7)24
%%%%%%%%%%%%%%%%%%%%gia 1,2,3,4,5 bhmata mprosta

nlast =876;
[nrmseV,preM] = predictSARMAnrmse(X24,10,7,7,7,24,5,nlast,'demand');

%%%%%%%%%%%%to nrmse gia 1 bhma problepsis sto test set einai:
nrmseV(1)

figure(1)
plot([n-nlast+1:n]',X24(n-nlast+1:n),'.-')
hold on
plot([n-nlast+1:n]',preM(n-nlast+1:n,1),'.-r')
hold on
plot([n-nlast+1:n]',preM(n-nlast+1:n,2),'.-y')
hold on
plot([n-nlast+1:n]',preM(n-nlast+1:n,3),'.-b')
hold on
plot([n-nlast+1:n]',preM(n-nlast+1:n,4),'.-c')
hold on
plot([n-nlast+1:n]',preM(n-nlast+1:n,5),'.-k')
hold on
legend('true','T=1','T=2','T=3','T=4','T=5','Location','Best')
title('predictions for 1:5 steps for test set')

%%%%%%%%%%%%%oi problepseis gia 1 bhma mprosta apo to montelo SARMA(10,7)x(7,7)24 sto sunolo aksiologhshs einai oi akolouthes

figure(2)
clf
plot([n-nlast+1:n]',X24(n-nlast+1:n),'.-')
hold on
plot([n-nlast+1:n]',preM(n-nlast+1:n,1),'.-r')
hold on
legend('true','T=1','Location','Best')
title('predictions for 1 step using SARMA(10,7)x(7,7)24 for test set')



