% Extract each signal from the output structure
CAN_1 = out.CAN_1;
safe = out.safe;
PreChargeCntctrPos = out.PreChargeCntctrPos;
PreChargeCntctrNeg = out.PreChargeCntctrNeg;
MainCntctr = out.MainCntctr;
DCFCCntctr = out.DCFCCntctr;

% Plot all signals
figure;
hold on;
plot(CAN_1.Time, CAN_1.Data, 'DisplayName', 'CAN\_1');
plot(safe.Time, safe.Data, 'DisplayName', 'safe');
plot(PreChargeCntctrPos.Time, PreChargeCntctrPos.Data, 'DisplayName', 'PreChargeCntctrPos');
plot(PreChargeCntctrNeg.Time, PreChargeCntctrNeg.Data, 'DisplayName', 'PreChargeCntctrNeg');
plot(MainCntctr.Time, MainCntctr.Data, 'DisplayName', 'MainCntctr');
plot(DCFCCntctr.Time, DCFCCntctr.Data, 'DisplayName', 'DCFCCntctr');

legend;
xlabel('Time (s)');
ylabel('Signal Value');
title('Simulink Inputs and Outputs');
grid on;
