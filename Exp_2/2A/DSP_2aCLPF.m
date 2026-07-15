clc;
clear;
close all;

% Filter Specifications
Wp = 0.4;
Ws = 0.55;
Rp = 1;
As = 40;

% Determine Filter Order and Cutoff Frequency
[N,Wn] = cheb1ord(Wp, Ws, Rp, As);

% Design Chebyshev Type-I Low-Pass Filter
[b,a] = cheby1(N, Rp, Wn);

% Display Filter Parameters
fprintf('Filter Order = %d\n', N);
fprintf('Cutoff Frequency = %.2f * pi rad/sample\n', Wn);

% Stability Check
if all(abs(roots(a)) < 1)
    disp('System is STABLE');
else
    disp('System is UNSTABLE');
end

%% Frequency Response
figure;
freqz(b,a);
title('Frequency Response');
saveas(gcf,'Cheby1_Frequency_Response.png');
savefig('Cheby1_Frequency_Response.fig');

%% Impulse Response
figure;
impz(b,a);
grid on;
title('Impulse Response');
saveas(gcf,'Cheby1_Impulse_Response.png');
savefig('Cheby1_Impulse_Response.fig');

%% Group Delay
figure;
grpdelay(b,a);
grid on;
title('Group Delay');
saveas(gcf,'Cheby1_Group_Delay.png');
savefig('Cheby1_Group_Delay.fig');

%% Pole-Zero Plot
figure;
zplane(b,a);
grid on;
title('Pole-Zero Plot');
saveas(gcf,'Cheby1_Pole_Zero_Plot.png');
savefig('Cheby1_Pole_Zero_Plot.fig');