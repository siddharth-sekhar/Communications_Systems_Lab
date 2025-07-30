N_values = [1 2 3 4];
fs = 1000; 
t = 0:1/fs:1-1/fs; 
f = 5;
signal = sin(2 * pi * f * t); 
theo = [0 0 0 0 ];
prac = [0 0 0 0];
for i = 1:length(N_values)
    N = N_values(i);
    L = 2^N;
    step_size = (2*max(signal))/L;
    quantized_signal = round((signal + 1) / step_size) * step_size - 1;
    n1 = (step_size)^2/12;
    sqnr1 = 10*log10(var(signal)/n1);
    theo(i)=sqnr1;
    err = signal - quantized_signal;
    sqnr2 = 10*log10(var(signal)/var(err));
    prac(i)=sqnr2;
end
T = table(prac,theo);
disp(T);

