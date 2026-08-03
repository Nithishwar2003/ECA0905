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

outputFolder = fullfile(scriptPath,'PCM_Quantization_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ==========================================================
% Generate Signal
%% ==========================================================

fs = 1000;          % Sampling Frequency
f = 50;             % Signal Frequency

t = 0:1/fs:0.1;

x = sin(2*pi*f*t);

%% ==========================================================
% Quantization Levels
%% ==========================================================

L = [8 16 32];

colors = {'r','g','m'};

%% ==========================================================
% Quantization
%% ==========================================================

fig1 = figure;

for i = 1:length(L)

    % Uniform Quantization
    xq{i} = round(((x+1)*(L(i)-1)/2))*(2/(L(i)-1)) - 1;

    % Quantization Error
    e{i} = x - xq{i};

    % Mean Square Error
    mse(i) = mean(e{i}.^2);

    % Quantized Signal
    subplot(4,1,i+1)
    stairs(t,xq{i},colors{i},'LineWidth',1.2)
    grid on
    title(['Quantized Signal (',num2str(L(i)),' Levels)'])
    xlabel('Time (s)')
    ylabel('Amplitude')

end

%% ==========================================================
% Original Signal
%% ==========================================================

subplot(4,1,1)
plot(t,x,'b','LineWidth',1.5)
grid on
title('Original Signal')
xlabel('Time (s)')
ylabel('Amplitude')

exportgraphics(fig1,...
    fullfile(outputFolder,'Quantized_Signals.png'),...
    'Resolution',300);

%% ==========================================================
% Display MSE
%% ==========================================================

fprintf('\n');
fprintf('Mean Square Error (MSE)\n');
fprintf('-----------------------\n');
fprintf('8 Levels  = %.6f\n',mse(1));
fprintf('16 Levels = %.6f\n',mse(2));
fprintf('32 Levels = %.6f\n',mse(3));

%% ==========================================================
% Quantization Error Plots
%% ==========================================================

fig2 = figure;

for i = 1:length(L)

    subplot(3,1,i)
    plot(t,e{i},'LineWidth',1.2)
    grid on
    title(['Quantization Error (',num2str(L(i)),' Levels)'])
    xlabel('Time (s)')
    ylabel('Error')

end

exportgraphics(fig2,...
    fullfile(outputFolder,'Quantization_Error.png'),...
    'Resolution',300);

%% ==========================================================
% Completion Message
%% ==========================================================

disp(' ');
disp('Program executed successfully.');
disp(['Images saved in: ',outputFolder]);

disp('Saved Files:');
disp('1. Quantized_Signals.png');
disp('2. Quantization_Error.png');