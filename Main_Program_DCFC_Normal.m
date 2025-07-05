% McMaster Automotive Resource Centre (MARC)
% Electrical Engineer - Romulo Vieira, M.Sc and MBA - PhD Candidate,
clc; clear all; close all

sim('Simulink_Program_DCFC_Normal.slx')

Max_Precharge_Current        = max(ans.Ke_I_HighVoltageBusShortageCurrent); 
% Pre_charge_Time              = 1000*max(ans.Ke_t_HighVoltageBusActualPrechargeTime);
% Pre_charge_Voltage_Threshold = max(ans.Ke_V_HighVoltagePreChargeThreshold);

%% === FIGURE 1: Contactors/Relays with Background Colors ===
figure(1)
clf;

% Get Sail color palette
tmpFig = figure('Visible','off');
tmpAx = axes(tmpFig);
colororder(tmpAx, 'sail');
colors = colororder(tmpAx);
close(tmpFig);

% DCFC Charging starts from 0.5 s
t0 = 0.5;
t_end = 1.0;

% Background limits
ymin = -0.5;
ymax = 1.5;

% Refined background colors
color_idle     = [0.95 0.95 0.96];  % light gray
color_post     = [0.85 0.90 0.98];  % darker bluish-gray

% Tiled layout
t = tiledlayout(2,1);
t.TileSpacing = 'compact';
t.Padding = 'compact';

% Shared axis labels
ylabel(t, 'Contactors/Relays Signals', 'FontSize', 24);
xlabel(t, 'Time (s)', 'FontSize', 24);

% === Top Tile: K1 & K4 ===
nexttile
% Draw background
h_idle   = fill([0 t0 t0 0],       [ymin ymin ymax ymax], color_idle,     'EdgeColor', 'none'); hold on;
h_post   = fill([t0 t_end t_end t0],[ymin ymin ymax ymax], color_post,     'EdgeColor', 'none');

% Plot signals
h_K1 = plot(ans.Time, ans.K1, '-', 'Color', colors(1,:), 'LineWidth', 2);
h_K4 = plot(ans.Time, ans.K4, '--','Color', colors(3,:), 'LineWidth', 2);

% Axis settings
xlim([0 1]); ylim([ymin ymax]);
yticks([0 1]);
ax = gca; 
ax.FontSize = 24;
ax.Layer = 'top';  % Make grid visible above fills
grid on

% Legend
legend([h_K1, h_K4], ...
    {'Main Contactor', 'DCFC Contactor'}, ...
    'FontSize', 22, 'Location', 'northwest');

% Annotations
xline(t0, '--', 'HandleVisibility', 'off');

% === Bottom Tile: K2 & K3 ===
nexttile
% Draw background
h_idle   = fill([0 t0 t0 0],       [ymin ymin ymax ymax], color_idle,     'EdgeColor', 'none'); hold on;
h_post   = fill([t0 t_end t_end t0],[ymin ymin ymax ymax], color_post,     'EdgeColor', 'none');

% Plot signals
h_K2 = plot(ans.Time, ans.K2, '-',  'Color', colors(2,:), 'LineWidth', 2);
h_K3 = plot(ans.Time, ans.K3, '--', 'Color', colors(5,:), 'LineWidth', 2);

% Axis settings
xlim([0 1]); ylim([ymin ymax]);
yticks([0 1]);
ax = gca; 
ax.FontSize = 24;
ax.Layer = 'top';  % Make grid visible above fills
grid on

% Annotations
xline(t0, '--', 'HandleVisibility', 'off');

% Legend
legend([h_K2, h_K3], ...
    {'Precharge Relay (-)', 'Precharge Relay (+)'}, ...
    'FontSize', 22, 'Location', 'northwest');

% Export high-resolution figure
exportgraphics(gcf, 'Fig1.png', 'Resolution', 600);


%% === FIGURE 2: Precharge Current with Background Legends ===

colors = [
    0.9290 0.6940 0.1250;  % Current - yellowish
    0.8500 0.3250 0.0980;  % Pack voltage - reddish (not used here)
    0.0000 0.4470 0.7410;  % Charging voltage - blue (not used here)
];

figure(2)
clf;

% === Precharge timing ===
t0 = 0.5;
t_end = 1.0;

% === Background limits ===
ymin = 0;
ymax = 20;

% === Refined background colors ===
color_idle     = [0.95 0.95 0.96];  % light gray
color_post     = [0.85 0.90 0.98];  % darker bluish-gray

% === Draw background regions ===
h_idle   = fill([0 t0 t0 0],       [ymin ymin ymax ymax], color_idle,     'EdgeColor', 'none');
hold on
h_post   = fill([t0 t_end t_end t0],[ymin ymin ymax ymax], color_post,     'EdgeColor', 'none');

% === Plot current signal ===
h_current = plot(ans.tout, ans.HVBatPack_Current_Prim, ...
    'Color', colors(1,:), 'LineWidth', 2);

% % === Max current threshold ===
% yline(5, '--', 'HandleVisibility', 'off');
% text(0.01, 5, ...
%     sprintf('Maximum spike of current = 14695.6 A'), ...
%     'HorizontalAlignment', 'left', ...
%     'VerticalAlignment', 'top', ...
%     'FontSize', 22);

% === Axes and grid ===
xlabel('Time (s)', 'FontSize', 24);
ylabel('Current (A)', 'FontSize', 24);
xlim([0 1]);
ylim([ymin ymax]);
ax = gca;
ax.FontSize = 24;
ax.Layer = 'top';
grid on;

% === Annotation lines and labels ===
xline(t0, '--', 'HandleVisibility', 'off');

% === Legend (backgrounds + current) ===
legend([h_current], ...
    {'Battery Pack Current'}, ...
    'FontSize', 22, 'Location', 'best');

% === Export high-resolution figure ===
exportgraphics(gcf, 'Fig2.png', 'Resolution', 600);


%% === FIGURE 3: Precharge Voltages with Background Legends ===
figure(3)
clf;

% === Precharge timing ===
t0 = 0.5;                                  % Start of DCFC Charging
t_end = 1.0;

% === Background limits ===
ymin = 0;
ymax = 500;

% === Refined background colors ===
color_idle     = [0.95 0.95 0.96];  % light gray
color_post     = [0.85 0.90 0.98];  % darker bluish-gray (closed)

% === Draw background regions ===
h_idle   = fill([0 t0 t0 0],       [ymin ymin ymax ymax], color_idle,     'EdgeColor', 'none');
hold on
h_post   = fill([t0 t_end t_end t0],[ymin ymin ymax ymax], color_post,     'EdgeColor', 'none');

% === Plot voltage signals ===
h_pack = plot(ans.tout, ans.BPCM_PreCharge_Pack_Voltage_Aux, 'Color', colors(2,:), 'LineWidth', 2);
h_charging  = plot(ans.tout, ans.Charging_Station_Voltage, 'Color', colors(3,:), 'LineWidth', 2);

% === Threshold line and label ===
yline(ans.BPCM_PreCharge_Pack_Voltage_Aux, '--', 'HandleVisibility', 'off');
text(0.025, 450, ...
    sprintf('Battery Pack Voltage: \n 450 V'), ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top', ...
    'FontSize', 22);

% === Axis settings ===
xlabel('Time (s)', 'FontSize', 24);
ylabel('Voltage (V)', 'FontSize', 24);
xlim([0 1]);
ylim([ymin ymax]);
ax = gca;
ax.FontSize = 24;
ax.Layer = 'top';  % Grid above background
grid on;

% === Annotation lines and labels ===
xline(t0, '--', 'HandleVisibility', 'off');


% === Legend (backgrounds + voltages) ===
legend([h_pack, h_charging], ...
    {'Battery Pack Voltage','DCFC Voltage'}, ...
    'FontSize', 22, 'Location', 'southwest');

% === Export figure ===
exportgraphics(gcf, 'Fig3.png', 'Resolution', 600);


%% Plot Battery Contactor Control Status
figure(4)
clf;

% === Precharge timing ===
t0 = 0.5;                                  % Start of DCFC Charging
t_end = 1.0;

% === Background limits ===
ymin = 0;
ymax = 5;

% === Refined background colors ===
color_idle     = [0.95 0.95 0.96];  % light gray
color_post     = [0.85 0.90 0.98];  % slightly darker bluish-gray (closed)

% === Draw background regions ===
h_idle = fill([0 t0 t0 0],       [ymin ymin ymax ymax], color_idle,     'EdgeColor', 'none');
hold on
h_post = fill([t0 t_end t_end t0],[ymin ymin ymax ymax], color_post,     'EdgeColor', 'none');

% === Plot signal ===
h_signal = plot(ans.Time, ans.HVBatCntctrStat, 'k', 'LineWidth', 2);  % 'k' for black

% === Axis settings ===
ylabel('Battery Control Status');
xlabel('Time (s)');
xlim([0 1]);
ylim([ymin ymax]);

ax = gca;
ax.FontSize = 24;
ax.Layer = 'top';           % Grid above background
grid on;

% === Annotation lines and labels ===
xline(t0, '--', 'HandleVisibility', 'off');
text(t0 - 0.025, 2.5, sprintf('Start time of \n DCFC Charging: \n t_{s} = %.1f s ', t0), ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'middle', ...
    'FontSize', 22);

% === Add legend for background regions ===
legend([h_signal], ...
    {'Output Signal'}, ...
    'Location', 'northwest', ...
    'FontSize', 22);
exportgraphics(gcf, 'Fig4.png', 'Resolution', 600);

%% Create a small figure just for the legend
figure('Visible','on', 'Position', [100, 100, 600, 250]); % Bigger window

% Define colors (same as your main figures)
color_idle         = [0.95 0.95 0.96];  % light gray
color_post         = [0.85 0.90 0.98];  % darker bluish-gray

% Plot invisible dummy markers with larger size
h_idle   = plot(nan, nan, 's', 'MarkerSize', 16, 'MarkerFaceColor', color_idle, 'MarkerEdgeColor', 'k');
hold on
h_post   = plot(nan, nan, 's', 'MarkerSize', 16, 'MarkerFaceColor', color_post, 'MarkerEdgeColor', 'k');

% Create the legend with larger font
legend([h_idle, h_post], ...
    {'Open', 'DCFC Charging Closed'}, ...
    'FontSize', 22, 'Location', 'northoutside', 'Orientation', 'horizontal');

axis off
box off
