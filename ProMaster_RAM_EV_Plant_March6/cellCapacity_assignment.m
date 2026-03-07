%This script changes the cell capacitance of all of the module in pack_105s34p_structured/Pack1
%The cell capacity are all 4.9 A*hr.

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
        capacitanceVal = 4.9; 

        % Apply to model
        set_param(blockPath, 'AHCell', num2str(capacitanceVal)); 

        % Log to command window
        fprintf('Set cell capacitance value = %.3f for %s\n', capacitanceVal, blockPath); 
    end
end
