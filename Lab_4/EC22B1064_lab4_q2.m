fs = 1000;
t = 0:1/fs:1;
f = 5;
message_signal = sin(2*pi*f*t);
max_slope = 2*pi*f;
delta = (max_slope/fs);

delta_slope_overload = delta*0.8;
delta_granular = delta*10;

y_slope = zeros(1, length(message_signal));
y_granular = zeros(1, length(message_signal));
encoded_slope = zeros(length(message_signal));
encoded_granular = zeros(length(message_signal));

for i = 2:length(message_signal)

    if message_signal(i) >= y_slope(i-1)
        y_slope(i) = y_slope(i-1) + delta_slope_overload;
        encoded_slope(i) = 1;
    else
        y_slope(i) = y_slope(i-1) - delta_slope_overload;
        encoded_slope(i) = 0;
    end

    if message_signal(i) >= y_granular(i-1)
        y_granular(i) = y_granular(i-1) + delta_granular;
        encoded_granular(i) = 1;
    else
        y_granular(i) = y_granular(i-1) - delta_granular;
        encoded_granular(i) = 0;
    end
end


figure;
subplot(3,1,1);
plot(t, message_signal);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(t, y_slope);
title('Quantized Signal (Slope Overload Distortion)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(t, y_granular);
title('Quantized Signal (Granular Noise)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

