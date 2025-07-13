% McMaster Automotive Resource Centre (MARC)
% Electrical Engineer - Romulo Vieira, M.Sc and MBA - PhD Candidate,
clc; clear all; close all

sim('Simulink_Program.slx')

Max_Precharge_Current        = max(ans.Ke_I_HighVoltageBusShortageCurrent); 
Pre_charge_Time              = 1000*max(ans.Ke_t_HighVoltageBusActualPrechargeTime);
Pre_charge_Voltage_Threshold = max(ans.Ke_V_HighVoltagePreChargeThreshold);

%% === FIGURE 1: Contactors/Relays with Background Colors ===
figure(1)
clf;

% Get Sail color palette
tmpFig = figure('Visible','off');
tmpAx = axes(tmpFig);
colororder(tmpAx, 'sail');
colors = colororder(tmpAx);
close(tmpFig);

% Precharge timing
t0 = 0.1;
t1 = t0 + 0.001 * Pre_charge_Time;
t_end = 1.0;

% Background limits
ymin = -0.5;
ymax = 1.5;

% Refined background colors
color_idle     = [0.95 0.95 0.96];  % light gray
color_charging = [0.93 0.96 1.00];  % soft blue
color_post     = [0.85 0.90 0.98];  % darker bluish-gray

% Tiled layout
t = tiledlayout(2,1);
t.TileSpacing = 'compact';
t.Padding = 'compact';

% Shared axis labels
ylabel(t, 'Contactors/Relays Signals', 'FontSize', 22);
xlabel(t, 'Time (s)', 'FontSize', 22);

% === Top Tile: K1 & K4 ===
nexttile
% Draw background
h_idle   = fill([0 t0 t0 0],       [ymin ymin ymax ymax], color_idle,     'EdgeColor', 'none'); hold on;
h_charge = fill([t0 t1 t1 t0],     [ymin ymin ymax ymax], color_charging, 'EdgeColor', 'none');
h_post   = fill([t1 t_end t_end t1],[ymin ymin ymax ymax], color_post,     'EdgeColor', 'none');

% Plot signals
h_K1 = plot(ans.Time, ans.K1, '-', 'Color', colors(1,:), 'LineWidth', 2);
h_K4 = plot(ans.Time, ans.K4, '--','Color', colors(3,:), 'LineWidth', 2);

% Axis settings
xlim([0 1]); ylim([ymin ymax]);
yticks([0 1]);
ax = gca; 
ax.FontSize = 18;
ax.Layer = 'top';  % Make grid visible above fills
grid on

% Legend
legend([h_K1, h_K4], ...
    {'Main Contactor', 'DCFC Contactor'}, ...
    'FontSize', 18, 'Location', 'northeast');


% === Bottom Tile: K2 & K3 ===
nexttile
% Draw background
h_idle   = fill([0 t0 t0 0],       [ymin ymin ymax ymax], color_idle,     'EdgeColor', 'none'); hold on;
h_charge = fill([t0 t1 t1 t0],     [ymin ymin ymax ymax], color_charging, 'EdgeColor', 'none');
h_post   = fill([t1 t_end t_end t1],[ymin ymin ymax ymax], color_post,     'EdgeColor', 'none');

% Plot signals
h_K2 = plot(ans.Time, ans.K2, '-',  'Color', colors(2,:), 'LineWidth', 2);
h_K3 = plot(ans.Time, ans.K3, '--', 'Color', colors(5,:), 'LineWidth', 2);

% Axis settings
xlim([0 1]); ylim([ymin ymax]);
yticks([0 1]);
ax = gca; 
ax.FontSize = 18;
ax.Layer = 'top';  % Make grid visible above fills
grid on

% Annotations
xline(t0, '--', 'HandleVisibility', 'off');
xline(t1, '--', 'HandleVisibility', 'off');

% Legend
legend([h_K2, h_K3], ...
    {'Precharge Relay (-)', 'Precharge Relay (+)'}, ...
    'FontSize', 18, 'Location', 'best');

% Export high-resolution figure
exportgraphics(gcf, 'Fig1.png', 'Resolution', 600);


%% === FIGURE 2: Precharge Current with Background Legends ===

colors = [
    0.9290 0.6940 0.1250;  % Current - yellowish
    0.8500 0.3250 0.0980;  % Pack voltage - reddish (not used here)
    0.0000 0.4470 0.7410;  % Bus voltage - blue (not used here)
];

figure(2)
clf;

% === Background limits ===
ymin = 0;
ymax = 20;

% === Refined background colors ===
color_idle     = [0.95 0.95 0.96];  % light gray
color_charging = [0.93 0.96 1.00];  % soft blue
color_post     = [0.85 0.90 0.98];  % darker bluish-gray

% === Draw background regions ===
h_idle   = fill([0 t0 t0 0],       [ymin ymin ymax ymax], color_idle,     'EdgeColor', 'none');
hold on
h_charge = fill([t0 t1 t1 t0],     [ymin ymin ymax ymax], color_charging, 'EdgeColor', 'none');
h_post   = fill([t1 t_end t_end t1],[ymin ymin ymax ymax], color_post,     'EdgeColor', 'none');

% === Plot current signal ===
h_current = plot(ans.tout, ans.HVBatPack_Current_Prim, ...
    'Color', colors(1,:), 'LineWidth', 2);

% === Max current threshold ===
yline(Max_Precharge_Current, '--', 'HandleVisibility', 'off');
text(t1+0.025, Max_Precharge_Current, ...
    sprintf('Maximum current on precharge sequence: %.0f A', Max_Precharge_Current), ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top', ...
    'FontSize', 10);

% === Axes and grid ===
xlim([0 1]);
ylim([ymin ymax]);
ax = gca;
ax.FontSize = 18;
ax.Layer = 'top';
xlabel('Time (s)', 'FontSize', 22);
ylabel('Measured Current (A)', 'FontSize', 22);
grid on;

% === Annotation lines and labels ===
xline(t0, '--', 'HandleVisibility', 'off');

xline(t1, '--', 'HandleVisibility', 'off');

% === Legend (backgrounds + current) ===
legend([h_current], ...
    {'Battery Pack Current'}, ...
    'FontSize', 18, 'Location', 'southeast');

% === Export high-resolution figure ===
exportgraphics(gcf, 'Fig2.png', 'Resolution', 600);


%% === FIGURE 3: Precharge Voltages with Background Legends ===
figure(3)
clf;

% === Background limits ===
ymin = 0;
ymax = 500;

% === Refined background colors ===
color_idle     = [0.95 0.95 0.96];  % light gray
color_charging = [0.93 0.96 1.00];  % soft blue
color_post     = [0.85 0.90 0.98];  % darker bluish-gray (closed)

% === Draw background regions ===
h_idle   = fill([0 t0 t0 0],       [ymin ymin ymax ymax], color_idle,     'EdgeColor', 'none');
hold on
h_charge = fill([t0 t1 t1 t0],     [ymin ymin ymax ymax], color_charging, 'EdgeColor', 'none');
h_post   = fill([t1 t_end t_end t1],[ymin ymin ymax ymax], color_post,     'EdgeColor', 'none');

% === Plot voltage signals ===
h_pack = plot(ans.tout, ans.BPCM_PreCharge_Pack_Voltage_Aux, 'Color', colors(2,:), 'LineWidth', 2);
h_bus  = plot(ans.tout, ans.BPCM_Bus_Voltage, 'Color', colors(3,:), 'LineWidth', 2);

% === Threshold line and label ===
yline(Pre_charge_Voltage_Threshold, '--', 'HandleVisibility', 'off');
text(t1+0.025, Pre_charge_Voltage_Threshold, ...
    sprintf('Precharge voltage threshold = %.1f V', Pre_charge_Voltage_Threshold), ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top', ...
    'FontSize', 10);

% === Axis settings ===
xlabel('Time (s)', 'FontSize', 18);
ylabel('Measured Voltage (V)', 'FontSize', 18);
xlim([0 1]);
ylim([ymin ymax]);
ax = gca;
ax.FontSize = 18;
ax.Layer = 'top';  % Grid above background
grid on;

% === Annotation lines and labels ===
xline(t0, '--', 'HandleVisibility', 'off');

xline(t1, '--', 'HandleVisibility', 'off');

% === Legend (backgrounds + voltages) ===
legend([h_pack, h_bus], ...
    {'Battery Pack Voltage','DC Link Bus Voltage'}, ...
    'FontSize', 18, 'Location', 'southeast');

% === Export figure ===
exportgraphics(gcf, 'Fig3.png', 'Resolution', 600);


%% Plot Battery Contactor Control Status
figure(4)
clf;

% === Background limits ===
ymin = 0;
ymax = 5;

% === Refined background colors ===
color_idle     = [0.95 0.95 0.96];  % light gray
color_charging = [0.93 0.96 1.00];  % soft blue
color_post     = [0.85 0.90 0.98];  % slightly darker bluish-gray (closed)

% === Draw background regions ===
h_idle = fill([0 t0 t0 0],       [ymin ymin ymax ymax], color_idle,     'EdgeColor', 'none');
hold on
h_charge = fill([t0 t1 t1 t0],   [ymin ymin ymax ymax], color_charging, 'EdgeColor', 'none');
h_post = fill([t1 t_end t_end t1],[ymin ymin ymax ymax], color_post,     'EdgeColor', 'none');

% === Plot signal ===
h_signal = plot(ans.Time, ans.HVBatCntctrStat, 'k', 'LineWidth', 2);  % 'k' for black

% === Axis settings ===
ylabel('Battery Control Status');
xlabel('Time (s)');
xlim([0 1]);
ylim([ymin ymax]);

ax = gca;
ax.FontSize = 18;
ax.Layer = 'top';           % Grid above background
grid on;

% === Annotation lines and labels ===
xline(t0, '--', 'HandleVisibility', 'off');
text(t0, 3.5, sprintf(' Start time of precharge sequence: t_{s} = %.0f ms ', 1000*t0), ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'middle', ...
    'FontSize', 10);

xline(t1, '--', 'HandleVisibility', 'off');
text(t1+0.025, 2.5, sprintf('End time of precharge sequence: t_e = %.0f ms', 1000*t0 + Pre_charge_Time), ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'middle', ...
    'FontSize', 10);

% === Add legend for background regions ===
legend([h_signal], ...
    {'Output Signal'}, ...
    'Location', 'southeast', ...
    'FontSize', 18);
exportgraphics(gcf, 'Fig4.png', 'Resolution', 600);

%% === LEGEND ONLY FIGURE ===
figure('Visible','on', 'Position', [100, 100, 600, 100]);

h_idle   = plot(nan, nan, 's', 'MarkerSize', 16, 'MarkerFaceColor', color_idle,         'MarkerEdgeColor', 'k'); hold on
h_charge = plot(nan, nan, 's', 'MarkerSize', 16, 'MarkerFaceColor', color_charging,     'MarkerEdgeColor', 'k');
h_post   = plot(nan, nan, 's', 'MarkerSize', 16, 'MarkerFaceColor', color_post,         'MarkerEdgeColor', 'k');

legend([h_idle, h_charge, h_post], ...
    {'Open', 'Precharging', 'Closed'}, ...
    'FontSize', 22, 'Location', 'northoutside', 'Orientation', 'horizontal');

axis off; box off;
exportgraphics(gcf, 'Fig5.png', 'Resolution', 600);
