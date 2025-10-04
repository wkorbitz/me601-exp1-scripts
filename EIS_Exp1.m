%% EIS Analysis Script

clear; clc; close all;

filename = 'eis-dc-3.csv';
skipRows = 0;
data = readmatrix(filename,'NumHeaderLines',skipRows);

freq = data(:,1); phase = data(:,2);
Idc = data(:,3); 
Z = data(:,4); Zp = data(:,5); nZpp = data(:,6);
Cs = data(:,7);

eis_con = ["eis-1-10mV.csv", "eis-5-10.csv", "eis-background-10.csv"];
cEIS = [];
cEISf = [];
for ii=1:3
    data = readmatrix(eis_con(ii),'NumHeaderLines',skipRows);
    cEIS(:,ii) = data(:,4);
    cEISf(:,ii) = data(:,1);
end

eis_pot = ["eis-background-10.csv", "eis-dc-1.csv", "eis-dc-3.csv"];
EISdc = [];
EISf = [];
for ii=1:3
    data = readmatrix(eis_pot(ii),'NumHeaderLines',skipRows);
    EISdc(:,ii) = data(:,4);
    EISf(:,ii) = data(:,1);
end
figure(1)
plot(Zp, nZpp, '-o')
title('EIS Nyquist Plot (C=10mM, V_{AC}=10mV, V_{DC}=30mV)');
ylabel('-Z'''''); xlabel('Z''')
hold on
figure(2)
plot(log(freq), Z,'-o')
ylabel('Complex Impedance Magnitude |Z| [\Omega]'); xlabel('log of AC frequency [log_{10}f]');
title('EIS Bode Plot (C=10mM, V_{AC}=10mV, V_{DC}=30mV)')
hold on
plot(log(freq),-phase,'r-o')
%title(filename);
%xlabel('log of frequency'); 
legend('Magnitude Z','Negative phase')
figure(3)
hold on
for ii=1:3
    plot(log10(cEISf(:,ii)),cEIS(:,ii),'-o');
end
xlabel('log of frequency [log_{10} Hz]','Interpreter','tex');
ylabel('Magnitude Z, \Omega','Interpreter','tex');
legend('C = 1mM','C = 5mM','C = 10mM');

figure(4)
hold on
for ii=1:3
    plot(log10(EISf(:,ii)),EISdc(:,ii),'-o');
end
xlabel('log of frequency [log_{10} Hz]','Interpreter','tex');
ylabel('Magnitude Z, \Omega','Interpreter','tex');
legend('DC \phi = 0mV','DC \phi = 10mV','DC \phi = 30mV','Interpreter','tex');

acs=["eis-background-1.csv","eis-background-5.csv","eis-background-10.csv"];
for ii=1:3
    data = readmatrix(acs(ii),'NumHeaderLines',skipRows);
    aZp(:,ii) = data(:,5);
    aZpp(:,ii) = data(:,6);
end
figure(5)
hold on
for ii=1:3
    plot(aZp(:,ii),aZpp(:,ii),'-o')
end
title('EIS Nyquist Plots at Varying AC Amplitude (C=10mM, V_{DC}=30mV)');
ylabel('-Z'''''); xlabel('Z'''); legend('AC \phi = 1mV', 'AC \phi = 5mV', 'AC \phi = 10mV')