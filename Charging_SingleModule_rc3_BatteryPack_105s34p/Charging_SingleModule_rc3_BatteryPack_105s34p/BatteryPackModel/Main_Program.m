clc; clear all; close all;

% Load and configure model
modelName = 'PackModelWithCurrentSource';
load_system(modelName);
set_param(modelName, 'StopTime', '3600');
set_param(modelName, 'SolverType', 'Fixed-step');
set_param(modelName, 'Solver', 'ode3');
set_param(modelName, 'FixedStep', '1');

% Run simulation
ans = sim(modelName);

plot(ans.tout, ans.voltage_sensor);
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Voltage Sensor Output');
grid on;