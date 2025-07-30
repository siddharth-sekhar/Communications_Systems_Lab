clc; clear; close all;
N_bits = 10;       
Fs = 100;          
T = 1;            

t_mod = 0:1/Fs:(N_bits+1)*T-1/Fs;    
t_msg = 0:1/Fs:N_bits*T-1/Fs;        

mk = [0 1 1 0 1 0 0 1 1 1];   
d = zeros(1, N_bits+1);         
d(1) = 1;                     

for k = 1:N_bits
    if mk(k) == 0
        d(k+1) = ~d(k);        
    else
        d(k+1) = d(k);         
    end
end 

signal = ones(size(d));
signal(d==0) = -1;


phase = zeros(size(d));
phase(1) = 0;
for k = 2:length(d)
    if d(k) ~= d(k-1)
        phase(k) = 180;    % 180° change when bit flips
    else
        phase(k) = 0;      % No change when bit stays same
    end
end

fc = 3;                         
norm = sqrt(2/T);               
carrier = norm * sin(2*pi*fc*t_mod);
mod_signal = repelem(signal, Fs*T) .* carrier;

snr = 25;
noisy_signal = awgn(mod_signal,snr, 'measured');

demod = noisy_signal .* carrier;
integrated = sum(reshape(demod, Fs*T, []))/(Fs*T);
received = ones(size(integrated));
received(integrated < 0) = 0;

decoded = zeros(1, length(received)-1);
for k = 1:length(decoded)
    if received(k+1) == received(k)
        decoded(k) = 1;    
    else
        decoded(k) = 0;   
    end
end

msg_plot = repelem(mk, Fs*T);
dec_plot = repelem(decoded, Fs*T);
phase_plot = repelem(phase, Fs*T);

figure
subplot(7,1,1)
stairs(t_msg, msg_plot,'LineWidth', 1.5)
title('Original Message')
xlabel('Time (s)')
ylabel('Amplitude')
ylim([-0.1 1.1])

subplot(7,1,2)
stairs(t_mod, phase_plot,'LineWidth', 1.5)
title('Phase Change (deg)')
xlabel('Time (s)')
ylabel('Phase (deg)')
ylim([-10 190])
xlim([0 10])

subplot(7,1,3)
plot(t_mod, mod_signal)
title('Modulated Signal')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(7,1,4)
plot(t_mod, noisy_signal)
title('Signal with Noise')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(7,1,5)
stairs(t_msg, dec_plot(1:N_bits*Fs*T), 'LineWidth', 1.5)
title('Decoded Signal')
xlabel('Time (s)')
ylabel('Amplitude')
ylim([-0.1 1.1])

subplot(7,1,6)
plot(t_msg, msg_plot, 'b', t_msg, dec_plot(1:N_bits*Fs*T), 'r--', 'LineWidth', 1.5)
legend('Original', 'Decoded')
title('Comparison')
xlabel('Time (s)')
ylabel('Amplitude')
ylim([-0.1 1.1])

subplot(7,1,7)
stairs(t_msg(1:length(d)),d, 'LineWidth',1.5);
xlabel("Time (s)")
ylabel("Amplitude")
title("d_k plot")

disp(d);

