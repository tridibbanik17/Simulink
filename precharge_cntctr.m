% Extract each signal from the output structure
ThermalProtectionEnabled = out.BPCM_Thermal_Protection_Enabled;
DTC = out.DTC_Precharge;
capacitor = out.EDM_Capacitor_Bank;
HVBatCntctrStat = out.HVBatCntctrStat;
HVBatInitHVIL = out.HVBatInitHVIL;
Current = out.HVBatPack_Current_Prim;
LinkVolt = out.HVBatPack_LinkVoltage;
MaxVolt = out.HVBatPack_Voltage_CMU;
HVBatPrechgInbt = out.HVBatPrechgInbt;
HVILFault = out.HVIL_Fault;
K1 = out.K1;
K2 = out.K2;
K3 = out.K3;
K4 = out.K4;
KeIdx = out.Ke_idx;
MaxAllowedTime = out.Ke_t_HighVoltageBusPrechargeAllowedTime;
MainHVBatCntctrCmd = out.MainHVBatCntctrCmd;
MaxI = out.Max_I;
PrechargeAllw = out.PrechargeAllw;
OvercurrentFault = out.PrechargeOvercurrentFault;
Resistor = out.Precharge_Resistor;
RetryOccurred = out.RetryInPrechargeOccurred;
SamplesPrechargeFunction = out.Samples_Precharge_function;
SimTime = out.SimulationTime;
StageOut = out.StageOut;

% Plot all signals
figure;
hold on;
plot(ThermalProtectionEnabled.Time, ThermalProtectionEnabled.Data, 'DisplayName', 'ThermalProtectionEnabled');
plot(DTC.Time, DTC.Data, 'DisplayName', 'DTC');
plot(capacitor.Time, capacitor.Data, 'DisplayName', 'capacitor');
plot(HVBatCntctrStat.Time, HVBatCntctrStat.Data, 'DisplayName', 'HVBatCntctrStat');
plot(HVBatInitHVIL.Time, HVBatInitHVIL.Data, 'DisplayName', 'HVBatInitHVIL');
plot(1:length(Current), Current, 'DisplayName', 'Current'); % Different syntax for plotting double vector
plot(1:length(LinkVolt), LinkVolt, 'DisplayName', 'LinkVoltage');
plot(MaxVolt.Time, MaxVolt.Data, 'DisplayName', 'MaxVoltage');
plot(HVBatPrechgInbt.Time, HVBatPrechgInbt.Data, 'DisplayName', 'HVBatPrechgInbt');
plot(HVILFault.Time, HVILFault.Data, 'DisplayName', 'HVILFault');
plot(1:length(KeIdx), KeIdx, 'DisplayName', 'KeIdx');
plot(MaxAllowedTime.Time, MaxAllowedTime.Data, 'DisplayName', 'MaxAllowedTime');
plot(MainHVBatCntctrCmd.Time, MainHVBatCntctrCmd.Data, 'DisplayName', 'MainHVBatCntctrCmd');
plot(1:length(MaxI), MaxI, 'DisplayName', 'MaxI');
plot(PrechargeAllw.Time, PrechargeAllw.Data, 'DisplayName', 'PrechargeAllw');
plot(OvercurrentFault.Time, OvercurrentFault.Data, 'DisplayName', 'OverCurrentFault');
plot(Resistor.Time, Resistor.Data, 'DisplayName', 'Resistor');
plot(RetryOccurred.Time, RetryOccurred.Data, 'DisplayName', 'RetryOccurred');
plot(1:length(SamplesPrechargeFunction), SamplesPrechargeFunction, 'DisplayName', 'SamplesPrechargeFunction');
plot(SimTime.Time, SimTime.Data, 'DisplayName', 'SimTime');
plot(1:length(StageOut), StageOut, 'DisplayName', 'StageOut');
plot(1:length(K1), K1, 'DisplayName', 'K1');
plot(1:length(K2), K2, 'DisplayName', 'K2');
plot(1:length(K3), K3, 'DisplayName', 'K3');
plot(1:length(K4), K4, 'DisplayName', 'K4');


legend;
% Set axes limits
xlim([0 2]);
ylim([0 2]);
xlabel('Time (s)');
ylabel('Signal Value');
title('Simulink Inputs and Outputs');

grid on;