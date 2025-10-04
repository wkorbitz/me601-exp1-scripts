%% EIS Supplementary
clear all; close all; clc;


scan10 = [20 50 100 200 500];
Ipc = [-51.043 -71.640 -92.446 -127.423 -183.128];
Ipa = [28.099 51.561 56.732 62.13 79.856];

Epa = [0.2826 0.2926 0.3027 0.3128 0.333];
Epc = [0.1514 0.1413 0.1211 0.1009 0.0605];

CV = [];
CV_A = [];

skipRows = 0;
eis_scan = ["cv-10-20.csv" "cv-10-50.csv" "cv-10-100.csv" "cv-10-200.csv" "cv-10-500.csv" ];
for ii=1:5
    filename = eis_scan(ii);
    data = readmatrix(filename,'NumHeaderLines',skipRows);
    CV(:,ii) = data(:,1);
    CV_A(:,ii) = data(:,2);
end

cCV = [];
cCV_A = [];
eis_con = ["cv-1-100.csv" "cv-5-100.csv" "cv-10-100.csv"];
for ii=1:3
    filename = eis_con(ii);
    data = readmatrix(filename,'NumHeaderLines',skipRows);
    cCV(:,ii) = data(:,1);
    cCV_A(:,ii) = data(:,2);
end

figure(1)
subplot(1,2,1)
plot(sqrt(scan10), abs(Ipc),'b-o')
hold on
plot(sqrt(scan10),abs(Ipa),'r-o')
xlabel('Square root of scan rate [(mV/s)^{1/2}]','Interpreter','tex'); 
ylabel('Peak Current [\muA]','Interpreter','tex');
legend('Cathodic current I_{p,c}','Anodic current I_{p,a}','Interpreter','tex','Location','northwest');
title('Peak CV Currents under varied Scan Rate \nu^{1/2}','Interpreter','tex');
subplot(1,2,2)
plot(scan10,Epa,'r-o')
hold on
plot(scan10,Epc,'b-o')
xlabel('Scan rate [mV/s]'); ylabel('Peak Potential [mV]');
legend('Anodic peak E_{pa}','Cathodic peak E_{pc}','Interpreter','tex','Location','northwest');
title('Peak CV Potentials under varied Scan Rate \nu^{1/2}','Interpreter','tex');

figure(2)
subplot(1,2,1)
hold on
for ii=1:5
    plot(CV(:,ii),CV_A(:,ii),'-')
end
ylabel('Current [\muA]','Interpreter','tex');xlabel('Voltage [mV]');
title('CV Response under varied scan rate, constant concentration C = 10mM');
legend('\nu = 20 mV/s', '\nu = 50 mV/s','\nu = 100 mV/s','\nu = 200 mV/s','\nu = 500 mV/s','Location','northwest');
axis([-0.4 0.6 -250 100]);

subplot(1,2,2)
hold on
for ii=1:3
    plot(cCV(:,ii),cCV_A(:,ii),'-')
end
ylabel('Current [\muA]','Interpreter','tex');xlabel('Voltage [mV]');
title('CV Response under varied analyte concentrations, constant scan rate \nu = 100 mV/s','Interpreter','tex');
legend('C = 1 mM','C = 5 mM','C = 10 mM','Location','northwest');
axis([-0.4 0.6 -125 75])