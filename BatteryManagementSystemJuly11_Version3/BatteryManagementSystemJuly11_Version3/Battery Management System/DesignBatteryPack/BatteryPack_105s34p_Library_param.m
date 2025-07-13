%% Battery parameters

%% ModuleType1
ModuleType1.SOC_vecCell = [0, .1, .25, .5, .75, .9, 1]; % Vector of state-of-charge values, SOC
ModuleType1.T_vecCell = [278, 293, 313]; % Vector of temperatures, T, K
ModuleType1.V0_matCell = [3.49, 3.5, 3.51; 3.55, 3.57, 3.56; 3.62, 3.63, 3.64; 3.71, 3.71, 3.72; 3.91, 3.93, 3.94; 4.07, 4.08, 4.08; 4.19, 4.19, 4.19]; % Open-circuit voltage, V0(SOC,T), V
ModuleType1.V_rangeCell = [0, inf]; % Terminal voltage operating range [Min Max], V
ModuleType1.R0_matCell = [.0117, .0085, .009; .011, .0085, .009; .0114, .0087, .0092; .0107, .0082, .0088; .0107, .0083, .0091; .0113, .0085, .0089; .0116, .0085, .0089]; % Terminal resistance, R0(SOC,T), Ohm
ModuleType1.AHCell = 27; % Cell capacity, AH, A*hr
ModuleType1.thermal_massCell = 100; % Thermal mass, J/K
ModuleType1.CoolantResistance = 1.2; % Cell level coolant thermal path resistance, K/W
ModuleType1.CellBalancingClosedResistance = 0.01; % Cell balancing switch closed resistance, Ohm
ModuleType1.CellBalancingOpenConductance = 1e-8; % Cell balancing switch open conductance, 1/Ohm
ModuleType1.CellBalancingThreshold = 0.5; % Cell balancing switch operation threshold
ModuleType1.CellBalancingResistance = 50; % Cell balancing shunt resistance, Ohm

%% ParallelAssemblyType1
ParallelAssemblyType1.SOC_vecCell = [0, .1, .25, .5, .75, .9, 1]; % Vector of state-of-charge values, SOC
ParallelAssemblyType1.T_vecCell = [278, 293, 313]; % Vector of temperatures, T, K
ParallelAssemblyType1.V0_matCell = [3.49, 3.5, 3.51; 3.55, 3.57, 3.56; 3.62, 3.63, 3.64; 3.71, 3.71, 3.72; 3.91, 3.93, 3.94; 4.07, 4.08, 4.08; 4.19, 4.19, 4.19]; % Open-circuit voltage, V0(SOC,T), V
ParallelAssemblyType1.V_rangeCell = [0, inf]; % Terminal voltage operating range [Min Max], V
ParallelAssemblyType1.R0_matCell = [.0117, .0085, .009; .011, .0085, .009; .0114, .0087, .0092; .0107, .0082, .0088; .0107, .0083, .0091; .0113, .0085, .0089; .0116, .0085, .0089]; % Terminal resistance, R0(SOC,T), Ohm
ParallelAssemblyType1.AHCell = 27; % Cell capacity, AH, A*hr
ParallelAssemblyType1.thermal_massCell = 100; % Thermal mass, J/K
ParallelAssemblyType1.CoolantResistance = 1.2; % Cell level coolant thermal path resistance, K/W
ParallelAssemblyType1.CellBalancingClosedResistance = 0.01; % Cell balancing switch closed resistance, Ohm
ParallelAssemblyType1.CellBalancingOpenConductance = 1e-8; % Cell balancing switch open conductance, 1/Ohm
ParallelAssemblyType1.CellBalancingThreshold = 0.5; % Cell balancing switch operation threshold
ParallelAssemblyType1.CellBalancingResistance = 50; % Cell balancing shunt resistance, Ohm

%% Battery initial targets

%% ModuleAssembly1.Module1
ModuleAssembly1.Module1.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly1.Module1.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly1.Module1.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly1.Module1.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly1.Module1.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly1.Module1.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly1.Module1.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly1.Module2
ModuleAssembly1.Module2.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly1.Module2.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly1.Module2.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly1.Module2.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly1.Module2.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly1.Module2.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly1.Module2.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly1.Module3
ModuleAssembly1.Module3.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly1.Module3.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly1.Module3.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly1.Module3.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly1.Module3.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly1.Module3.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly1.Module3.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly1.Module4
ModuleAssembly1.Module4.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly1.Module4.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly1.Module4.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly1.Module4.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly1.Module4.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly1.Module4.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly1.Module4.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly1.Module5
ModuleAssembly1.Module5.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly1.Module5.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly1.Module5.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly1.Module5.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly1.Module5.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly1.Module5.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly1.Module5.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly1.Module6
ModuleAssembly1.Module6.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly1.Module6.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly1.Module6.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly1.Module6.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly1.Module6.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly1.Module6.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly1.Module6.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly1.Module7
ModuleAssembly1.Module7.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly1.Module7.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly1.Module7.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly1.Module7.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly1.Module7.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly1.Module7.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly1.Module7.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly1.Module8
ModuleAssembly1.Module8.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly1.Module8.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly1.Module8.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly1.Module8.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly1.Module8.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly1.Module8.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly1.Module8.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly1.Module9
ModuleAssembly1.Module9.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly1.Module9.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly1.Module9.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly1.Module9.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly1.Module9.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly1.Module9.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly1.Module9.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly2.Module1
ModuleAssembly2.Module1.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly2.Module1.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly2.Module1.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly2.Module1.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly2.Module1.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly2.Module1.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly2.Module1.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly2.Module2
ModuleAssembly2.Module2.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly2.Module2.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly2.Module2.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly2.Module2.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly2.Module2.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly2.Module2.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly2.Module2.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly2.Module3
ModuleAssembly2.Module3.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly2.Module3.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly2.Module3.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly2.Module3.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly2.Module3.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly2.Module3.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly2.Module3.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly2.Module4
ModuleAssembly2.Module4.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly2.Module4.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly2.Module4.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly2.Module4.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly2.Module4.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly2.Module4.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly2.Module4.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly2.Module5
ModuleAssembly2.Module5.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly2.Module5.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly2.Module5.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly2.Module5.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly2.Module5.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly2.Module5.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly2.Module5.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly2.Module6
ModuleAssembly2.Module6.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly2.Module6.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly2.Module6.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly2.Module6.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly2.Module6.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly2.Module6.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly2.Module6.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly2.Module7
ModuleAssembly2.Module7.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly2.Module7.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly2.Module7.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly2.Module7.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly2.Module7.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly2.Module7.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly2.Module7.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly2.Module8
ModuleAssembly2.Module8.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly2.Module8.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly2.Module8.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly2.Module8.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly2.Module8.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly2.Module8.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly2.Module8.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly2.Module9
ModuleAssembly2.Module9.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly2.Module9.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly2.Module9.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly2.Module9.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly2.Module9.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly2.Module9.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly2.Module9.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly3.Module1
ModuleAssembly3.Module1.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly3.Module1.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly3.Module1.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly3.Module1.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly3.Module1.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly3.Module1.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly3.Module1.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly3.Module2
ModuleAssembly3.Module2.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly3.Module2.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly3.Module2.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly3.Module2.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly3.Module2.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly3.Module2.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly3.Module2.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly3.Module3
ModuleAssembly3.Module3.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly3.Module3.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly3.Module3.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly3.Module3.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly3.Module3.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly3.Module3.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly3.Module3.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly3.Module4
ModuleAssembly3.Module4.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly3.Module4.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly3.Module4.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly3.Module4.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly3.Module4.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly3.Module4.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly3.Module4.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly3.Module5
ModuleAssembly3.Module5.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly3.Module5.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly3.Module5.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly3.Module5.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly3.Module5.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly3.Module5.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly3.Module5.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly3.Module6
ModuleAssembly3.Module6.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly3.Module6.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly3.Module6.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly3.Module6.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly3.Module6.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly3.Module6.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly3.Module6.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly3.Module7
ModuleAssembly3.Module7.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly3.Module7.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly3.Module7.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly3.Module7.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly3.Module7.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly3.Module7.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly3.Module7.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly3.Module8
ModuleAssembly3.Module8.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly3.Module8.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly3.Module8.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly3.Module8.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly3.Module8.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly3.Module8.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly3.Module8.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly3.Module9
ModuleAssembly3.Module9.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly3.Module9.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly3.Module9.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly3.Module9.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly3.Module9.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly3.Module9.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly3.Module9.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly4.Module1
ModuleAssembly4.Module1.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly4.Module1.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly4.Module1.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly4.Module1.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly4.Module1.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly4.Module1.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly4.Module1.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly4.Module2
ModuleAssembly4.Module2.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly4.Module2.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly4.Module2.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly4.Module2.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly4.Module2.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly4.Module2.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly4.Module2.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly4.Module3
ModuleAssembly4.Module3.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly4.Module3.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly4.Module3.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly4.Module3.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly4.Module3.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly4.Module3.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly4.Module3.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly4.Module4
ModuleAssembly4.Module4.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly4.Module4.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly4.Module4.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly4.Module4.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly4.Module4.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly4.Module4.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly4.Module4.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly4.Module5
ModuleAssembly4.Module5.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly4.Module5.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly4.Module5.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly4.Module5.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly4.Module5.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly4.Module5.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly4.Module5.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly4.Module6
ModuleAssembly4.Module6.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly4.Module6.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly4.Module6.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly4.Module6.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly4.Module6.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly4.Module6.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly4.Module6.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly4.Module7
ModuleAssembly4.Module7.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly4.Module7.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly4.Module7.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly4.Module7.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly4.Module7.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly4.Module7.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly4.Module7.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

%% ModuleAssembly4.Module8
ModuleAssembly4.Module8.iCell = repmat(0, 102, 1); % Cell current (positive in), A
ModuleAssembly4.Module8.vCell = repmat(0, 102, 1); % Cell terminal voltage, V
ModuleAssembly4.Module8.socCell = repmat(1, 102, 1); % Cell state of charge
ModuleAssembly4.Module8.numCyclesCell = repmat(0, 102, 1); % Cell discharge cycles
ModuleAssembly4.Module8.temperatureCell = repmat(298.15, 102, 1); % Cell temperature, K
ModuleAssembly4.Module8.vParallelAssembly = repmat(0, 3, 1); % Parallel Assembly Voltage, V
ModuleAssembly4.Module8.socParallelAssembly = repmat(1, 3, 1); % Parallel Assembly state of charge

% Suppress MATLAB editor message regarding readability of repmat
%#ok<*REPMAT>
