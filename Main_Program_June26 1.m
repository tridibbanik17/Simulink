% McMaster Automotive Resource Centre (MARC)
% Electrical Engineer - Romulo Vieira, M.Sc and MBA - PhD Candidate,
clc; clear all; close all

sim('Simulink_Program_June26.slx')

Max_Precharge_Current        = max(ans.Ke_I_HighVoltageBusShortageCurrent); 
Pre_charge_Time              = 1000*max(ans.Ke_t_HighVoltageBusPrechargeTime);
Pre_charge_Voltage_Threshold = max(ans.Ke_V_HighVoltagePreChargeThreshold);

%% Input Signal Initialization
% SimulationTime
% Define the step signal
MainHVBatCntctrCmd = zeros(size(ans.Time));
MainHVBatCntctrCmd(ans.Time >= 0.5) = 1;
% Constant values
HVBatPrechgInbt = 0;
HVBatInitHVIL = 1;
PrechargeAllw = 1;
HVInvRatVlt = 1;
HVInvRatVltV = 1;
VehicleSpeed = 0;
Ke_U_WeldCheckVoltageThreshold = 60;
Ke_v_WeldCheckEnableSpeed = 5;
PDCVoltage = 12;
ErrorRAM = 0;
ErrorROM = 0;
ErrorEEPROM = 0;
FailureMicroController = 0;
HWWakeUp = 1;
K1_CoilHigh_Voltage = 12;
K2_CoilHigh_Voltage = 12;
K3_CoilHigh_Voltage = 12;
K4_CoilHigh_Voltage = 12;
K1_CoilLow_Voltage  = 12;
K2_CoilLow_Voltage  = 12;
K3_CoilLow_Voltage  = 12;
K4_CoilLow_Voltage  = 12;


figure(1)
plot(ans.Time, ans.K1, 'LineWidth', 2);
hold on
plot(ans.Time, ans.K2, 'LineWidth', 2);
hold on
plot(ans.Time, ans.K3, 'LineWidth', 1);
hold on
plot(ans.Time, ans.K4, 'LineWidth', 2);
hold off
ylabel('Contactor Output Signals');
xlim([0 1])
ylim([-0.5 1.5])
grid on;
ax = gca;
ax.FontSize = 18;
legend('Main Contactor','Precharge Relay (-)', 'Precharge Relay (+)','DCFC Contactor','Fontsize', 12,'Location','northwest')

% Add vertical line that represents the initial time of the precharge
% sequence
xline((0.5), '--', 'HandleVisibility', 'off');
labelStr = sprintf(' Start time of precharge sequence:\n t_{s} = %.1f s ', 0.5);
text(0.5, -0.25, labelStr, ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'middle', ...
    'Rotation', 0, ...
    'FontSize', 8.5);

% Add vertical line that represents the elapsed time where 98% pack voltage is reached
xline((0.5+0.001*Pre_charge_Time), '--', 'HandleVisibility', 'off');
labelStr = sprintf(' Duration of precharge sequence: \n \\Deltat = %.0f ms', Pre_charge_Time);
text((0.5+0.001*Pre_charge_Time), -0.25, labelStr, ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'middle', ...
    'Rotation', 0, ...
    'FontSize', 8.5);

%% Plot Precharge Current for the Battery Pack
figure(2)
plot(ans.tout, ans.HVBatPack_Current_Prim ...
    , 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Measured Current (A)');
xlim([0 1])
ylim([0 20])
grid on;
ax = gca;
ax.FontSize = 18;
Leg1 = sprintf('Precharge Current');
Leg = legend(Leg1);
Leg.FontSize = 12;
Leg.Location = "southwest";
% Draw max precharge current line without built-in label
yline(Max_Precharge_Current, '--', 'HandleVisibility', 'off');

% Add max current text label on the left
labelStr = sprintf('Maximum current during precharge \nsequence = %.1f A', Max_Precharge_Current);
text(0.01, Max_Precharge_Current, labelStr, ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top', ...
    'FontSize', 8.5);

% Add vertical line that represents the initial time of the precharge
% sequence
xline((0.5), '--', 'HandleVisibility', 'off');
labelStr = sprintf(' Start time of precharge sequence:\n t_{s} = %.1f s ', 0.5);
text(0.5, Max_Precharge_Current/2, labelStr, ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'middle', ...
    'Rotation', 0, ...
    'FontSize', 8.5);

% Add vertical line that represents the elapsed time where 98% pack voltage is reached
xline((0.5+0.001*Pre_charge_Time), '--', 'HandleVisibility', 'off');
labelStr = sprintf(' Duration of precharge sequence: \n \\Deltat = %.0f ms', Pre_charge_Time);
text((0.5+0.001*Pre_charge_Time), Max_Precharge_Current/2, labelStr, ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'middle', ...
    'Rotation', 0, ...
    'FontSize', 8.5);

%% Plot Precharge Voltage of the Battery Pack
figure(3)
plot(ans.tout, ans.BPCM_PreCharge_Pack_Voltage_Aux, 'LineWidth', 2);
hold on
plot(ans.tout, ans.BPCM_Bus_Voltage, 'LineWidth', 2);
hold off
ylabel('Measured Voltage (V)');
xlim([0 1])
ylim([0 500])
grid on
ax = gca;
ax.FontSize = 18;
legend('Battery Pack Voltage','DC Link Bus Voltage','Fontsize', 12,'Location','southwest')

% Add vertical line that represents the initial time of the precharge
% sequence
xline((0.5), '--', 'HandleVisibility', 'off');
labelStr = sprintf(' Start time of precharge sequence:\n t_{s} = %.1f s ', 0.5);
text(0.5, ans.BPCM_Bus_Voltage(end)/2, labelStr, ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'middle', ...
    'Rotation', 0, ...
    'FontSize', 8.5);

% Add vertical line that represents the elapsed time where 98% pack voltage is reached
xline((0.5+0.001*Pre_charge_Time), '--', 'HandleVisibility', 'off');
labelStr = sprintf(' Duration of precharge sequence: \n \\Deltat = %.0f ms', Pre_charge_Time);
text((0.5+0.001*Pre_charge_Time), ans.BPCM_Bus_Voltage(end)/2, labelStr, ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'middle', ...
    'Rotation', 0, ...
    'FontSize', 8.5);


% Add horizontal line that represents 98% pack voltage threshold
yline(Pre_charge_Voltage_Threshold, '--', 'HandleVisibility', 'off');
labelStr = sprintf(' Precharge voltage threshold = %.1f V', Pre_charge_Voltage_Threshold);
text(0.01, Pre_charge_Voltage_Threshold, labelStr, ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top', ...
    'FontSize', 8.5);


xlabel('Time (s)');

%% Plot Battery Contactor Control Status
figure(4)
plot(ans.Time, ans.HVBatCntctrStat, 'LineWidth', 2);
ylabel('Battery Control Status');
xlim([0 1])
ylim([0 5])
grid on
ax = gca;
ax.FontSize = 18;

% Add vertical line that represents the initial time of the precharge
% sequence
xline((0.5), '--', 'HandleVisibility', 'off');
labelStr = sprintf(' Start time of precharge sequence:\n t_{s} = %.1f s ', 0.5);
text(0.5, 2.5, labelStr, ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'middle', ...
    'Rotation', 0, ...
    'FontSize', 8.5);

% Add vertical line that represents the elapsed time where 98% pack voltage is reached
xline((0.5+0.001*Pre_charge_Time), '--', 'HandleVisibility', 'off');
labelStr = sprintf(' Duration of precharge sequence: \n \\Deltat = %.0f ms', Pre_charge_Time);
text((0.5+0.001*Pre_charge_Time), 2.5, labelStr, ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'middle', ...
    'Rotation', 0, ...
    'FontSize', 8.5);

xlabel('Time (s)');
%% Plot Diagnostic Trouble Code (DTC) Signal
figure(5)
plot(ans.DTC.Time, ans.DTC.Data, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Diagnostic Trouble Code (DTC)');
xlim([0 1]);
ylim([0 4]); % DTC values: 0 = OK, 1–3 = faults
grid on;
ax = gca;
ax.FontSize = 18;
yticks([0 1 2 3]);
yticklabels({'None', 'Shorted Bus', 'Too Long', 'Too Short'});

% Add vertical line for start of precharge
xline(0.5, '--', 'HandleVisibility', 'off');
labelStr = sprintf(' Start time of precharge sequence:\n t_{s} = %.1f s ', 0.5);
text(0.5, 0.5, labelStr, ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'middle', ...
    'FontSize', 8.5);

% Add vertical line for end of precharge
xline(0.5 + 0.001 * Pre_charge_Time, '--', 'HandleVisibility', 'off');
labelStr = sprintf(' Duration of precharge sequence: \n \\Deltat = %.0f ms', Pre_charge_Time);
text(0.5 + 0.001 * Pre_charge_Time, 0.5, labelStr, ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'middle', ...
    'FontSize', 8.5);

legend('DTC', 'FontSize', 12, 'Location', 'northeast');
%% Figure 6: HV Bus Voltage Sensor Validity
figure(6)
plot(ans.usePrimaryHVBusVoltageSensor.Time, ans.usePrimaryHVBusVoltageSensor.Data, 'g-', 'LineWidth', 2); hold on;
plot(ans.useBackupHVBusVoltageSensor.Time, ans.useBackupHVBusVoltageSensor.Data, 'b--', 'LineWidth', 2);
plot(ans.bothHVBusVoltageSensorsInvalid.Time, ans.bothHVBusVoltageSensorsInvalid.Data, 'r:', 'LineWidth', 2); hold off;

xlabel('Time (s)');
ylabel('Sensor Credibility Flag');
legend('Primary Sensor Valid', 'Backup Sensor Valid', 'Both Invalid', 'FontSize', 12, 'Location', 'best');
ylim([-0.1 1.1]);
grid on;
ax = gca;
ax.FontSize = 18;
%% Figure 7: Section I-12 — Contactor Command vs Status vs DTC
figure(7)
yyaxis left
plot(ans.Time, ans.MainHVBatCntctrCmd, 'k-', 'LineWidth', 2); hold on;
plot(ans.Time, ans.HVBatCntctrStat, 'g--', 'LineWidth', 2);
ylabel('Contactor Status');
ylim([-0.5 5.5]);
yticks(0:5)
yticklabels({'Open', 'PreCharging', 'Closed', 'Failed', 'Inhibited', 'SNA'});

yyaxis right
plot(ans.DTC.Time, ans.DTC.Data, 'r:', 'LineWidth', 2);
ylabel('DTC');
ylim([-0.5 14.5])
yticks(0:2:14)

grid on;
xlabel('Time (s)');
legend('Main Cmd','Contactor Status','DTC','FontSize',12, 'Location', 'northeast');
ax = gca;
ax.FontSize = 18;
%% Figure 8: Weld Check Diagnostic — Section I-13 & I-14
figure(8)
yyaxis left
plot(ans.Time, ans.HVBatCntctrStat, 'b-', 'LineWidth', 2);
ylabel('Contactor Status');
ylim([-0.5 7.5])
yticks(0:1:7)
yticklabels({'Open','Precharging','Closed','Failed','Inhibited','Imp. Open','Impact Open','SNA'})

yyaxis right
% Resample BPCM_Bus_Voltage to match length of ans.Time
BPCM_Bus_Voltage_Resampled = interp1(linspace(0, 1, length(ans.BPCM_Bus_Voltage)), ans.BPCM_Bus_Voltage, ans.Time);
plot(ans.Time, BPCM_Bus_Voltage_Resampled, 'r--', 'LineWidth', 2);
ylabel('Bus Voltage (V)');
ylim([0 500])

xlabel('Time (s)');
xlim([0 1])
grid on
legend('HVBatCntctrStat', 'Bus Voltage', 'FontSize', 12, 'Location', 'best');

% Highlight weld detection (DTC = 15)
idx_weld = find(ans.DTC.Data == 15, 1, 'first');
if ~isempty(idx_weld)
    weld_time = ans.Time(idx_weld);
    xline(weld_time, '--k', 'Weld Detected', ...
        'LabelVerticalAlignment','bottom', ...
        'FontSize', 9, 'LabelOrientation','horizontal', ...
        'LineWidth', 1.5);
end

% Weld check voltage threshold 
Ke_U_WeldCheckVoltageThreshold = ans.Ke_U_WeldCheckVoltageThreshold(end); 
yline(Ke_U_WeldCheckVoltageThreshold, ':r', ...
    'DisplayName', sprintf('Threshold = %.1f V', Ke_U_WeldCheckVoltageThreshold), ...
    'LabelVerticalAlignment', 'bottom', ...
    'FontSize', 8.5, 'LineWidth', 1.5);
legend('FontSize', 12, 'Location', 'best');

ax = gca;
ax.FontSize = 18;

%% Figure 9: Conditions to Interrupt Contactor Weld Check and Weld Retry — Section I-15
figure(9)

yyaxis left
plot(ans.Time, ans.HVBatCntctrStat, 'b-', 'LineWidth', 2);
ylabel('Contactor Status');
ylim([-0.5 7.5])
yticks(0:1:7)
yticklabels({'Open','Precharging','Closed','Failed','Inhibited','Imp. Open','Impact Open','SNA'})

yyaxis right
plot(ans.DTC.Time, ans.DTC.Data, 'r--', 'LineWidth', 2);
ylabel('DTC');
ylim([0 16])
yticks([0 1 2 4 5 8 9 10 11 12 13 14 15])
grid on;

xlabel('Time (s)');
xlim([0 1])
legend('Contactor Status','DTC', 'FontSize', 12, 'Location', 'northeast');

% Weld retry triggered
retryIdx = find(ans.DTC.Data == 15, 1, 'first');
if ~isempty(retryIdx)
    retryTime = ans.Time(retryIdx);
    xline(retryTime, '--k', 'Weld Retry Triggered', ...
        'LabelVerticalAlignment','bottom', ...
        'FontSize', 9, ...
        'LabelOrientation','horizontal', ...
        'LineWidth', 1.5);
end

ax = gca;
ax.FontSize = 18;

%% Figure 10: Section I-16 — Contactor Coil Diagnostic States (High & Low Side)
figure(10)

% Diagnostic labels for reference
diagnosticLabels = {'NORMAL', 'SHORTED\_LOW', 'SHORTED\_HIGH', 'OPEN'};

% Define contactor coil names
coilNames = {'K1', 'K2', 'K3', 'K4'};  

% Correct extraction of final diagnostic values (avoids squeeze issues)
finalHigh = reshape(ans.CoilHighState_Out.Data(1, :, end), [4, 1]);  % [4x1]
finalLow  = reshape(ans.CoilLowState_Out.Data(1, :, end),  [4, 1]);  % [4x1]

% Combine into [4x2] matrix
barData = [finalHigh, finalLow];  % Each row = coil (K1–K4), columns = High/Low

% Create grouped bar chart
bar(barData, 'grouped');
ylim([-0.5, 3.5]);
yticks(0:3);
yticklabels(diagnosticLabels);
xticklabels(coilNames);
xlabel('Contactor Coils');
ylabel('Diagnostic State');
legend({'High Side', 'Low Side'}, 'Location', 'northoutside', 'Orientation', 'horizontal');
grid on;

% Set font size
ax = gca;
ax.FontSize = 18;

%% Figure 11: Section I-17 Contactor Stuck Open Diagnostics
figure(11); clf;


% Plot all signals in a single axis 
plot(ans.Time, ans.MainHVBatCntctrCmd,       'k--', 'LineWidth', 1.5); hold on;
plot(ans.Time, ans.HVBatCntctrStat,          'b--', 'LineWidth', 1.5);
plot(ans.Time, ans.HVBatCntctrWeld_ImpdOpn.Data,  'r--', 'LineWidth', 1.5);
plot(ans.Time, ans.DTC.Data,                      'm--', 'LineWidth', 1.5);
plot(ans.Time, ans.Abort_ClosingSequence.Data,    'g--', 'LineWidth', 1.5);
hold off;

% Axes labels, limits, and ticks
xlabel('Time (s)');
ylabel('Signal Value');
ylim([-0.5 25.5]);
yticks(0:25);

% Legend (matched to line order and colors)
legend({'Main Cmd', 'Cntctr Stat', 'Stuck Open', 'DTC', 'Abort'}, ...
    'Location', 'eastoutside');

% Grid and font settings
grid on;

% Match font size to Figure 10
ax = gca;
ax.FontSize = 18;


