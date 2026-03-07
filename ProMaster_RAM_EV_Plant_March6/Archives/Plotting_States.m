% McMaster Automotive Resource Centre - MARC
% Plotting Contactor State

clc; clear; close all

load Variables.mat

Aux1             = 1:1:length(out.PrechargeStatus);
Aux              = Aux1./1000; % 1000Hz sampling Time


%% ----- Contactor status plot (stacked + default MATLAB legend) -----
figure(2); clf
set(gcf,'Color','w');
ax = gca; hold(ax,'on'); grid(ax,'on');
ax.FontSize = 18;

names = {'Main','Precharge Negative','Precharge Positive','DCFC'};
S = out.ContactorStatus(:,1:4);

laneAmp = 0.35;

h = gobjects(1,4);
for i = 1:4
    y = i + (S(:,i) - 0.5) * 2*laneAmp;
    h(i) = stairs(Aux, y, 'LineWidth', 1.8);
end

xlabel('Time (s)')
ylabel('Contactor States [0/1]')
ylim([0.5 4.5])
xlim([0 4])

% keep lanes but don't label them on y-axis
yticks(1:4)
yticklabels([])

% default legend box
% legend(h, names, 'Location','best');

exportgraphics(gcf,'Fig5.png','Resolution',600);

labels = {'K1 (Main)','K2 (Pre-)','K3 (Pre+)','K4 (DCFC)'};

%% ===== FIGURE 3: Legend only (exact styles from Fig 2 handles) =====
figure(3); clf
set(gcf,'Color','w');

axes('Visible','off'); hold on;

hLeg = gobjects(1,4);
for i = 1:4
    hLeg(i) = plot(nan,nan, ...
        'LineWidth',  h(i).LineWidth, ...
        'Color',      h(i).Color, ...
        'LineStyle',  h(i).LineStyle, ...
        'Marker',     h(i).Marker, ...
        'MarkerSize', h(i).MarkerSize);
end

legend(hLeg, labels, ...
    'FontSize',18, ...
    'Location','north', ...
    'Orientation','horizontal', ...
    'Box','on');

axis off
exportgraphics(gcf,'Fig5_legend.png','Resolution',600);

%% ===== FIGURE 4: Current (left) + Voltages (right) (NO legend, solid lines, contactor colors) =====
figure(4); clf
set(gcf,'Color','w');
ax = gca; hold(ax,'on'); grid(ax,'on');
ax.FontSize = 18;

% --- MATLAB default color order (same as contactor plot) ---
co = get(groot,'defaultAxesColorOrder');
c1 = co(1,:); c2 = co(2,:); c3 = co(3,:); c4 = co(4,:);

% --- Left axis: Current ---
yyaxis left
ax.YAxis(1).Color = 'k';
plot(Aux, out.HVBatteryCurrent_BEV, ...
    'LineWidth',1.8, 'Color',c1, 'LineStyle','-');
ylabel('Battery Current (A)')

% --- Right axis: Voltages ---
yyaxis right
ax.YAxis(2).Color = 'k';
plot(Aux, out.HVBatteryVoltage_BEV, ...
    'LineWidth',1.8, 'Color',c2, 'LineStyle','-');
plot(Aux, out.HVBatteryVoltage_BEV_DcLink, ...
    'LineWidth',1.8, 'Color',c3, 'LineStyle','-');
plot(Aux, out.HVBatteryVoltage_BEV_DCFC, ...
    'LineWidth',1.8, 'Color',c4, 'LineStyle','-');
ylabel('Battery Voltage (V)')

ax.XColor = 'k';
xlabel('Time (s)')
xlim([0 4])

exportgraphics(gcf,'Fig_Current_Voltages.png','Resolution',600);




%% ===== FIGURE 5: Legend only (same colors/styles as Fig 4) =====
labels = {'Pack Current','Pack Voltage','DC Link Voltage','DCFC Voltage'};
h = [hI hVpack hVDCl hVdcfc];

figure(5); clf
set(gcf,'Color','w');
% optional: wide strip for papers
% set(gcf,'Position',[100 100 1400 220]);

axes('Visible','off'); hold on;

hLeg = gobjects(1,numel(h));
for i = 1:numel(h)
    hLeg(i) = plot(nan,nan, ...
        'LineWidth',  h(i).LineWidth, ...
        'Color',      h(i).Color, ...
        'LineStyle',  h(i).LineStyle, ...
        'Marker',     h(i).Marker, ...
        'MarkerSize', h(i).MarkerSize);
end

legend(hLeg, labels, ...
    'FontSize',18, ...
    'Location','north', ...
    'Orientation','horizontal', ...
    'Box','on');

axis off
exportgraphics(gcf,'Fig_Current_Voltages_legend.png','Resolution',600);

%% ===== FIGURE 4: Current (left) + Voltages (right) + ZOOM inset (WEST side) =====
figure(4); clf
set(gcf,'Color','w');

% --- main axes (ax1) ---
ax1 = axes('Position',[0.13 0.17 0.7 0.75]);  % [x y w h] normalized
hold(ax1,'on'); grid(ax1,'on');
ax1.FontSize = 18;
ax1.XColor = 'k';

% --- NEW colors (different from MATLAB default used in contactor plot) ---
c1 = [0.00 0.60 0.50];  % teal  (Current)
c2 = [0.80 0.20 0.20];  % red   (Pack V)
c3 = [0.55 0.45 0.10];  % olive (DC link V)
c4 = [0.90 0.10 0.85];  % magenta (DCFC V)


% --- main plot with yyaxis ---
yyaxis(ax1,'left')
ax1.YColor = 'k';
plot(ax1, Aux, out.HVBatteryCurrent_BEV, 'LineWidth',1.8, 'Color',c1);
ylabel(ax1,'Battery Current (A)')

yyaxis(ax1,'right')
ax1.YColor = 'k';
plot(ax1, Aux, out.HVBatteryVoltage_BEV,        'LineWidth',1.8, 'Color',c2);
plot(ax1, Aux, out.HVBatteryVoltage_BEV_DcLink, 'LineWidth',1.8, 'Color',c3);
plot(ax1, Aux, out.HVBatteryVoltage_BEV_DCFC,   'LineWidth',3, 'Color',c4);
ylabel(ax1,'Battery Voltage (V)')

xlabel(ax1,'Time (s)')
xlim(ax1,[0 4])

% --- zoom window definition ---
x1 = 3.05;
x2 = 3.2;
idx = (Aux >= x1) & (Aux <= x2);

% ===== inset axes (ax2) - WEST side =====
ax2 = axes('Position',[0.20 0.45 0.28 0.28]);
hold(ax2,'on'); grid(ax2,'on');
ax2.FontSize = 13;
ax2.XColor = 'k';
box(ax2,'on');

% inset: current (left)
yyaxis(ax2,'left')
ax2.YColor = 'k';
stairs(ax2, Aux(idx), out.HVBatteryCurrent_BEV(idx), 'LineWidth',1.8, 'Color',c1);
ylim(ax2,[0 15]);

% inset: voltages (right)
yyaxis(ax2,'right')
ax2.YColor = 'k';
plot(ax2, Aux(idx), out.HVBatteryVoltage_BEV(idx),        'LineWidth',1.6, 'Color',c2);
plot(ax2, Aux(idx), out.HVBatteryVoltage_BEV_DcLink(idx), 'LineWidth',1.6, 'Color',c3);
plot(ax2, Aux(idx), out.HVBatteryVoltage_BEV_DCFC(idx),   'LineWidth',1.6, 'Color',c4);
xlim(ax2,[x1 x2]);

exportgraphics(gcf,'Fig_Current_Voltages_zoom.png','Resolution',600);
