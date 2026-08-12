clc;
clear;
close all;

%% =========================================================
% Discrete-Time Signal Sampling Operations
% Decimation and Interpolation by 2
% =========================================================

%% Original Sequence

n = 0:40;

x = sin(0.3*pi*n);

%% Decimation by 2

y = x(1:2:end);

nd = 0:length(y)-1;

%% Interpolation by 2

v = zeros(1,2*length(x));

v(1:2:end) = x;

ni = 0:length(v)-1;

%% =========================================================
% Create Output Folder
% =========================================================

scriptPath = fileparts(mfilename('fullpath'));

if isempty(scriptPath)
    scriptPath = pwd;
end

outputFolder = fullfile(scriptPath,...
    'Decimation_Interpolation_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% =========================================================
% Figure 1: Original Sequence
% =========================================================

fig1 = figure;

stem(n,x,'filled');

grid on;

title('Original Sequence x[n]');
xlabel('n');
ylabel('Amplitude');

exportgraphics(fig1,...
    fullfile(outputFolder,...
    'Original_Sequence.png'),...
    'Resolution',300);

%% =========================================================
% Figure 2: Decimated Sequence
% =========================================================

fig2 = figure;

stem(nd,y,'filled');

grid on;

title('Decimated Sequence by 2');
xlabel('n');
ylabel('Amplitude');

exportgraphics(fig2,...
    fullfile(outputFolder,...
    'Decimated_Sequence.png'),...
    'Resolution',300);

%% =========================================================
% Figure 3: Interpolated Sequence
% =========================================================

fig3 = figure;

stem(ni,v,'filled');

grid on;

title('Interpolated Sequence by 2');
xlabel('n');
ylabel('Amplitude');

exportgraphics(fig3,...
    fullfile(outputFolder,...
    'Interpolated_Sequence.png'),...
    'Resolution',300);

%% =========================================================
% Figure 4: Comparison
% =========================================================

fig4 = figure;

stem(n,x,'b');
hold on;

stem(0:2:length(v)-2,...
    v(1:2:end),'r');

legend('Original x[n]','Interpolated Samples');

grid on;

title('Comparison of Sequences');
xlabel('n');
ylabel('Amplitude');

exportgraphics(fig4,...
    fullfile(outputFolder,...
    'Sequence_Comparison.png'),...
    'Resolution',300);

%% =========================================================
% Display Results
% =========================================================

disp(' ');
disp('==============================================');
disp('DECIMATION AND INTERPOLATION');
disp('==============================================');

disp(['Original samples     : ',num2str(length(x))]);
disp(['Decimated samples    : ',num2str(length(y))]);
disp(['Interpolated samples : ',num2str(length(v))]);

disp(' ');
disp(['Output folder: ',outputFolder]);

disp(' ');
disp('PNG files saved successfully:');

disp('1. Original_Sequence.png');
disp('2. Decimated_Sequence.png');
disp('3. Interpolated_Sequence.png');
disp('4. Sequence_Comparison.png');

disp(' ');
disp('Simulation completed successfully.');