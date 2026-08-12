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

outputFolder = fullfile(scriptPath,'Window_Analysis_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ==========================================================
% Signal Parameters
%% ==========================================================

fs = 1000;
N = 256;

t = (0:N-1)/fs;

x = sin(2*pi*100*t) + 0.8*sin(2*pi*110*t);

NFFT = 2048;

f = (0:NFFT/2-1)*(fs/NFFT);

%% ==========================================================
% Window Functions
%% ==========================================================

w = {rectwin(N), hamming(N), hann(N)};

names = {'Rectangular','Hamming','Hanning'};

%% ==========================================================
% Window Processing
%% ==========================================================

for i = 1:3

    xw = x(:).*w{i};

    X = fft(xw,NFFT);

    P{i} = abs(X(1:NFFT/2));

    P{i} = P{i}/max(P{i});

end

%% ==========================================================
% Figure 1 : Individual Spectra
%% ==========================================================

fig1 = figure;

for i = 1:3

    subplot(3,1,i)

    plot(f,20*log10(P{i}),'LineWidth',1.5)

    title(['Spectrum using ',names{i},' Window'])

    xlabel('Frequency (Hz)')
    ylabel('Magnitude (dB)')

    xlim([0 250])

    grid on

end

exportgraphics(fig1,...
    fullfile(outputFolder,'Individual_Spectra.png'),...
    'Resolution',300);

%% ==========================================================
% Figure 2 : Window Comparison
%% ==========================================================

fig2 = figure;

plot(f,20*log10(P{1}),'k','LineWidth',1.5)
hold on
plot(f,20*log10(P{2}),'r','LineWidth',1.5)
plot(f,20*log10(P{3}),'b','LineWidth',1.5)

legend(names)

title('Window Comparison')

xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')

xlim([50 170])

grid on

exportgraphics(fig2,...
    fullfile(outputFolder,'Window_Comparison.png'),...
    'Resolution',300);

%% ==========================================================
% Figure 3 : Window Shapes
%% ==========================================================

fig3 = figure;

for i = 1:3

    subplot(3,1,i)

    plot(w{i},'LineWidth',1.5)

    title([names{i},' Window'])

    xlabel('Samples')
    ylabel('Amplitude')

    grid on

end

exportgraphics(fig3,...
    fullfile(outputFolder,'Window_Shapes.png'),...
    'Resolution',300);

%% ==========================================================
% Peak Detection
%% ==========================================================

for i = 1:3

    [pks{i},loc{i}] = findpeaks(P{i},f,'MinPeakHeight',0.3);

    fprintf('\n%s Window Frequencies:\n',names{i});
    disp(loc{i});

end

%% ==========================================================
% Figure 4 : Peak Detection (Hamming)
%% ==========================================================

fig4 = figure;

plot(f,20*log10(P{2}),'LineWidth',1.5)
hold on

plot(loc{2},20*log10(pks{2}),...
    'ro','MarkerFaceColor','r')

title('Detected Frequencies (Hamming Window)')

xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')

xlim([50 170])

grid on

exportgraphics(fig4,...
    fullfile(outputFolder,'Detected_Frequencies_Hamming.png'),...
    'Resolution',300);

%% ==========================================================
% Main Spectral Peaks
%% ==========================================================

fprintf('\nMain Spectral Peaks:\n');

for i = 1:3

    [~,idx] = max(P{i});

    fprintf('%s Window Peak = %.2f Hz\n',names{i},f(idx));

end

%% ==========================================================
% Completion Message
%% ==========================================================

disp(' ');
disp('Program executed successfully.');
disp(['Images saved in: ',outputFolder]);

disp('Saved Files:');
disp('1. Individual_Spectra.png');
disp('2. Window_Comparison.png');
disp('3. Window_Shapes.png');
disp('4. Detected_Frequencies_Hamming.png');