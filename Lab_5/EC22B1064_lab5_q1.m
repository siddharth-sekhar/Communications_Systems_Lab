N = 1000;
T = 1;
fs = N/T;
t = linspace(0, T, N);
x =randn(1, N);
figure;
subplot(3,1,1)
plot(t, x);
title('Gaussian Random Process');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
[Rxx, lags] = xcorr(x, 'normalized');
tau = lags / fs;
subplot(3,1,2)
plot(tau, Rxx);
title('Autocorrelation Function of the Gaussian Process');
xlabel('Lag (s)');
ylabel('Autocorrelation');
grid on;
Rxx_fft = abs(fftshift(fft(Rxx)));
lgth = length(Rxx);
freq = linspace(-fs/2, fs/2, length(Rxx));
subplot(3,1,3)
plot(freq, Rxx_fft);
title('Frequency Spectrum of the Autocorrelation Function');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;