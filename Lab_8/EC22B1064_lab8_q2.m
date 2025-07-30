clc; 
clear; 
close all;

Tb = 1;                      
fc = 2;                      
fs = 100;                    
t = 0:1/fs:Tb-1/fs;          
A = sqrt(2/Tb);  
Eb = 2;

message = [1 0 1 1 0 0 1 0]; 
N = length(message);
t_total = 0:1/fs:N*Tb-1/fs;  

carrier = A * Eb * cos(2*pi*fc*t);  

mapped_signal = sqrt(Eb) * (2*message - 1); 

bpsk_signal = [];
for i = 1:N
    if message(i) == 1
        bpsk_signal = [bpsk_signal, carrier];
    else
        bpsk_signal = [bpsk_signal, -carrier];
    end
end

snr_db = 20; 
bpsk_signal_noisy = awgn(bpsk_signal, snr_db, 'measured');

matched_filter = fliplr(carrier);
received_signal = conv(bpsk_signal_noisy, matched_filter, 'same');


demodulated_bits = zeros(1, N);
for i = 1:N
    segment = received_signal((i-1)*fs+1:i*fs);
    correlation = sum(segment .* carrier);  
    demodulated_bits(i) = correlation > 0;   
end

figure;
subplot(6,1,1);
stairs([0:N]*Tb, [message message(end)], 'LineWidth', 2);
title('Original Message Bit Sequence'); ylim([-0.2 1.2]); grid on;

subplot(6,1,2);
plot(t, carrier, 'r', 'LineWidth', 2);
title('Carrier Signal'); grid on;

subplot(6,1,3);
stairs([0:N]*Tb, [mapped_signal mapped_signal(end)], 'LineWidth', 2);
title('Mapped Signal (1 → +1, 0 → -1)'); ylim([-1.2 3]); grid on;

subplot(6,1,4);
plot(t_total, bpsk_signal, 'b', 'LineWidth', 2);
title('BPSK Modulated Signal'); grid on;

subplot(6,1,5);
plot(t_total, received_signal, 'g', 'LineWidth', 2);
title('Received Signal after Matched Filter'); grid on;

subplot(6,1,6);
stairs([0:N]*Tb, [message message(end)], 'r', 'LineWidth', 2); hold on;
stairs([0:N]*Tb, [demodulated_bits demodulated_bits(end)], 'b--', 'LineWidth', 2);
title('Comparison: Original vs. Demodulated Bits'); ylim([-0.2 1.2]); grid on;
legend('Original', 'Demodulated');

disp('Original Message:');
disp(message);
disp('Demodulated Bits:');
disp(demodulated_bits);
ber = sum(demodulated_bits ~= message) / N;
disp(['Bit Error Rate (BER): ', num2str(ber)]);