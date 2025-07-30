fs = 500;
t = 0:1/fs:1;
f = 5;
x = sin(2*pi*f*t);
delta = 0.04;
y = zeros(1, length(x));
%e = zeros(1, length(x));
 
for i = 2:length(x)
    e = x(i) - y(i-1);
    if e >= 0
        y(i) = y(i-1) + delta;
        encoded(i) = 1;
    else
        y(i) = y(i-1) - delta;
        encoded(i) = 0;
    end
end
decoded = zeros(1, length(x));
for i = 2:length(encoded)
    if encoded(i) == 1
        decoded(i) = decoded(i-1) + delta;
    else
        decoded(i) = decoded(i-1) - delta;
    end
end
fc = 10; 
[b, a] = butter(5, fc/(fs/2), 'low'); 
demodulated = filter(b, a, decoded);
figure;
subplot(5,2,1);
plot(t, x);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
subplot(5,2,2);
stairs(t, y);
title('Quantized Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
subplot(5,2,3);
stairs(t, encoded);
title('Encoded Signal (First 100 Samples)');
xlabel('Time (s)');
ylabel('Binary Value');
grid on;
subplot(5,2,4);
plot(t, decoded);
title('Decoded Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
X_f = abs(fftshift(fft(x)));
Y_f = abs(fftshift(fft(y)));
D_f = abs(fftshift(fft(decoded)));
E_f = abs(fftshift(fft(encoded)));
f_axis = linspace(-fs/2, fs/2, length(X_f));
subplot(5,2,5);
plot(f_axis, X_f);
title('Spectrum of Message Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
subplot(5,2,6);
plot(f_axis, D_f);
title('Spectrum of Decoded Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
subplot(5,2,7);
plot(f_axis, Y_f);
title('Spectrum of quantized Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
subplot(5,2,8);
plot(f_axis, E_f);
title('Spectrum of encoded Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
subplot(5,2,9);
plot(t, demodulated);
title('demodulated Signal');
xlabel('time');
ylabel('Magnitude');
grid on;
figure;
subplot(1, 1, 1);
hold on;
plot(t, x, 'DisplayName', 'Original Message');
stairs(t, y, 'DisplayName', 'quantized Signal');
xlabel('Time (s)');
ylabel('Amplitude');
title('Comparison of Original and quantized Signals');
legend;
grid on;