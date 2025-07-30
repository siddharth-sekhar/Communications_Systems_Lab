fs=100;
fc = 2;
y = zeros(1,20);
Tb = 1;
Eb = 1;
N = length(y);
t = 0:1/fs:N*Tb-(1/fs); 
y(1:5) = 1;
y(8:10) = 1;
y(13:17) = 1;
y(19:20) = 1;
subplot(4,1,1)
stairs(0:N-1,y,LineWidth=3);
ylim([-0.5, 1.5]);
xlim([1,19]);
grid on;
title("Original Message signal");
c = sqrt(2*Eb/Tb).*cos(2*pi*fc*t);
subplot(4,1,2)
plot(t,c);
title("BASK Waveform");
xlim([1,19]);
grid on;
s = zeros(1,length(t));
for i = 1:N
    if y(i) == 1
        s((i-1)*fs*Tb+1:i*fs*Tb) = sqrt(2*Eb/Tb) * cos(2*pi*fc*t((i-1)*fs*Tb+1:i*fs*Tb));
    end
end
subplot(4,1,3)
plot(t,s);
title("BASK Modulated Signal");
xlim([1,19]);
grid on;

N1 = length(s);
dem = zeros(1, N); 

for i = 1:N
    % Extract signal segment corresponding to the i-th bit
    segment = s((i-1)*fs*Tb+1:i*fs*Tb);
    
    % Compute the envelope (absolute value)
    avg_amplitude = mean(abs(segment)); 
    
    
    if avg_amplitude >= 0.5 
        dem(i) = 1;
    else
        dem(i) = 0;
    end
end

subplot(4,1,4)
stairs(0:N-1, dem, Linewidth=3);
ylim([-0.5, 1.5]);
xlim([1,19]);
grid on;
title("Demodulated Signal");



