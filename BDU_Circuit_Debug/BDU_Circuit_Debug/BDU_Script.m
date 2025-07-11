clc; clear all; close all;

% Run simulation
sim('BDU.slx');

% Extract data (assuming all signals are timeseries)
time = ans.tout;
K1 = ans.K1;
current = ans.HVBatPack_Current_Prim;
voltage = ans.BPCM_Bus_Voltage;

% Plot all in one figure
figure; hold on;
plot(time, current, 'LineWidth', 2);
plot(time, voltage, 'LineWidth', 2);
hold off;

% Labeling
xlabel('Time (s)');
ylabel('Signal Value');
title('BDU Simulation Signals');
legend('HVBatPack Current Prim', 'BPCM Bus Voltage');
grid on;