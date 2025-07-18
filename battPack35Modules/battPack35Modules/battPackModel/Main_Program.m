clc; clear all; close all;

% Load and configure model
modelName = 'PackModelWithCurrentSource';
load_system(modelName);
set_param(modelName, 'StopTime', '10');
set_param(modelName, 'SolverType', 'Fixed-step');
set_param(modelName, 'Solver', 'ode3');
set_param(modelName, 'FixedStep', '0.01');

% Run simulation
ans = sim(modelName);

