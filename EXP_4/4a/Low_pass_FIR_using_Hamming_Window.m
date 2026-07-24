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

outputFolder = fullfile(scriptPath,'FIR_Filter_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ==========================================================
% Input Parameters
%% ==========================================================

fp = 1000;          % Passband cutoff (Hz)
fs = 4000;          % Sampling frequency (Hz)
N = 50;             % Filter order

wc = fp/(fs/2);

%% ==========================================================
% FIR Low Pass using Rectangular Window
%% ==========================================================

b_rect = fir1(N,wc,'low',rectwin(N+1));

disp('Rectangular Window Coefficients');
disp(b_rect');

fig1 = figure;
freqz(b_rect,1);
title('Low-pass FIR using Rectangular Window');

exportgraphics(fig1,...
    fullfile(outputFolder,'Rectangular_Window_Response.png'),...
    'Resolution',300);

%% ==========================================================
% FIR Low Pass using Hamming Window
%% ==========================================================

b_hamm = fir1(N,wc,'low',hamming(N+1));

disp('Hamming Window Coefficients');
disp(b_hamm');

fig2 = figure;
freqz(b_hamm,1);
title('Low-pass FIR using Hamming Window');

exportgraphics(fig2,...
    fullfile(outputFolder,'Hamming_Window_Response.png'),...
    'Resolution',300);

%% ==========================================================
% FIR Low Pass using Hanning Window
%% ==========================================================

b_hann = fir1(N,wc,'low',hann(N+1));

disp('Hanning Window Coefficients');
disp(b_hann');

fig3 = figure;
freqz(b_hann,1);
title('Low-pass FIR using Hanning Window');

exportgraphics(fig3,...
    fullfile(outputFolder,'Hanning_Window_Response.png'),...
    'Resolution',300);

%% ==========================================================
% Completion Message
%% ==========================================================

disp(' ');
disp('All FIR filters designed successfully.');
disp(['Images saved in: ', outputFolder]);

disp('Saved Files:');
disp(fullfile(outputFolder,'Rectangular_Window_Response.png'));
disp(fullfile(outputFolder,'Hamming_Window_Response.png'));
disp(fullfile(outputFolder,'Hanning_Window_Response.png'));