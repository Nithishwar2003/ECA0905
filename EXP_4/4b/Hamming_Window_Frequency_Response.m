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

outputFolder = fullfile(scriptPath,'Hamming_Filter_Output');

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
% FIR Low Pass Filter using Hamming Window
%% ==========================================================

b_hamm = fir1(N, wc, 'low', hamming(N+1));

disp('--- Hamming Window Coefficients ---');
disp(b_hamm');

%% ==========================================================
% Plot Frequency Response
%% ==========================================================

fig = figure;

freqz(b_hamm,1);

title('Low-pass FIR using Hamming Window');

%% ==========================================================
% Save Figure as PNG
%% ==========================================================

filename = fullfile(outputFolder,'Hamming_Window_Frequency_Response.png');

exportgraphics(fig, filename, 'Resolution', 300);

%% ==========================================================
% Display Save Location
%% ==========================================================

disp(' ');
disp('Frequency response plotted successfully.');
disp(['PNG image saved at: ', filename]);