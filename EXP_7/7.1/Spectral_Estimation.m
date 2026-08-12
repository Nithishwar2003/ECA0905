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

outputFolder = fullfile(scriptPath,'PSD_Analysis_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ==========================================================
% Generate Signal
%% ==========================================================

fs = 1000;                      % Sampling Frequency (Hz)

t = (0:999)/fs;

% Original Signal
s = sin(2*pi*100*t) + 0.5*sin(2*pi*200*t);

% Add Gaussian Noise
n = 0.3*randn(size(t));

% Noisy Signal
x = s + n;

%% ==========================================================
% Figure 1 : Signal with Noise
%% ==========================================================

fig1 = figure;

plot(t,x,'LineWidth',1.2)

grid on

title('Signal with Noise')
xlabel('Time (s)')
ylabel('Amplitude')

exportgraphics(fig1,...
    fullfile(outputFolder,'Signal_With_Noise.png'),...
    'Resolution',300);

%% ==========================================================
% Figure 2 : Power Spectral Density (PSD)
%% ==========================================================

fig2 = figure;

periodogram(x,[],[],fs)

title('PSD using Periodogram')

exportgraphics(fig2,...
    fullfile(outputFolder,'PSD_Periodogram.png'),...
    'Resolution',300);

%% ==========================================================
% Figure 3 : Magnitude Spectrum
%% ==========================================================

X = abs(fft(x));

f = (0:length(X)-1)*fs/length(X);

fig3 = figure;

plot(f(1:500),X(1:500),'LineWidth',1.2)

grid on

title('Magnitude Spectrum')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

exportgraphics(fig3,...
    fullfile(outputFolder,'Magnitude_Spectrum.png'),...
    'Resolution',300);

%% ==========================================================
% Figure 4 : Signal and Noise Power Comparison
%% ==========================================================

signalPower = mean(s.^2);
noisePower = var(n);

fig4 = figure;

bar([signalPower noisePower])

set(gca,'XTickLabel',{'Signal','Noise'})

grid on

ylabel('Power')

title('Signal and Noise Power Comparison')

exportgraphics(fig4,...
    fullfile(outputFolder,'Power_Comparison.png'),...
    'Resolution',300);

%% ==========================================================
% Display Results
%% ==========================================================

fprintf('\n');
fprintf('Signal Power = %.4f\n',signalPower);
fprintf('Noise Power  = %.4f\n',noisePower);

disp(' ');
disp('Program executed successfully.');
disp(['Images saved in: ',outputFolder]);

disp('Saved Files:');
disp('1. Signal_With_Noise.png');
disp('2. PSD_Periodogram.png');
disp('3. Magnitude_Spectrum.png');
disp('4. Power_Comparison.png');