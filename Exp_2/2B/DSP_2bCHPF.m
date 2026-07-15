clc;
clear;
close all;

% Specifications
Rp = 1;      % Passband Ripple (dB)
Rs = 40;     % Stopband Attenuation (dB)
Wp = 0.5;    % Passband Edge
Ws = 0.35;   % Stopband Edge

% Find Filter Order
[n,Wn] = cheb1ord(Wp, Ws, Rp, Rs);

% Design High-Pass Filter
[b,a] = cheby1(n, Rp, Wn, 'high');

%% Frequency Response
figure;
freqz(b,a);
title('Frequency Response');
saveas(gcf,'Cheby1_HPF_Frequency_Response.png');
savefig('Cheby1_HPF_Frequency_Response.fig');

%% Impulse Response
figure;
impz(b,a);
grid on;
title('Impulse Response');
saveas(gcf,'Cheby1_HPF_Impulse_Response.png');
savefig('Cheby1_HPF_Impulse_Response.fig');

%% Group Delay
figure;
grpdelay(b,a);
grid on;
title('Group Delay');
saveas(gcf,'Cheby1_HPF_Group_Delay.png');
savefig('Cheby1_HPF_Group_Delay.fig');

%% Pole-Zero Plot
figure;
zplane(b,a);
grid on;
title('Pole-Zero Plot');
saveas(gcf,'Cheby1_HPF_Pole_Zero_Plot.png');
savefig('Cheby1_HPF_Pole_Zero_Plot.fig');

%% Display Results
fprintf('Filter Order = %d\n', n);
fprintf('Cutoff Frequency = %.4f\n', Wn);