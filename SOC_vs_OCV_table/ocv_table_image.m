% OCV vs SOC Plot Generator
% Load your data
load('OCV_table.mat');  % Replace with your actual .mat filename

% SOC as percentage
SOC = SOC_range * 100;  % Convert 0-1 to 0-100%

% Row labels (6 cell voltage curves)
legendLabels = {'Cell 1', 'Cell 2', 'Cell 3', 'Cell 4', 'Cell 5', 'Cell 6'};

% Plot
figure('Position', [100, 100, 900, 500]);
hold on;

colors = lines(6);
for i = 1:6
    plot(SOC, OCV_table(i, :), 'LineWidth', 2, 'Color', colors(i,:));
end

hold off;

% Formatting
xlabel('State of Charge (%)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Open Circuit Voltage (V)', 'FontSize', 12, 'FontWeight', 'bold');
title('SOC / OCV Map', 'FontSize', 14, 'FontWeight', 'bold');
legend(legendLabels, 'Location', 'northwest', 'FontSize', 10);
grid on;
box on;
xlim([0 100]);
ylim([2.8 4.3]);

% Export high-res image
exportgraphics(gcf, 'OCV_SOC_Map.png', 'Resolution', 300);
disp('Saved: OCV_SOC_Map.png');