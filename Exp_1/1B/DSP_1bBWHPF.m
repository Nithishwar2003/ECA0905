clc;
clear;
close all;

% Specifications
Fs = 10000;
Fp = 3000;
Fst = 2000;

% Determine minimum order and cutoff frequency
[N,Wn] = buttord(Fp/(Fs/2), Fst/(Fs/2), 1, 60);

% Design High-Pass Butterworth Filter
[b,a] = butter(N, Wn, 'high');

%% Frequency Response
figure;
freqz(b,a);
title('Frequency Response');
saveas(gcf,'HPF_Frequency_Response.png');
savefig('HPF_Frequency_Response.fig');

%% Impulse Response
figure;
[h,n] = impz(b,a,50);
stem(n,h,'filled');
grid on;
title('Impulse Response');
xlabel('Samples');
ylabel('Amplitude');
saveas(gcf,'HPF_Impulse_Response.png');
savefig('HPF_Impulse_Response.fig');

%% Step Response
figure;
stepz(b,a);
grid on;
title('Step Response');
saveas(gcf,'HPF_Step_Response.png');
savefig('HPF_Step_Response.fig');

%% Group Delay
figure;
grpdelay(b,a);
grid on;
title('Group Delay');
saveas(gcf,'HPF_Group_Delay.png');
savefig('HPF_Group_Delay.fig');

%% Pole-Zero Plot
figure;
zplane(b,a);
grid on;
title('Pole-Zero Plot');
saveas(gcf,'HPF_Pole_Zero_Plot.png');
savefig('HPF_Pole_Zero_Plot.fig');

%% Display Results
fprintf('Minimum Filter Order (N) = %d\n', N);
fprintf('Cutoff Frequency (Wn) = %.4f\n', Wn);