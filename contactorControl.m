%% Added by Tridib: PlugInChargingCmd, HVBatPack_DCFCVoltage
% ================= START
function [K1, K2, K3, K4, HVBatCntctrStat, Ke_t_HighVoltageBusActualPrechargeTime, ...
    Ke_I_HighVoltageBusShortageCurrent, Ke_V_HighVoltagePreChargeThreshold, HVBatPrechgInbt] = ...
    contactorControl(HVBatPack_Current_Prim, HVBatPack_EDMVoltage, ...
    HVBatPack_Voltage, MainHVBatCntctrCmd, HVBatPrechgInbt, HVBatInitHVIL, BatteryRdy, Rprecharge, PlugInChargingCmd, HVBatPack_DCFCVoltage, Fault_K1_Shorted_High_Condition, Fault_K4_Shorted_High_Condition)
% ================== END

%-----------------------------------------------------------
% McMaster Automotive Resource Centre (MARC)
% Electrical Engineer: Romulo Vieira, M.Sc and MBA - PhD Candidate
%-----------------------------------------------------------
% Purpose: Manage precharge relay and contactor sequence with retry + inhibit logic
%-----------------------------------------------------------

% HVBatCntctrStat Mapping:
% HVBatCntctrStat Mapping:
% 0 – Idle/Waiting
% 1 – Precharge Active
% 2 – Precharge Complete (Main contactors closed)
% 3 - DCFC Charging
% 4 – Precharge Failed
% 5 – Inhibit State (cooldown after failure)
% 6 – Contactor Control Shorted (high or low)
% 7 - SNA (Signal Not Available)

% --- Constants ---
Unset_VbusTargetHitIdx             = -1;   % Flag indicating Vbus threshold not yet hit
Min_Samples                        = 0;    % Minimum number of samples where relays and contactor are both active

% Internal Configuration Parameters
Ke_t_PrechargeFailCoolTime             = 3000;   % Cooldown time after one single failed attempt [ms]
Ke_t_ExtraPrechargeFailCoolPenaltyTime = 2000;   % Additional cooldown after two multiple failures [ms]
Ke_t_PrechargeFailMaxPenalty           = 10000;  % Maximum time threshold before enabling precharge inhibit state
Ke_t_BPCM_Precharge_Fail_Penalty_Time  = 15000;  % Hard inhibit time if failures persist [ms]
Ke_I_HighVoltageBusShortageCurrentMin  = 10.8;   % Minimum expected precharge current [A]
Ke_V_HighVoltagePreChargeThreshold     = 0.993 * HVBatPack_Voltage;  % Target voltage threshold
Ke_t_HighVoltageBusPrechargeTime       = 100;    % Maximum allowable time for precharging [ms]

% --- Persistent Variables ---
persistent I_buffer idx HVBatCntctrStat_Aux VbusTargetHitIdx ...
    t_counter last_PrechargeAllw Prchrgpnltytimer PrechargeFailCount

if isempty(I_buffer)
    I_buffer               = zeros(Ke_t_HighVoltageBusPrechargeTime,1);
    idx                    = 1;
    HVBatCntctrStat_Aux    = 0;
    VbusTargetHitIdx       = Unset_VbusTargetHitIdx;
    t_counter              = 0;
    last_PrechargeAllw     = 0;
    Prchrgpnltytimer       = 0;
    PrechargeFailCount     = 0; % Represented by k_fail in the flowchart
end

% --- Default Outputs ---
K1 = 0; K2 = 0; K3 = 0; K4 = 0;
HVBatCntctrStat = HVBatCntctrStat_Aux;
Ke_t_HighVoltageBusActualPrechargeTime = 0;
Ke_I_HighVoltageBusShortageCurrent = 0;

% --- Immediate cooldown/inhibit override ---
if Prchrgpnltytimer > 0 && HVBatCntctrStat_Aux ~= 5
    HVBatCntctrStat_Aux = 5;
end

% --- State Machine ---
switch HVBatCntctrStat_Aux
    case 0 % OPEN STATE
        % Set the Battery Contactor States
        K1 = 0; K2 = 0; K3 = 0; K4 = 0;
        % Check Initial conditions
        if MainHVBatCntctrCmd == 1 && HVBatPrechgInbt == 0 && HVBatInitHVIL == 1 && BatteryRdy == 1
            I_buffer(:) = 0;
            idx = 1;
            VbusTargetHitIdx = Unset_VbusTargetHitIdx;
            t_counter = 0;
            HVBatCntctrStat_Aux = 1;
        end

    case 1  % PRECHARGING STATE
        % Abort if initial conditions are no longer valid
        if MainHVBatCntctrCmd ~= 1 || HVBatPrechgInbt ~= 0 || HVBatInitHVIL ~= 1 || BatteryRdy ~= 1
            HVBatCntctrStat_Aux = 0;
            return;
        end

        % Set precharge relays ON
        K1 = 0; K2 = 1; K3 = 1; K4 = 0;

        % Record current
        if t_counter == 0
            I_buffer(idx) = HVBatPack_Voltage / Rprecharge;
        else
            I_buffer(idx) = HVBatPack_Current_Prim;
        end
        Ke_I_HighVoltageBusShortageCurrent = max(I_buffer);

        % Voltage target check
        if VbusTargetHitIdx == Unset_VbusTargetHitIdx && HVBatPack_EDMVoltage >= Ke_V_HighVoltagePreChargeThreshold
            VbusTargetHitIdx = t_counter + 1;
        end

        % Time since start or since target hit
        if VbusTargetHitIdx ~= Unset_VbusTargetHitIdx
            delta_samples = VbusTargetHitIdx;
        else
            delta_samples = t_counter;
        end

        % SUCCESS - PRECHARGE CONDITIONS ARE MET
        if t_counter < Ke_t_HighVoltageBusPrechargeTime && ... 
                VbusTargetHitIdx ~= Unset_VbusTargetHitIdx && delta_samples < Ke_t_HighVoltageBusPrechargeTime && Ke_I_HighVoltageBusShortageCurrent >= Ke_I_HighVoltageBusShortageCurrentMin
            
            % Set the next Battery Contactor Status
            HVBatCntctrStat_Aux = 2;
            % Set the Battery Contactor States
            K1 = 1; K2 = 0; K3 = 0; K4 = 0;

            PrechargeFailCount = 0;
            Prchrgpnltytimer = 0;

        % FAILURE - PRECHARGE CONDITIONS ARE NOT MET
        elseif t_counter == Ke_t_HighVoltageBusPrechargeTime && ...
               (VbusTargetHitIdx == Unset_VbusTargetHitIdx || delta_samples == Ke_t_HighVoltageBusPrechargeTime || Ke_I_HighVoltageBusShortageCurrent < Ke_I_HighVoltageBusShortageCurrentMin)

            % Set the Battery Contactor States
            K1 = 0; K2 = 0; K3 = 0; K4 = 0;
           % Set the Battery Contactor Status
            HVBatCntctrStat_Aux = 3;

            % Update the total cooling time before re-attempt
            PrechargeFailCount = PrechargeFailCount + 1;
            Prchrgpnltytimer = Prchrgpnltytimer + Ke_t_PrechargeFailCoolTime;

            if PrechargeFailCount >= 2
                Prchrgpnltytimer = Prchrgpnltytimer + Ke_t_ExtraPrechargeFailCoolPenaltyTime;
            end

            % Check PRECHARGE INHIBIT CONDITIONS:
            if Prchrgpnltytimer > Ke_t_PrechargeFailMaxPenalty % Include the here || (HVBatPrechargeTemp > 60) 
                % Set the next Battery Contactor Status
                HVBatCntctrStat_Aux = 4;
                HVBatPrechgInbt = 1;
                Prchrgpnltytimer = Ke_t_BPCM_Precharge_Fail_Penalty_Time;
            end

        end

        % Update counters
        t_counter = t_counter + 1;
        idx = idx + 1;
        if idx > Ke_t_HighVoltageBusPrechargeTime, idx = 1; end

    case 2  % PRECHARGE COMPLETE OR CLOSED
        % Set the Battery Contactor States
        K1 = 1; K2 = 0; K3 = 0; K4 = 0;

        %% Added by Tridib
        if Fault_K1_Shorted_High_Condition == 1
            HVBatCntctrStat_Aux = 6; % K1 Shorted High
        end

        % If statement to detect DCFC charging
        if PlugInChargingCmd == 1
            HVBatCntctrStat_Aux = 3; % DCFC CHARGING
        end

% ============= END

    %% Added by Tridib: New DCFC case
    case 3 % DCFC CHARGING
        % Set the Battery Contactor States
        K1 = 1; K2 = 0; K3 = 0; K4 = 1;

        if Fault_K4_Shorted_High_Condition == 1
            HVBatCntctrStat_Aux = 7; % K4 Shorted High
        end

        if MainHVBatCntctrCmd == 0 
            K1 = 0;
        end

        if PlugInChargingCmd == 0 && abs(HVBatPack_DCFCVoltage) < 270
            if MainHVBatCntctrCmd == 0
                HVBatCntctrStat_Aux = 0; % switch to OPEN
            else
                HVBatCntctrStat_Aux = 2; % switch to CLOSED
            end
        end

% ====================END

    case 4 % FAULT: PRECHARGE FAILED STATE
        % Set the Battery Contactor States
        K1 = 0; K2 = 0; K3 = 0; K4 = 0;
        if Prchrgpnltytimer > 0
            Prchrgpnltytimer = Prchrgpnltytimer - 1;
        else
            HVBatCntctrStat_Aux = 0;
        end

    case 5  % FAULT: PRECHARGE INHIBIT STATE
        % Set the Battery Contactor States
        K1 = 0; K2 = 0; K3 = 0; K4 = 0;

        if Prchrgpnltytimer > 0
            Prchrgpnltytimer = Prchrgpnltytimer - 1;
        else
            % Cooldown finished → check if PRECHARGE INHIBIT conditions still exist
            if (Prchrgpnltytimer > Ke_t_PrechargeFailMaxPenalty) % Include the here || (HVBatPrechargeTemp > 60)
                % Inhibit condition persists → apply long penalty
                Prchrgpnltytimer = Ke_t_BPCM_Precharge_Fail_Penalty_Time;
                HVBatCntctrStat_Aux = 4;
                HVBatPrechgInbt = 1;
            else
                % PRECHARGE INHIBIT conditions cleared → ready for retry
                Prchrgpnltytimer = 0;
                HVBatPrechgInbt = 0;
                HVBatCntctrStat_Aux = 0;
            end
        end

    
    case 6 % FAULT: Main Contactor Shorted High
        % Set the Battery Contactor States
        K1 = 1; K2 = 0; K3 = 0; K4 = 0;
        HVBatCntctrStat_Aux = 6;

    case 7 % FAULT: DCFC Contactor Shorted High
        % Set the Battery Contactor States
        K1 = 0; K2 = 0; K3 = 0; K4 = 1;
        HVBatCntctrStat_Aux = 7;    

    otherwise
        K1 = 0; K2 = 0; K3 = 0; K4 = 0;
        HVBatCntctrStat_Aux = 0;
end

% --- Final Outputs ---
HVBatCntctrStat = HVBatCntctrStat_Aux;
Ke_t_HighVoltageBusActualPrechargeTime = max(0, VbusTargetHitIdx + ...
    Min_Samples * (VbusTargetHitIdx ~= Unset_VbusTargetHitIdx));
last_PrechargeAllw = BatteryRdy;

end
