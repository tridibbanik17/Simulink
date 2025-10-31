%This script changes the ambient temperature of all of the module in a/Pack1


% Model base
model = 'a';
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
        T_ambient = 318.15; % Ambient temperature
 

        % Apply to model
        set_param(blockPath, 'T_ambient', num2str(T_ambient)); 

        % Log to command window
        fprintf('Set ambient temperature value = %.3f for %s\n', T_ambient, blockPath); 
    end
end
