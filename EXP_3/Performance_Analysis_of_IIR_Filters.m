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

outputFolder = fullfile(scriptPath,'Bandpass_Filter_Output');

if ~exist(outputFolder,'dir')
    mkdir(outputFolder);
end

%% ==========================================================
% Specifications
%% ==========================================================

Fs = 2000;
Rp = 1;
Rs = 40;

Wp = [300 600]/(Fs/2);
Ws = [200 700]/(Fs/2);

%% ==========================================================
% Butterworth Filter
%% ==========================================================

[n1,W1] = buttord(Wp,Ws,Rp,Rs);
[b1,a1] = butter(n1,W1,'bandpass');

%% ==========================================================
% Chebyshev Type-I Filter
%% ==========================================================

[n2,W2] = cheb1ord(Wp,Ws,Rp,Rs);
[b2,a2] = cheby1(n2,Rp,W2,'bandpass');

%% ==========================================================
% Magnitude Response - Butterworth
%% ==========================================================

fig1 = figure;
freqz(b1,a1);
title('Butterworth Filter Magnitude Response');

exportgraphics(fig1,...
    fullfile(outputFolder,'Butterworth_Magnitude_Response.png'),...
    'Resolution',300);

%% ==========================================================
% Magnitude Response - Chebyshev
%% ==========================================================

fig2 = figure;
freqz(b2,a2);
title('Chebyshev Type-I Magnitude Response');

exportgraphics(fig2,...
    fullfile(outputFolder,'Chebyshev_Magnitude_Response.png'),...
    'Resolution',300);

%% ==========================================================
% Group Delay Comparison
%% ==========================================================

fig3 = figure;

grpdelay(b1,a1);
hold on;
grpdelay(b2,a2);

legend('Butterworth','Chebyshev-I');
title('Group Delay Comparison');

exportgraphics(fig3,...
    fullfile(outputFolder,'Group_Delay_Comparison.png'),...
    'Resolution',300);

%% ==========================================================
% Pole-Zero Plot
%% ==========================================================

fig4 = figure;

subplot(1,2,1)
zplane(b1,a1)
title('Butterworth')

subplot(1,2,2)
zplane(b2,a2)
title('Chebyshev-I')

exportgraphics(fig4,...
    fullfile(outputFolder,'Pole_Zero_Plots.png'),...
    'Resolution',300);

%% ==========================================================
% Impulse Response
%% ==========================================================

fig5 = figure;

subplot(2,1,1)
impz(b1,a1)
title('Butterworth Impulse')

subplot(2,1,2)
impz(b2,a2)
title('Chebyshev Impulse')

exportgraphics(fig5,...
    fullfile(outputFolder,'Impulse_Response.png'),...
    'Resolution',300);

%% ==========================================================
% Pole Magnitude
%% ==========================================================

fig6 = figure;

subplot(1,2,1)
stem(abs(roots(a1)),'filled')
grid on
title('Butterworth Pole Magnitude')

subplot(1,2,2)
stem(abs(roots(a2)),'filled')
grid on
title('Chebyshev Pole Magnitude')

exportgraphics(fig6,...
    fullfile(outputFolder,'Pole_Magnitude.png'),...
    'Resolution',300);

%% ==========================================================
% Display Filter Orders
%% ==========================================================

disp(['Butterworth Order = ',num2str(n1)])
disp(['Chebyshev Order = ',num2str(n2)])

%% ==========================================================
% Completion Message
%% ==========================================================

disp(' ')
disp('All plots generated successfully.')
disp(['Images saved in: ', outputFolder])

disp('Saved Files:')
disp('1. Butterworth_Magnitude_Response.png')
disp('2. Chebyshev_Magnitude_Response.png')
disp('3. Group_Delay_Comparison.png')
disp('4. Pole_Zero_Plots.png')
disp('5. Impulse_Response.png')
disp('6. Pole_Magnitude.png')