N = 1000;
T = 100;
fs = N / T;
t = linspace(0, T, N);
fc = 100;
w = randn(1, N);
theta = -pi + (2 * pi) * rand;
A_values = [10, 1, 0.1];
figure;
for i = 1:length(A_values)
    A = A_values(i);
    x = A * cos(2 * pi * fc * t + theta) + w;
    
    
    subplot(3, 3, (i - 1) * 3 + 1);
    plot(t, x);
    title(['Message Signal x(t), A = ', num2str(A)]);
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;

    % Compute and plot autocorrelation function
    [Rxx, lags] = xcorr(x, 'normalized');
    tau = lags / fs;
    
    subplot(3, 3, (i - 1) * 3 + 2);
    plot(tau, Rxx);
    title(['Autocorrelation, A = ', num2str(A)]);
    xlabel('Lag (s)');
    ylabel('Autocorrelation');
    grid on;

    % Compute and plot frequency spectrum of the autocorrelation function
    Rxx_fft = abs(fftshift(fft(Rxx)));
    freq = linspace(-fs/2, fs/2, length(Rxx));
    
    subplot(3, 3, (i - 1) * 3 + 3);
    plot(freq, Rxx_fft);
    title(['Spectrum of Autocorrelation, A = ', num2str(A)]);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    grid on;
end

sgtitle('Message Signal, Autocorrelation, and Spectrum for Different Amplitudes');