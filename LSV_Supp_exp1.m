%% LSV Plotting for Exp 1
close all; clear all; clc;


filename = 'lsv-10-500.csv'; % Your raw data file: [Voltage (V), Current (A)]
electrode_area = 0.196e-4; % cm^2 (example: 5 mm diameter disk)
n = 1;                     % number of electrons (ferri/ferrocyanide = 1)
T = 298.15;                % temperature (K)
alpha = 0.5;               % charge transfer coefficient (assume 0.5)
R = 8.314;                 % J/mol/K
F = 96485;                 % C/mol

lsv_scan = ["lsv-10-20.csv", "lsv-10-50.csv", "lsv-10-100.csv", "lsv-10-200.csv", "lsv-10-500.csv", ];
lsv_con = ["lsv-1-100.csv", "lsv-5-100.csv", "lsv-10-100.csv"];

for ii=1:5
    data = readmatrix(lsv_scan(ii),'NumHeaderLines',0);
    Iscan(:,ii) = data(7:66,2);
    jscan(:,ii) = Iscan(:,ii) ./ electrode_area;
    Vscan(:,ii) = data(7:66,1);
    E_eq = interp1(jscan(:,ii), Vscan(:,ii), 0, 'linear', 'extrap');
    Vscan(:,ii) = Vscan(:,ii) - E_eq;
end

for ii=1:3
    data = readmatrix(lsv_con(ii),'NumHeaderLines',0);
    Icon(:,ii) = data(7:66,2);
    jcon(:,ii) = Icon(:,ii)./electrode_area;
    Vcon(:,ii) = data(7:66,1);
    E_eq = interp1(jcon(:,ii), Vcon(:,ii), 0, 'linear', 'extrap');
    Vcon(:,ii) = Vcon(:,ii) - E_eq;
end



data = readmatrix(filename);
E = data(:,1); % V
E = E(1:numel(E)-1);
I = data(:,2); % A
I = I(1:numel(I)-1);

figure(1)
hold on
for ii=1:5
    plot(Vscan(:,ii),log(abs(Iscan(:,ii))),'-o')
end
xlabel('Potential E [mV]'); ylabel('log of Current log|I| [log_{10} \muA]');
legend('\nu = 20 mV/s','\nu = 50 mV/s','\nu = 100 mV/s','\nu = 200 mV/s','nu = 500 MV/s','Location','southeast'); 
title('Centered Tafel Plot of LSV results under varying scan rate \nu');
y=linspace(-4,5,50);x=zeros(50,1);
plot(x,y,'k--')
axis([-0.2 0.4 -4 5]);

figure(2)
hold on
for ii=1:3
    plot(Vcon(:,ii),log(abs(Icon(:,ii))),'-o')
end
xlabel('Potential E [mV]'); ylabel('log of Current log|I| [log_{10} \muA]');
legend('C = 1mM','C = 5mM','C = 10mM','Location','southeast'); 
title('Centered Tafel Plot of LSV results under varying analyte concentration C');
y=linspace(-4,5,50);x=zeros(50,1);
plot(x,y,'k--')
axis([-0.2 0.4 -1 5]);
