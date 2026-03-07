%This script changes the inital SOC of all of the cells in pack_105s34p_structured/Pack1
%The inital SOC are all 0.

% Model base
model = 'pack_105s34p_structured';
assemblyBasePath = 'Pack1/ModuleAssembly';
assemblyCounts = [24, 27, 27, 27]; % Number of modules in Assembly1 to Assembly4

% Loop through each ModuleAssembly
for assemblyIdx = 1:length(assemblyCounts)
    numModules = assemblyCounts(assemblyIdx);
    assemblyPath = [assemblyBasePath, num2str(assemblyIdx)];

    % Loop through each module inside the assembly
    for moduleIdx = 1:numModules
        % Full block path to module
        blockPath = sprintf('%s/%s/Module%02d', model, assemblyPath, moduleIdx);

        % Generate random SOC
        SOCVal = 0; 

        % Apply to model
        set_param(blockPath, 'SOC_Init', num2str(SOCVal)); 

        % Log to command window
        fprintf('Set cell SoC value = %.3f for %s\n', SOCVal, blockPath); 
    end
end
