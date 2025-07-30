fs = 1000;
Tb = 1;
fc = 5;
t = 0:1/fs:Tb-1/fs;
symbols_4 = [0 1 2 3];
symbols_8 = [0 1 2 3 4 5 6 7];

message_4 = randi([0 3], 1, 10);
message_8 = randi([0 7], 1, 10);

carrier = cos(2*pi*fc*t);

modulated_4 = [];
for i = 1:length(message_4)
    modulated_4 = [modulated_4, symbols_4(message_4(i)+1) * carrier];
end

modulated_8 = [];
for i = 1:length(message_8)
    modulated_8 = [modulated_8, symbols_8(message_8(i)+1) * carrier];
end

demodulated_wave_4 = modulated_4 .* repmat(carrier, 1, length(message_4));
demodulated_wave_8 = modulated_8 .* repmat(carrier, 1, length(message_8));

demodulated_4 = [];
for i = 1:length(message_4)
    received = demodulated_wave_4((i-1)*fs + 1 : i*fs);
    demodulated_4 = [demodulated_4, trapz(t, received)];
end

demodulated_8 = [];
for i = 1:length(message_8)
    received = demodulated_wave_8((i-1)*length(t) + 1 : i*length(t));
    demodulated_8 = [demodulated_8, trapz(t, received)];
end

decoded_4 = round((demodulated_4 - min(demodulated_4)) / (max(demodulated_4) / 3));
decoded_8 = round((demodulated_8 - min(demodulated_8)) / (max(demodulated_8) / 7));

figure;
subplot(4,1,1);
stairs([message_4], 'LineWidth', 1.5);
ylim([-0.5 3.5]);
title('Message Symbols (M=4)');
grid on;

subplot(4,1,2);
plot(modulated_4, 'LineWidth', 1.5);
title('Modulated Signal (M=4 ASK)');
grid on;

subplot(4,1,3);
plot(demodulated_wave_4, 'LineWidth', 1.5);
title('Demodulated Waveform (M=4 ASK)');
grid on;

subplot(4,1,4);
stairs([decoded_4 decoded_4(end)], 'LineWidth', 1.5);
ylim([-0.5 3.5]);
title('Decoded Symbols (M=4)');
grid on;

figure;
subplot(4,1,1);
stairs([message_8 message_8(end)], 'LineWidth', 1.5);
ylim([-0.5 7.5]);
title('Message Symbols (M=8)');
grid on;

subplot(4,1,2);
plot(modulated_8, 'LineWidth', 1.5);
title('Modulated Signal (M=8 ASK)');
grid on;

subplot(4,1,3);
plot(demodulated_wave_8, 'LineWidth', 1.5);
title('Demodulated Waveform (M=8 ASK)');
grid on;


subplot(4,1,4);
stairs([decoded_8 decoded_8(end)], 'LineWidth', 1.5);
ylim([-0.5 7.5]);
title('Decoded Symbols (M=8)');
grid on;