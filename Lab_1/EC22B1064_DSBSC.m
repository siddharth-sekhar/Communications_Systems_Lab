Fs = 10000;    
t = -0.1:0.0001:0.1;      
fc = 1000;          
fm = 100;           
Ac = 1;             
Am = 0.5;  


message = Am * sin(2 * pi * fm * t);
carrier = Ac * cos(2 * pi * fc * t);
dsbsc = Ac * message .* cos(2 * pi * fc * t);

 
demodulated_dsbsc_filtered = dsbsc.*cos(2*pi*fc*t);
demodulated_dsbsc_filtered = lowpass(demodulated_dsbsc_filtered,fm,Fs);

subplot(3, 1, 1);
plot(t, message);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3, 1, 2);
plot(t, dsbsc);
title('DSBSC Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3, 1, 3);
plot(t, demodulated_dsbsc_filtered);
title('Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Frequency analysis
N = length(dsbsc);
f = linspace(-Fs/2,Fs/2,(length(message)));
Y = abs(fft(dsbsc)); 

figure;
plot(f, Y);
title('Frequency Domain of DSBSC Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;
