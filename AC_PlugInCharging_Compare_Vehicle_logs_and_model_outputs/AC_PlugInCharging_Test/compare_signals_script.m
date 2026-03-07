clc; clear;

%% Load Vehicle Log
load('Sample_Level2.mat');
Data_vehicle = Data;

%% Assign log variables to base workspace for Simulink
vars_of_interest = { ...
    'DCChargeInitialized','MainHighVltCntctrCmd','ChargingSysSts',...
    'Charger_Plugin_Status','HVBatCell_Voltage_High_Thrsh','HVBatRdy',...
    'HVBatModTempMax','HVBatCellVltMax','HVBatSOCMax' ...
};

for i = 1:length(vars_of_interest)
    field = vars_of_interest{i};
    t = Data_vehicle.(field).time(:);
    v = Data_vehicle.(field).val(:);
    assignin('base', field, [t v]);   % must be in base workspace
end

%% Run Simulink Model
modelName = 'AC_PlugInCharging';
simOut = sim(modelName);   % From Workspace blocks can now read variables

%% Convert simOut to Data_model structure
signals = { 'HVBatChargeStat','HVBat_DC_CntctrStat','HVBatMaxCellVltAlld','HVBatMaxPkVltAllwd' };
Data_model = struct();
for i = 1:length(signals)
    sigName = signals{i};
    y = simOut.get(sigName);
    t = simOut.tout(:);
    Data_model.(sigName).time = t;
    Data_model.(sigName).val  = y(:);
end

%% Compare signals
compare_signals(Data_model, Data_vehicle, signals, 0.01, 2);