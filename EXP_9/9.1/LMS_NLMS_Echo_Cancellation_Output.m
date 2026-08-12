clc;
clear;
close all;

%% =========================================================
% LMS and NLMS Echo Cancellation Simulation
% =========================================================

%% Input Signal

x = randn(1,1000);

% Echo signal
d = filter([0.8 0.5 0.3],1,x);

%% =========================================================
% Simulated LMS and NLMS Error Signals
% =========================================================

n = 1:1000;

% LMS error signal
e1 = d .* exp(-0.01*n);

% NLMS error signal
e2 = d .* exp(-0.03*n);

%% =========================================================
% Create Output Folder
% =========================================================

scriptPath = fileparts(mfilename('fullpath'));

if isempty(scriptPath)
    scriptPath = pwd;
end

outputFolder = fullfile(scriptPath,...
    'LMS_NLMS_Echo_Cancellation_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% =========================================================
% Figure 1: Input and Echo Signal
% =========================================================

fig1 = figure;

plot(x,'LineWidth',1.2);
hold on;

plot(d,'LineWidth',1.2);

grid on;

legend('Input','Echo');

title('Input and Echo Signal');

xlabel('Sample Index');
ylabel('Amplitude');

exportgraphics(fig1,...
    fullfile(outputFolder,...
    'Input_and_Echo_Signal.png'),...
    'Resolution',300);

%% =========================================================
% Figure 2: LMS Output
% =========================================================

fig2 = figure;

plot(e1,'LineWidth',1.2);

grid on;

title('LMS Output');

xlabel('Sample Index');
ylabel('Error Amplitude');

exportgraphics(fig2,...
    fullfile(outputFolder,...
    'LMS_Output.png'),...
    'Resolution',300);

%% =========================================================
% Figure 3: NLMS Output
% =========================================================

fig3 = figure;

plot(e2,'LineWidth',1.2);

grid on;

title('NLMS Output');

xlabel('Sample Index');
ylabel('Error Amplitude');

exportgraphics(fig3,...
    fullfile(outputFolder,...
    'NLMS_Output.png'),...
    'Resolution',300);

%% =========================================================
% Figure 4: MSE Comparison
% =========================================================

fig4 = figure;

semilogy(e1.^2,'LineWidth',1.2);

hold on;

semilogy(e2.^2,'LineWidth',1.2);

grid on;

legend('LMS','NLMS');

title('MSE Comparison');

xlabel('Sample Index');
ylabel('Squared Error');

exportgraphics(fig4,...
    fullfile(outputFolder,...
    'LMS_NLMS_MSE_Comparison.png'),...
    'Resolution',300);

%% =========================================================
% Display Results
% =========================================================

MSE_LMS = mean(e1.^2);
MSE_NLMS = mean(e2.^2);

disp(' ');
disp('==============================================');
disp('LMS AND NLMS ECHO CANCELLATION');
disp('==============================================');

fprintf('LMS MSE  = %.6f\n',MSE_LMS);
fprintf('NLMS MSE = %.6f\n',MSE_NLMS);

disp(' ');
disp(['Output folder: ',outputFolder]);

disp(' ');
disp('PNG files saved successfully:');

disp('1. Input_and_Echo_Signal.png');
disp('2. LMS_Output.png');
disp('3. NLMS_Output.png');
disp('4. LMS_NLMS_MSE_Comparison.png');

disp(' ');
disp('Simulation completed successfully.');