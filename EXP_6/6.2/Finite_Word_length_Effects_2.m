clc;
clear;
close all;

%% ==========================================================
% Create Output Folder
%% ==========================================================

scriptPath = fileparts(mfilename('fullpath'));

if isempty(scriptPath)
    scriptPath = pwd;
end

outputFolder = fullfile(scriptPath,'Quantization_Comparison_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ==========================================================
% Generate Signal
%% ==========================================================

n = 0:79;

x = sin(2*pi*n/40);

q = 8;          % Quantization Levels

%% ==========================================================
% Quantization
%% ==========================================================

xt = floor(x*q)/q;      % Truncation
xr = round(x*q)/q;      % Rounding

%% ==========================================================
% Quantization Error
%% ==========================================================

et = x - xt;
er = x - xr;

mse_trunc = mean(et.^2);
mse_round = mean(er.^2);

%% ==========================================================
% Figure 1 : Original vs Quantized
%% ==========================================================

fig1 = figure;

plot(n,x,'b','LineWidth',1.5)
hold on
plot(n,xr,'r','LineWidth',1.5)

grid on
xlabel('Sample Number')
ylabel('Amplitude')
title('Original vs Quantized Signal')
legend('Original','Quantized')

exportgraphics(fig1,...
    fullfile(outputFolder,'Original_vs_Quantized.png'),...
    'Resolution',300);

%% ==========================================================
% Figure 2 : Truncation vs Rounding
%% ==========================================================

fig2 = figure;

plot(n,x,'b','LineWidth',1.5)
hold on
plot(n,xt,'r','LineWidth',1.5)
plot(n,xr,'g','LineWidth',1.5)

grid on
xlabel('Sample Number')
ylabel('Amplitude')
title('Truncation vs Rounding')
legend('Original','Truncated','Rounded')

exportgraphics(fig2,...
    fullfile(outputFolder,'Truncation_vs_Rounding.png'),...
    'Resolution',300);

%% ==========================================================
% Figure 3 : Quantization Error
%% ==========================================================

fig3 = figure;

stem(n,et,'r','filled')
hold on
stem(n,er,'g','filled')

grid on
xlabel('Sample Number')
ylabel('Error')
title('Quantization Error')
legend('Truncation','Rounding')

exportgraphics(fig3,...
    fullfile(outputFolder,'Quantization_Error.png'),...
    'Resolution',300);

%% ==========================================================
% Figure 4 : MSE Comparison
%% ==========================================================

fig4 = figure;

bar([mse_trunc mse_round])

set(gca,'XTickLabel',{'Truncation','Rounding'})

grid on
ylabel('Mean Square Error')
title('MSE Comparison')

exportgraphics(fig4,...
    fullfile(outputFolder,'MSE_Comparison.png'),...
    'Resolution',300);

%% ==========================================================
% Display Results
%% ==========================================================

fprintf('\n');
fprintf('Mean Square Error (MSE)\n');
fprintf('-----------------------\n');
fprintf('Truncation MSE = %.6f\n',mse_trunc);
fprintf('Rounding MSE   = %.6f\n',mse_round);

disp(' ');
disp('Program executed successfully.');
disp(['Images saved in: ',outputFolder]);

disp('Saved Files:');
disp('1. Original_vs_Quantized.png');
disp('2. Truncation_vs_Rounding.png');
disp('3. Quantization_Error.png');
disp('4. MSE_Comparison.png');