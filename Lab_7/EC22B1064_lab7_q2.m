clc; clear; close all;

fs = 1000;   
Tb = 1;      
Eb = 1;      
fc1 = 5;     
fc2 = 2;     
N = 10;      
SNR_dB = -20; 

bits = randi([0 1], 1, N);

t = 0:1/fs:Tb-1/fs;
t_total = 0:1/fs:N*Tb-1/fs;

A = sqrt(2*Eb/Tb); 
carrier1 = A * cos(2*pi*fc1*t);
carrier1_ = A * cos(2*pi*fc1*t_total);
carrier2 = A * cos(2*pi*fc2*t);
carrier2_ = A * cos(2*pi*fc2*t_total);

matched_filter1 = fliplr(carrier1);
matched_filter2 = fliplr(carrier2);

modulated_signal = [];
for i = 1:N
    if bits(i) == 1
        modulated_signal = [modulated_signal, carrier1];
    else
        modulated_signal = [modulated_signal, carrier2];
    end
end

received_signal = awgn(modulated_signal, SNR_dB, 'measured'); 

filtered_signal1 = conv(received_signal, matched_filter1, 'same'); 
filtered_signal2 = conv(received_signal, matched_filter2, 'same');

received_bits = zeros(1, N);

for i = 1:N
    index_start = (i-1)*length(t) + 1;
    index_end = i*length(t);
    
    y1 = sum(filtered_signal1(index_start:index_end).^2);
    y2 = sum(filtered_signal2(index_start:index_end).^2);
    
    decision_signal(i) = y1 - y2;
    
    if (y1-y2) > 0
        received_bits(i) = 1;
    else
        received_bits(i) = 0;
    end
end

figure;
subplot(4,2,1);
stairs(bits, 'linewidth', 2);
ylim([-0.5 1.5]);
title('Original Bit Sequence');
grid on;

subplot(4,2,2);
plot(t_total, carrier1_');
title('Carrier Signal with fc1');
grid on;

subplot(4,2,3);
plot(t_total, carrier2_);
title('Carrier Signal with fc2');
grid on;

subplot(4,2,4);
plot(t_total, modulated_signal);
title('BFSK Modulated Signal');
grid on;

subplot(4,2,5);
plot(t_total, received_signal);
title(['Noisy BFSK Signal (SNR = ' num2str(SNR_dB) ' dB) using awgn']);
grid on;

subplot(4,2,6);
plot(t_total, filtered_signal1); hold on;
plot(t_total, filtered_signal2); hold off;
title('Matched Filter Outputs');
legend('Filter Output for fc1', 'Filter Output for fc2');
grid on;

subplot(4,2,7);
plot(t_total, filtered_signal1 - filtered_signal2);
title('BFSK Demodulated Signal');
grid on;

subplot(4,2,8);
stairs(received_bits, 'linewidth', 2);
ylim([-0.5 1.5]);
title('Demodulated Bit Sequence');
grid on;

