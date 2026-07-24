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

outputFolder = fullfile(scriptPath,'HighPass_FIR_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ==========================================================
% Input Parameters
%% ==========================================================

fp = 1000;                 % High-pass cutoff frequency (Hz)
fs = 8000;                 % Sampling frequency (Hz)
N = 50;                    % Filter order

wc = fp/(fs/2);            % Normalized cutoff frequency

%% ==========================================================
% FIR High Pass using Rectangular Window
%% ==========================================================

b_rect = fir1(N, wc, 'high', rectwin(N+1));

disp('--- High-Pass Coefficients (Rectangular Window) ---');
disp(b_rect');

fig1 = figure;
freqz(b_rect,1);
title('High-pass FIR using Rectangular Window');

exportgraphics(fig1,...
    fullfile(outputFolder,'HighPass_Rectangular_Window_Response.png'),...
    'Resolution',300);

%% ==========================================================
% FIR High Pass using Hamming Window
%% ==========================================================

b_hamm = fir1(N, wc, 'high', hamming(N+1));

disp('--- High-Pass Coefficients (Hamming Window) ---');
disp(b_hamm');

fig2 = figure;
freqz(b_hamm,1);
title('High-pass FIR using Hamming Window');

exportgraphics(fig2,...
    fullfile(outputFolder,'HighPass_Hamming_Window_Response.png'),...
    'Resolution',300);

%% ==========================================================
% FIR High Pass using Hanning Window
%% ==========================================================

b_hann = fir1(N, wc, 'high', hann(N+1));

disp('--- High-Pass Coefficients (Hanning Window) ---');
disp(b_hann');

fig3 = figure;
freqz(b_hann,1);
title('High-pass FIR using Hanning Window');

exportgraphics(fig3,...
    fullfile(outputFolder,'HighPass_Hanning_Window_Response.png'),...
    'Resolution',300);

%% ==========================================================
% Completion Message
%% ==========================================================

disp(' ');
disp('All High-Pass FIR filters designed successfully.');
disp(['Images saved in: ', outputFolder]);

disp('Saved Files:');
disp(fullfile(outputFolder,'HighPass_Rectangular_Window_Response.png'));
disp(fullfile(outputFolder,'HighPass_Hamming_Window_Response.png'));
disp(fullfile(outputFolder,'HighPass_Hanning_Window_Response.png'));