%% === Optimized DCFC Plot Script (1000 ms) ===
clear; clc; close all;

%% === 1. Load & Run Model (force 1000 ms) ===
model = 'Main_Simulink';
load_system(model);

simOut = sim(model, ...
    'StopTime','1', ...                    % 1000 ms = 1 s
    'ReturnWorkspaceOutputs','on');

% Logged dataset
data = simOut.logsout;

%% === 2. Save the exported dataset ===
save('Precharge_signals.mat', 'data');

%% === 3. Load & validate data ===
load precharge_signals.mat
assert(exist('data','var') && isa(data,'Simulink.SimulationData.Dataset'), ...
    '"data" must be a Simulink.SimulationData.Dataset.');

%% === 4. Helper: safely extract signals ===
names = getElementNames(data);
getSignal = @(n) struct( ...
    't', data.get(names{find(strcmpi(names,n),1)}).Values.Time, ...
    'y', data.get(names{find(strcmpi(names,n),1)}).Values.Data ...
);

%% === 5. Extract signals (sanitize names) ===
sigNames = {'K1Main','K2Pre-','K3Pre+','K4DCFC', ...
            'HVBatteryVoltage_BEV_DCLink', ...
            'HVBatteryVoltage_BEV_DCFC', ...
            'HVBatteryCurrent_BEV'};

signals = struct();
nameMap = struct();   % validField -> original signal name

for i = 1:numel(sigNames)
    origName  = sigNames{i};
    fieldName = matlab.lang.makeValidName(origName);  % sanitize (+/-)

    nameMap.(fieldName) = origName;

    try
        s = getSignal(origName);
        signals.(fieldName) = s.y;

        if ~isfield(signals,'time')
            signals.time = s.t;
        end
    catch
        signals.(fieldName) = [];
        warning('%s not found.', origName);
    end
end

t = signals.time;                 % seconds
assert(~isempty(t), 'No valid time vector found.');

%% === 6. Time handling ===
time_ms = t * 1000;               % milliseconds
idx = t <= 1;                     % first 1000 ms only

%% === 7. Colors (paper-safe) ===
colorK1 = [0.00, 0.45, 0.74];     % Blue
colorK2 = [1.00, 0.40, 0.20];     % Orange
colorK3 = [0.47, 0.67, 0.19];     % Green
colorK4 = [0.49, 0.18, 0.56];     % Purple
colorCurrent = [0, 0.45, 0.74]; % Blue 
colorDCVoltage = [0.47, 0.67, 0.19]; % Muted green
colorDCFCVoltage = [0.90, 0.20, 0.50];   % Pink

%% === 9. FIGURE: Contactor States ===
figure(1); clf; hold on; grid on;
set(gcf,'Color','w');
set(gca,'FontSize',18);

h = gobjects(4,1);  % legend handles

% --- K1 Main ---
if ~isempty(signals.K1Main)
    k1 = signals.K1Main;
    if size(k1,2)>1, k1 = mean(k1,2); end
    h(1) = plot(time_ms(idx), k1(idx), ...
        'LineWidth',1.5,'Color',colorK1);
end

% --- K2 Precharge (negative) ---
if isfield(signals,'K2Pre_') && ~isempty(signals.K2Pre_)
    k2 = signals.K2Pre_;
    if size(k2,2)>1, k2 = mean(k2,2); end
    h(2) = plot(time_ms(idx), k2(idx), ...
        'LineWidth',1.5,'Color',colorK2);
end

% --- K3 Precharge (positive) ---
if isfield(signals,'K3Pre_') && ~isempty(signals.K3Pre_)
    k3 = signals.K3Pre_;
    if size(k3,2)>1, k3 = mean(k3,2); end
    h(3) = plot(time_ms(idx), k3(idx), ...
        'LineWidth',1.5,'Color',colorK3,'LineStyle','--');
end

% --- K4 DCFC ---
if isfield(signals,'K4DCFC') && ~isempty(signals.K4DCFC)
    k4 = signals.K4DCFC;
    if size(k4,2)>1, k4 = mean(k4,2); end
    h(4) = plot(time_ms(idx), k4(idx), ...
        'LineWidth',1.5,'Color',colorK4);
end

%% === 10. Axes & legend ===
xlabel('Time (ms)','FontSize',22);
ylabel('Contactor States','FontSize',22);
xlim([0 1000]);
ylim([-0.2 1.2]);
yticks([0 1]); 

%% === 11. Export ===
exportgraphics(gcf,'Fig1.png','Resolution',600);

%% === FIGURE 2: Pack Current + Voltages ===
figure(2); clf; hold on; grid on;
set(gcf,'Color','w'); 
set(gca,'FontSize',18);

time_plot = time_ms(idx);  % consistent time vector

%% --- Left axis: Pack Current ---
yyaxis left
hCurrent = [];  % handle for legend
if ~isempty(signals.HVBatteryCurrent_BEV)
    y1 = signals.HVBatteryCurrent_BEV;
    if size(y1,2)>1, y1 = mean(y1,2); end
    
    % Main line (for legend)
    hCurrent = plot(time_plot, y1(idx), 'LineWidth',1.5, 'Color',colorCurrent, 'LineStyle','--');
    
end
ylabel('Battery Pack Current (A)','FontSize',22);
ylim([-100 20]);

%% --- Right axis: Voltages ---
yyaxis right
voltFields = {'HVBatteryVoltage_BEV_DCLink', 'HVBatteryVoltage_BEV_DCFC'};
voltColors = [colorDCVoltage; colorDCFCVoltage];
voltStyles = {'-','-'};
hVolt = gobjects(2,1);

for k = 1:2
    sigName = voltFields{k};
    fld = matlab.lang.makeValidName(sigName);
    if ~isempty(signals.(fld))
        y2 = signals.(fld);
        if size(y2,2)>1, y2 = mean(y2,2); end

        % Main line (for legend)
        hVolt(k) = plot(time_plot, y2(idx), 'LineWidth',1.5, ...
            'Color',voltColors(k,:), 'LineStyle',voltStyles{k});
    end
end

ylabel('Battery Pack Voltages (V)','FontSize',22);
ylim([0 400]);

xlabel('Time (ms)','FontSize',22);
xlim([0 1000]);
xticks(0:200:1000);

ax = gca;
yyaxis left;  ax.YColor = 'k';
yyaxis right; ax.YColor = 'k';
ax.XColor = 'k';

exportgraphics(gcf,'Fig2.png','Resolution',600);

%% === FIGURE 3: Legend only (all signals, lines only) ===
figure(3); clf;
set(gcf,'Color','w');

% Invisible axes
axes('Visible','off'); hold on;

% Dummy line objects 
hAll = gobjects(7,1);

hAll(1) = plot(nan,nan,'LineWidth',1.5,'Color',colorK1);                    % K1Main
hAll(2) = plot(nan,nan,'LineWidth',1.5,'Color',colorK2);                    % K2Pre-
hAll(3) = plot(nan,nan,'LineWidth',1.5,'Color',colorK3,'LineStyle','--');   % K3Pre+
hAll(4) = plot(nan,nan,'LineWidth',1.5,'Color',colorK4);                    % K4DCFC

hAll(5) = plot(nan,nan,'LineWidth',1.5,'Color',colorCurrent,'LineStyle','--'); % Pack Current
hAll(6) = plot(nan,nan,'LineWidth',1.5,'Color',colorDCVoltage);              % DC Link Voltage
hAll(7) = plot(nan,nan,'LineWidth',1.5,'Color',colorDCFCVoltage); % DCFC Voltage

labels = {
    'K1Main'
    'K2Pre-'
    'K3Pre+'
    'K4DCFC'
    'Pack Current'
    'DC Link Voltage'
    'DCFC Voltage'
};

valid = isgraphics(hAll,'line');
legend(hAll(valid), labels(valid), ...
       'FontSize',18, ...
       'Location','north', ...
       'Orientation','horizontal');

axis off
exportgraphics(gcf,'Fig3.png','Resolution',600);

%% ===== FIGURE 4: Current (left) + Voltages (right) (NO legend) =====
figure(4); clf
set(gcf,'Color','w');
ax = gca; hold(ax,'on'); grid(ax,'on');
ax.FontSize = 18;

% --- get MATLAB default color order (same used in contactor plot) ---
co = get(groot,'defaultAxesColorOrder');
c1 = co(1,:);  % line 1 color
c2 = co(2,:);  % line 2 color
c3 = co(3,:);  % line 3 color
c4 = co(4,:);  % line 4 color

% --- Left axis: Current ---
yyaxis left
ax.YColor = 'k';
hI = plot(Aux, out.HVBatteryCurrent_BEV, 'LineWidth', 1.8, 'Color', c1);
ylabel('Battery Current (A)')

% --- Right axis: Voltages ---
yyaxis right
ax.YColor = 'k';
hVpack = plot(Aux, out.HVBatteryVoltage_BEV,        'LineWidth', 1.8, 'Color', c2);
hVDCl  = plot(Aux, out.HVBatteryVoltage_BEV_DcLink, 'LineWidth', 1.8, 'Color', c3);
hVdcfc = plot(Aux, out.HVBatteryVoltage_BEV_DCFC,   'LineWidth', 1.8, 'Color', c4);
ylabel('Voltage (V)')

ax.XColor = 'k';
xlabel('Time (s)')

exportgraphics(gcf,'Fig_Current_Voltages.png','Resolution',600);


%% ===== FIGURE 5: Legend only (same colors/styles as Fig 4) =====
labels = {'Battery Current','Pack Voltage','DC Link Voltage','DCFC Voltage'};
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
