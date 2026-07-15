clc;
clear;
close all;

% Specifications
Fs = 10000;
Fp = 1000;
Fst = 1500;

% Determine minimum order and cutoff frequency
[N, Wn] = buttord(Fp/(Fs/2), Fst/(Fs/2), 1, 60);

% Design Butterworth Low-Pass Filter
[b, a] = butter(N, Wn);

%% Frequency Response
figure;
freqz(b, a);
title('Frequency Response');
saveas(gcf,'Frequency_Response.png');      % Save graph
savefig('Frequency_Response.fig');         % Editable MATLAB figure

%% Impulse Response
figure;
[h,n] = impz(b, a, 50);
stem(n,h,'filled');
title('Impulse Response');
xlabel('Samples');
ylabel('Amplitude');
grid on;
saveas(gcf,'Impulse_Response.png');
savefig('Impulse_Response.fig');

%% Step Response
figure;
stepz(b,a);
title('Step Response');
grid on;
saveas(gcf,'Step_Response.png');
savefig('Step_Response.fig');

%% Pole-Zero Plot
figure;
zplane(b,a);
title('Pole-Zero Plot');
grid on;
saveas(gcf,'Pole_Zero_Plot.png');
savefig('Pole_Zero_Plot.fig');

%% Display Results
fprintf('Minimum Filter Order (N) = %d\n', N);
fprintf('Cutoff Frequency (Wn) = %.4f\n', Wn);