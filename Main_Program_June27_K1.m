% McMaster Automotive Resource Centre (MARC)
% Electrical Engineer - Romulo Vieira, M.Sc and MBA - PhD Candidate,
clc; clear all; close all

sim('Simulink_Program_June27_K1.slx')

Max_Precharge_Current        = max(ans.Ke_I_HighVoltageBusShortageCurrent); 
Pre_charge_Time              = 1000*max(ans.Ke_t_HighVoltageBusPrechargeTime);
Pre_charge_Voltage_Threshold = max(ans.Ke_V_HighVoltagePreChargeThreshold);

figure(1)
plot(ans.Time, ans.K1, 'LineWidth', 2);
hold on
plot(ans.Time, ans.K2, 'LineWidth', 2);
hold on
plot(ans.Time, ans.K3, 'LineWidth', 1);
hold on
plot(ans.Time, ans.K4, 'LineWidth', 2);

hold on
% Overlay coil diagnostic states for K1
scatter(ans.Time(ans.K1_Coil_State == 0), repmat(1.3, sum(ans.K1_Coil_State == 0), 1), 20, 'bo', 'filled', 'DisplayName', 'K1: OPEN');
scatter(ans.Time(ans.K1_Coil_State == 1), repmat(1.3, sum(ans.K1_Coil_State == 1), 1), 20, 'g^', 'filled', 'DisplayName', 'K1: NORMAL');
scatter(ans.Time(ans.K1_Coil_State == 2), repmat(1.3, sum(ans.K1_Coil_State == 2), 1), 20, 'rs', 'filled', 'DisplayName', 'K1: SHORTED\_HIGH');
scatter(ans.Time(ans.K1_Coil_State == 3), repmat(1.3, sum(ans.K1_Coil_State == 3), 1), 20, 'mo', 'filled', 'DisplayName', 'K1: SHORTED\_LOW');

% % Overlay coil diagnostic states for K2 and K3
% scatter(ans.Time(ans.K2_and_K3_Coil_State == 0), repmat(1.3, sum(ans.K2_and_K3_Coil_State == 0), 1), 20, 'bo', 'filled', 'DisplayName', 'K2 and K3: OPEN');
% scatter(ans.Time(ans.K2_and_K3_Coil_State == 1), repmat(1.3, sum(ans.K2_and_K3_Coil_State == 1), 1), 20, 'g^', 'filled', 'DisplayName', 'K2 and K3: NORMAL');
% scatter(ans.Time(ans.K2_and_K3_Coil_State == 2), repmat(1.3, sum(ans.K2_and_K3_Coil_State == 2), 1), 20, 'rs', 'filled', 'DisplayName', 'K2 and K3: SHORTED\_HIGH');
% scatter(ans.Time(ans.K2_and_K3_Coil_State == 3), repmat(1.3, sum(ans.K2_and_K3_Coil_State == 3), 1), 20, 'mo', 'filled', 'DisplayName', 'K2 and K3: SHORTED\_LOW');

% % Overlay coil diagnostic states for K4
% scatter(ans.Time(ans.K4_Coil_State == 0), repmat(1.3, sum(ans.K4_Coil_State == 0), 1), 20, 'bo', 'filled', 'DisplayName', 'K4: OPEN');
% scatter(ans.Time(ans.K4_Coil_State == 1), repmat(1.3, sum(ans.K4_Coil_State == 1), 1), 20, 'g^', 'filled', 'DisplayName', 'K4: NORMAL');
% scatter(ans.Time(ans.K4_Coil_State == 2), repmat(1.3, sum(ans.K4_Coil_State == 2), 1), 20, 'rs', 'filled', 'DisplayName', 'K4: SHORTED\_HIGH');
% scatter(ans.Time(ans.K4_Coil_State == 3), repmat(1.3, sum(ans.K4_Coil_State == 3), 1), 20, 'mo', 'filled', 'DisplayName', 'K4: SHORTED\_LOW');

hold off
ylabel('Contactor Output Signals');
xlim([0 1])
ylim([-0.5 1.5])
grid on;
ax = gca;
ax.FontSize = 18;
legend('Main Contactor','Precharge Relay (-)', 'Precharge Relay (+)','DCFC Contactor', 'OPEN', 'NORMAL', 'K1: SHORTED\_HIGH', 'K1: SHORTED\_LOW', 'Fontsize', 12,'Location','northwest')

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



