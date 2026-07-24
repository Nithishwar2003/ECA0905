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

outputFolder = fullfile(scriptPath,'Hanning_Filter_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ==========================================================
% Input Parameters
%% ==========================================================

fp = 1000;                 % Passband cutoff frequency (Hz)
fs = 4000;                 % Sampling frequency (Hz)
N = 50;                    % Filter order

wc = fp/(fs/2);            % Normalized cutoff frequency

%% ==========================================================
% FIR Low Pass Filter using Hanning Window
%% ==========================================================

b_hann = fir1(N, wc, 'low', hann(N+1));

disp('--- Hanning Window Coefficients ---');
disp(b_hann');

%% ==========================================================
% Plot Frequency Response
%% ==========================================================

fig = figure;

freqz(b_hann,1);

title('Low-pass FIR using Hanning Window');

%% ==========================================================
% Save Figure as PNG
%% ==========================================================

filename = fullfile(outputFolder,'Hanning_Window_Frequency_Response.png');

exportgraphics(fig, filename, 'Resolution', 300);

%% ==========================================================
% Completion Message
%% ==========================================================

disp(' ');
disp('Frequency response generated successfully.');
disp(['PNG image saved at: ', filename]);