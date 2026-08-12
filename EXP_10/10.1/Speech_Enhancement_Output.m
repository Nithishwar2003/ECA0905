clc;
clear;
close all;

%% =========================================================
% Speech Enhancement using Spectral Subtraction
% =========================================================

%% Input Parameters

Fs = 8000;
t = 0:1/Fs:3;

%% =========================================================
% Generate Clean Signal
% =========================================================

x = sin(2*pi*200*t) + ...
    0.5*sin(2*pi*400*t);

%% =========================================================
% Add Noise
% =========================================================

xn = x + 0.3*randn(size(x));

%% =========================================================
% Spectral Subtraction
% =========================================================

Y = fft(xn);

% Estimate noise spectrum
noise = 0.3*randn(size(xn));
N = fft(noise);

% Magnitude spectral subtraction
enhancedMagnitude = max(abs(Y) - abs(N),0);

% Reconstruct enhanced signal
xe = real(ifft(...
    enhancedMagnitude .* exp(1j*angle(Y))));

%% =========================================================
% Create Output Folder
% =========================================================

scriptPath = fileparts(mfilename('fullpath'));

if isempty(scriptPath)
    scriptPath = pwd;
end

outputFolder = fullfile(scriptPath,...
    'Speech_Enhancement_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% =========================================================
% Figure 1: Time-Domain Signals
% =========================================================

fig1 = figure;

subplot(3,1,1)

plot(t,x,'LineWidth',1.2);
grid on;
title('Clean Speech');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,2)

plot(t,xn,'LineWidth',1.2);
grid on;
title('Noisy Speech');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,3)

plot(t,xe,'LineWidth',1.2);
grid on;
title('Enhanced Speech');
xlabel('Time (s)');
ylabel('Amplitude');

exportgraphics(fig1,...
    fullfile(outputFolder,...
    'Speech_Time_Domain.png'),...
    'Resolution',300);

%% =========================================================
% Figure 2: Spectrograms
% =========================================================

fig2 = figure;

subplot(3,1,1)

spectrogram(x);
title('Clean Spectrogram');

subplot(3,1,2)

spectrogram(xn);
title('Noisy Spectrogram');

subplot(3,1,3)

spectrogram(xe);
title('Enhanced Spectrogram');

exportgraphics(fig2,...
    fullfile(outputFolder,...
    'Speech_Spectrograms.png'),...
    'Resolution',300);

%% =========================================================
% Figure 3: Magnitude Spectra
% =========================================================

fig3 = figure;

subplot(3,1,1)

plot(abs(fft(x)),'LineWidth',1.2);
grid on;
title('Clean Spectrum');
xlabel('Frequency Bin');
ylabel('Magnitude');

subplot(3,1,2)

plot(abs(fft(xn)),'LineWidth',1.2);
grid on;
title('Noisy Spectrum');
xlabel('Frequency Bin');
ylabel('Magnitude');

subplot(3,1,3)

plot(abs(fft(xe)),'LineWidth',1.2);
grid on;
title('Enhanced Spectrum');
xlabel('Frequency Bin');
ylabel('Magnitude');

exportgraphics(fig3,...
    fullfile(outputFolder,...
    'Speech_Magnitude_Spectra.png'),...
    'Resolution',300);

%% =========================================================
% Display Results
% =========================================================

disp(' ');
disp('==============================================');
disp('SPEECH ENHANCEMENT');
disp('==============================================');

fprintf('Sampling Frequency = %d Hz\n',Fs);
fprintf('Signal Duration = %.2f seconds\n',t(end));

disp(' ');
disp(['Output folder: ',outputFolder]);

disp(' ');
disp('PNG files saved successfully:');

disp('1. Speech_Time_Domain.png');
disp('2. Speech_Spectrograms.png');
disp('3. Speech_Magnitude_Spectra.png');

disp(' ');
disp('Simulation completed successfully.');