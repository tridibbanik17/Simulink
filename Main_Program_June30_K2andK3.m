% McMaster Automotive Resource Centre (MARC)
% Electrical Engineer - Romulo Vieira, M.Sc and MBA - PhD Candidate,
clc; clear all; close all

sim('Simulink_Program_June30_K2andK3.slx')

Max_Precharge_Current        = max(ans.Ke_I_HighVoltageBusShortageCurrent); 
Pre_charge_Time              = 1000*max(ans.Ke_t_HighVoltageBusPrechargeTime);
Pre_charge_Voltage_Threshold = max(ans.Ke_V_HighVoltagePreChargeThreshold);

figure(1)
plot(ans.K2.Time, ans.K2.Data, 'b-', 'LineWidth', 2, 'DisplayName', 'Precharge Relays');
hold on
plot(ans.K1.Time, ans.K1.Data, 'r--', 'LineWidth', 2, 'DisplayName', 'Main Contactor');
hold on 
plot(ans.MainHVBatCntctrCmd.Time, ans.MainHVBatCntctrCmd.Data, 'y--', 'LineWidth', 2, 'DisplayName', 'MainHVBatCntctrCmd');
hold on
% plot(ans.BPCM_Bus_Voltage.Time, ans.BPCM_Bus_Voltage.Data, 'LineWidth', 2, 'DisplayName', 'MainHVBatCntctrCmd');
hold on

% hold on
% plot(ans.K2.Time, ans.K2.Data, 'LineWidth', 2, 'DisplayName', 'Precharge (-) Relay');
% hold on
% plot(ans.K3.Time, ans.K3.Data, 'LineWidth', 1, 'DisplayName', 'Precharge (+) Relay');
% hold on
% plot(ans.Time, ans.K4, 'LineWidth', 2, 'DisplayName', 'DCFC Contactor');







%% K1 regions
hold on
% Define colors for the 4 coil states of interest
colors = [
    0.2 0.6 1.0;  % 0 = OPEN            Light Sky Blue
    0.2 1.0 0.2;  % 1 = CLOSED          Bright Lime Green
    1.0 0.0 1.0   % 3 = SHORTED_LOW     Magenta / Hot Pink
    1.0 0.3 0.3;  % 2 = SHORTED_HIGH    Light Red
];

labels = {
    'OPEN Region', 'CLOSED Region', 'SHORTED\_LOW Region', 'SHORTED\_HIGH Region'
};

% Corresponding states and their color/label indices
valid_states = [0, 1, 3, 2];
color_indices = [1, 2, 3, 4];  % match colors and labels index

t = ans.Time;
coil_state = ans.K2_and_K3_Coil_State;

hold on
for k = 1:length(valid_states)
    state = valid_states(k);
    mask = (coil_state == state);

    % Find start and end of each region where this state occurs
    d = diff([0; mask; 0]);
    start_idx = find(d == 1);
    end_idx = find(d == -1) - 1;

    for i = 1:length(start_idx)
        x1 = t(start_idx(i));
        x2 = t(end_idx(i));
        patch([x1 x2 x2 x1], [-0.5 -0.5 1.5 1.5], ...
              colors(color_indices(k), :), ...
              'FaceAlpha', 0.25, ...
              'EdgeColor', 'none', ...
              'DisplayName', labels{color_indices(k)});
    end
end





%% K2 and K3 regions
% hold on
% % Define colors for the 4 coil states of interest
% colors = [
%     0.2 0.6 1.0;  % 0 = OPEN
%     0.2 1.0 0.2;  % 1 = CLOSED
%     1.0 0.3 0.3;  % 3 = SHORTED_HIGH
%     1.0 0.0 1.0   % 4 = SHORTED_LOW
% ];
% 
% labels = {
%     'OPEN Region', 'CLOSED Region', 'SHORTED\_HIGH Region', 'SHORTED\_LOW Region'
% };
% 
% valid_states = [0, 1, 3, 4];
% color_indices = [1, 2, 3, 4];
% 
% t = ans.Time;
% coil_state = ans.K2_and_K3_Coil_State;
% 
% % Track which states we've already added to legend
% legend_flags = zeros(1, length(valid_states));  % 0 = not used yet
% 
% for k = 1:length(valid_states)
%     state = valid_states(k);
%     mask = (coil_state == state);
% 
%     d = diff([0; mask; 0]);
%     start_idx = find(d == 1);
%     end_idx = find(d == -1) - 1;
% 
%     for i = 1:length(start_idx)
%         x1 = t(start_idx(i));
%         x2 = t(end_idx(i));
% 
%         % Only add DisplayName for the first patch of each state
%         if legend_flags(k) == 0
%             patch([x1 x2 x2 x1], [-0.5 -0.5 1.5 1.5], ...
%                 colors(color_indices(k), :), ...
%                 'FaceAlpha', 0.15, ...
%                 'EdgeColor', 'none', ...
%                 'DisplayName', labels{color_indices(k)});
%             legend_flags(k) = 1;
%         else
%             patch([x1 x2 x2 x1], [-0.5 -0.5 1.5 1.5], ...
%                 colors(color_indices(k), :), ...
%                 'FaceAlpha', 0.15, ...
%                 'EdgeColor', 'none');
%         end
%     end
% end





%% K4 regions
% hold on
% % Define colors for the 4 coil states of interest
% colors = [
%     0.0 1.0 0.0   % -1 = INVALID
%     0.2 0.6 1.0;  % 0 = OPEN
%     0.2 1.0 0.2;  % 1 = CLOSED
%     1.0 0.3 0.3;  % 3 = SHORTED_HIGH
%     1.0 0.0 1.0;  % 4 = SHORTED_LOW
% ];
% 
% labels = {
%     'INVALID', 'OPEN Region', 'CLOSED Region', 'SHORTED\_HIGH Region', 'SHORTED\_LOW Region'
% };
% 
% valid_states = [-1, 0, 1, 3, 4];
% color_indices = [1, 2, 3, 4, 5];
% 
% t = ans.Time;
% coil_state = ans.K4_Coil_State;
% 
% % Track which states we've already added to legend
% legend_flags = zeros(1, length(valid_states));  % 0 = not used yet
% 
% for k = 1:length(valid_states)
%     state = valid_states(k);
%     mask = (coil_state == state);
% 
%     d = diff([0; mask; 0]);
%     start_idx = find(d == 1);
%     end_idx = find(d == -1) - 1;
% 
%     for i = 1:length(start_idx)
%         x1 = t(start_idx(i));
%         x2 = t(end_idx(i));
% 
%         % Only add DisplayName for the first patch of each state
%         if legend_flags(k) == 0
%             patch([x1 x2 x2 x1], [-0.5 -0.5 1.5 1.5], ...
%                 colors(color_indices(k), :), ...
%                 'FaceAlpha', 0.15, ...
%                 'EdgeColor', 'none', ...
%                 'DisplayName', labels{color_indices(k)});
%             legend_flags(k) = 1;
%         else
%             patch([x1 x2 x2 x1], [-0.5 -0.5 1.5 1.5], ...
%                 colors(color_indices(k), :), ...
%                 'FaceAlpha', 0.15, ...
%                 'EdgeColor', 'none');
%         end
%     end
% end

% % Overlay coil diagnostic states for K1
% scatter(ans.Time(ans.K1_Coil_State == 0), repmat(1.3, sum(ans.K1_Coil_State == 0), 1), 20, 'bo', 'filled', 'DisplayName', 'K1: NORMAL (OPEN)');
% scatter(ans.Time(ans.K1_Coil_State == 1), repmat(1.3, sum(ans.K1_Coil_State == 1), 1), 20, 'g^', 'filled', 'DisplayName', 'K1: NORMAL (CLOSED)');
% scatter(ans.Time(ans.K1_Coil_State == 3), repmat(1.3, sum(ans.K1_Coil_State == 3), 1), 20, 'rs', 'filled', 'DisplayName', 'K1: SHORTED\_HIGH');
% scatter(ans.Time(ans.K1_Coil_State == 4), repmat(1.3, sum(ans.K1_Coil_State == 4), 1), 20, 'mo', 'filled', 'DisplayName', 'K1: SHORTED\_LOW');

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







%% K1 legends
hold off
ylabel('Contactor Output Signals');
xlabel('Time (s)');
xlim([0 1])
ylim([-0.5 1.5])
grid on;
ax = gca;
ax.FontSize = 18;
% legend('Main Contactor', 'K1: NORMAL (OPEN)', 'K1: NORMAL (CLOSED)', 'K1: SHORTED\_HIGH', 'K1: SHORTED\_LOW', 'Fontsize', 12,'Location','northwest')

legend('show', 'FontSize', 9, 'Location', 'northwest');


%% K2 legends
% hold off
% ylabel('Contactor Output Signals');
% xlabel('Time (s)');
% xlim([0 1])
% ylim([-0.5 1.5])
% grid on;
% ax = gca;
% ax.FontSize = 18;
% % legend('Precharge relays','K2 and K3: NORMAL (OPEN)', 'K2 and K3: NORMAL (OPEN)', 'K2 and K3: NORMAL (CLOSED)', 'K2 and K3: SHORTED\_LOW', 'Fontsize', 12,'Location','northwest')
% legend('Precharge relays','K2 and K3: NORMAL (OPEN)', 'K2 and K3: NORMAL (CLOSED)', 'K2 and K3: SHORTED\_HIGH', 'K2 and K3: SHORTED\_LOW', 'Fontsize', 12,'Location','northwest')


%% K4 legends
% hold off
% ylabel('Contactor Output Signals');
% xlabel('Time (s)');
% xlim([0 1])
% ylim([-0.5 1.5])
% grid on;
% ax = gca;
% ax.FontSize = 18;
% legend('Main Contactor', 'DCFC Contactor', 'K4: NORMAL (OPEN)', 'K4: NORMAL (CLOSED)', 'K4: SHORTED\_HIGH', 'K4: SHORTED\_LOW', 'Fontsize', 12,'Location','northwest')







% % Add vertical line that represents the initial time of the precharge
% % sequence
% xline((0.5), '--', 'HandleVisibility', 'off');
% labelStr = sprintf(' Start time of precharge sequence:\n t_{s} = %.1f s ', 0.5);
% text(0.5, -0.25, labelStr, ...
%     'HorizontalAlignment', 'right', ...
%     'VerticalAlignment', 'middle', ...
%     'Rotation', 0, ...
%     'FontSize', 8.5);
% 
% % Add vertical line that represents the elapsed time where 98% pack voltage is reached
% xline((0.5+0.001*Pre_charge_Time), '--', 'HandleVisibility', 'off');
% labelStr = sprintf(' Duration of precharge sequence: \n \\Deltat = %.0f ms', Pre_charge_Time);
% text((0.5+0.001*Pre_charge_Time), -0.25, labelStr, ...
%     'HorizontalAlignment', 'left', ...
%     'VerticalAlignment', 'middle', ...
%     'Rotation', 0, ...
%     'FontSize', 8.5);

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
% % Draw max precharge current line without built-in label
% yline(Max_Precharge_Current, '--', 'HandleVisibility', 'off');

% % Add max current text label on the left
% labelStr = sprintf('Maximum current during precharge \nsequence = %.1f A', Max_Precharge_Current);
% text(0.01, Max_Precharge_Current, labelStr, ...
%     'HorizontalAlignment', 'left', ...
%     'VerticalAlignment', 'top', ...
%     'FontSize', 8.5);
% 
% % Add vertical line that represents the initial time of the precharge
% % sequence
% xline((0.5), '--', 'HandleVisibility', 'off');
% labelStr = sprintf(' Start time of precharge sequence:\n t_{s} = %.1f s ', 0.5);
% text(0.5, Max_Precharge_Current/2, labelStr, ...
%     'HorizontalAlignment', 'right', ...
%     'VerticalAlignment', 'middle', ...
%     'Rotation', 0, ...
%     'FontSize', 8.5);
% 
% % Add vertical line that represents the elapsed time where 98% pack voltage is reached
% xline((0.5+0.001*Pre_charge_Time), '--', 'HandleVisibility', 'off');
% labelStr = sprintf(' Duration of precharge sequence: \n \\Deltat = %.0f ms', Pre_charge_Time);
% text((0.5+0.001*Pre_charge_Time), Max_Precharge_Current/2, labelStr, ...
%     'HorizontalAlignment', 'left', ...
%     'VerticalAlignment', 'middle', ...
%     'Rotation', 0, ...
%     'FontSize', 8.5);

%% Plot Precharge Voltage of the Battery Pack
figure(3)
plot(ans.time2, ans.BPCM_PreCharge_Pack_Voltage_Aux, 'LineWidth', 2);
hold on
plot(ans.time2, ans.BPCM_Bus_Voltage, 'LineWidth', 2);
hold off
ylabel('Measured Voltage (V)');
xlim([0 1])
ylim([0 500])
grid on
ax = gca;
ax.FontSize = 18;
legend('Battery Pack Voltage','DC Link Bus Voltage','Fontsize', 12,'Location','southwest')

% % Add vertical line that represents the initial time of the precharge
% % sequence
% xline((0.5), '--', 'HandleVisibility', 'off');
% labelStr = sprintf(' Start time of precharge sequence:\n t_{s} = %.1f s ', 0.5);
% text(0.5, ans.BPCM_Bus_Voltage(end)/2, labelStr, ...
%     'HorizontalAlignment', 'right', ...
%     'VerticalAlignment', 'middle', ...
%     'Rotation', 0, ...
%     'FontSize', 8.5);
% 
% % Add vertical line that represents the elapsed time where 98% pack voltage is reached
% xline((0.5+0.001*Pre_charge_Time), '--', 'HandleVisibility', 'off');
% labelStr = sprintf(' Duration of precharge sequence: \n \\Deltat = %.0f ms', Pre_charge_Time);
% text((0.5+0.001*Pre_charge_Time), ans.BPCM_Bus_Voltage(end)/2, labelStr, ...
%     'HorizontalAlignment', 'left', ...
%     'VerticalAlignment', 'middle', ...
%     'Rotation', 0, ...
%     'FontSize', 8.5);
% 
% 
% % Add horizontal line that represents 98% pack voltage threshold
% yline(Pre_charge_Voltage_Threshold, '--', 'HandleVisibility', 'off');
% labelStr = sprintf(' Precharge voltage threshold = %.1f V', Pre_charge_Voltage_Threshold);
% text(0.01, Pre_charge_Voltage_Threshold, labelStr, ...
%     'HorizontalAlignment', 'left', ...
%     'VerticalAlignment', 'top', ...
%     'FontSize', 8.5);


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

% % Add vertical line that represents the initial time of the precharge
% % sequence
% xline((0.5), '--', 'HandleVisibility', 'off');
% labelStr = sprintf(' Start time of precharge sequence:\n t_{s} = %.1f s ', 0.5);
% text(0.5, 2.5, labelStr, ...
%     'HorizontalAlignment', 'right', ...
%     'VerticalAlignment', 'middle', ...
%     'Rotation', 0, ...
%     'FontSize', 8.5);
% 
% % Add vertical line that represents the elapsed time where 98% pack voltage is reached
% xline((0.5+0.001*Pre_charge_Time), '--', 'HandleVisibility', 'off');
% labelStr = sprintf(' Duration of precharge sequence: \n \\Deltat = %.0f ms', Pre_charge_Time);
% text((0.5+0.001*Pre_charge_Time), 2.5, labelStr, ...
%     'HorizontalAlignment', 'left', ...
%     'VerticalAlignment', 'middle', ...
%     'Rotation', 0, ...
%     'FontSize', 8.5);

xlabel('Time (s)');



