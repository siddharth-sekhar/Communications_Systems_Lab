N_values = [1 2 3 4];
fs = 1000; 
t = 0:1/fs:1-1/fs; 
f = 5;
signal = sin(2 * pi * f * t); 
for i = 1:length(N_values)
    N = N_values(i);
    L = 2^N;
    step_size = 2*max(abs(signal))/L;
    quantized_signal = round((signal + 1) / step_size) * step_size - 1;
    ns = signal-quantized_signal;
    fprintf("At N = %d\n",N);
    disp("Value of L");
    disp(L);
    fprintf('The number of quantization levels are: %d\n', L);
    fprintf("The Step size is %f\n",step_size);
    max_error = max(signal-quantized_signal);
    fprintf("The maximum quantization error is: %f\n",max_error);
    sqnr = var(signal)/var(ns);
    sqnr_db = 10*log10(sqnr);
    fprintf("The SQNR value is: %f\n",sqnr_db);

end


