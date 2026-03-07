%% =============================
%  Combined Simulink + Vehicle Log Comparison
% =============================

clc; clear;

%% ---- User Settings ----
logFile = 'Sample_Level2.mat';  % Vehicle log
modelName = 'AC_PlugInCharging'; % Simulink model
signals = { ...
    'HVBatChargeStat', ...
    'HVBat_DC_CntctrStat', ...
    'HVBatMaxCellVltAlld', ...
    'HVBatMaxPkVltAllwd' ...
};
tolerance = 0.01;   % signal tolerance
gracePeriod = 2;    % grace period in seconds

%% ---- Load Vehicle Log ----
load(logFile);        % loads 'Data'
Data_vehicle = Data;  % rename for clarity

%% ---- Run Simulink Model ----
open_system(modelName);
simOut = sim(modelName); % run and store outputs

%% ---- Convert Simulink outputs to same structure format as vehicle log ----
Data_model = struct();
for i = 1:length(signals)
    sigName = signals{i};
    y = simOut.get(sigName);
    t = simOut.tout(:);
    Data_model.(sigName).time = t;
    Data_model.(sigName).val  = y(:); % ensure column
end

%% ---- Compare Signals with Grace Period ----
compare_signals_function(Data_model, Data_vehicle, signals, tolerance, gracePeriod);

%% =============================
%  Function: compare_signals
% =============================
function compare_signals_function(Data1, Data2, signal_list, tol, grace)

for k = 1:length(signal_list)

    name = signal_list{k};

    disp("====================================")
    disp("Comparing: " + name)
    disp("====================================")

    sig1 = Data1.(name);
    sig2 = Data2.(name);

    % Ensure column vectors
    t = sig1.time(:);

    y1 = sig1.val;
    y2 = sig2.val;

    % If signals have multiple columns, use first column
    if size(y1,2) > 1, y1 = y1(:,1); end
    if size(y2,2) > 1, y2 = y2(:,1); end

    y1 = y1(:);
    y2 = y2(:);

    % Match lengths
    n = min(length(y1), length(y2));
    y1 = y1(1:n);
    y2 = y2(1:n);
    t = t(1:n);

    %% ---- Error calculation ----
    err = abs(y1 - y2);
    mismatch = err > tol;

    match_percent = 100*(1 - sum(mismatch)/length(mismatch));
    fprintf("Match: %.2f %%\n", match_percent)

    %% ---- Plot ----
    figure('Color','white')
    hold on
    plot(t,y1,'b','LineWidth',1.5)
    plot(t,y2,'g','LineWidth',1.5)
    yl = ylim;

    %% ---- Detect mismatch regions ----
    d = diff([0; mismatch; 0]);
    start_idx = find(d==1);
    end_idx = find(d==-1)-1;

    true_regions = 0;

    for i = 1:length(start_idx)
        t1 = t(start_idx(i));
        t2 = t(end_idx(i));
        duration = t2 - t1;

        %% ---- Grace period (yellow) ----
        g_end = min(t1 + grace, t2);
        patch([t1 g_end g_end t1],...
              [yl(1) yl(1) yl(2) yl(2)],...
              [1 1 0],'FaceAlpha',0.3,'EdgeColor','none');

        %% ---- True violation (red) ----
        if duration > grace
            v_start = t1 + grace;
            v_end = t2;
            patch([v_start v_end v_end v_start],...
                  [yl(1) yl(1) yl(2) yl(2)],...
                  [1 0 0],'FaceAlpha',0.4,'EdgeColor','none');
            fprintf("Mismatch from %.3f s to %.3f s\n", v_start, v_end)
            true_regions = true_regions + 1;
        end
    end

    fprintf("Mismatch regions: %d\n", true_regions)

    legend("Model","Vehicle Log")
    title(name)
    xlabel("Time (s)")
    ylabel("Value")
    grid on
    hold off

end

end