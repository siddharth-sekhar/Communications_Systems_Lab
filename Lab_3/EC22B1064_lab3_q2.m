am=10;
fm=100;
fs=10000;
t=0:1/fs:0.05;
n=[1 2 3 4] ;
x=am*sin(2*pi*fm*t);
x_min=min(x);
x_max=max(x);
for i=1:4
    figure;
    sgtitle("EC22B1062");
    subplot(4,2,1);
    plot(t,x);
    title("message signal")
    L=2^n(i);
    delta=(x_max-x_min)/(L-1);
    q=round((x-x_min)/delta)*delta+x_min;
    subplot(4,2,3);
    plot(t,q);
    title("quantized signal")
    error=x-q;
    subplot(4,2,6);
    plot(t,error);
    title("quantized  error signal")
    encode=round((x-x_min)/delta);   
    decode=(encode*delta)-am;
    subplot(4,2,5);
    stairs(t,encode);
    title("encoded signal")
    subplot(4,2,7);
    plot(t,decode);
    title("decoded signal")
    f = linspace(-fs/2, fs/2, length(t));
    message_spectrum = abs(fftshift(fft(x)));
    quantized_spectrum = abs(fftshift(fft(q)));
    decoded_spectrum = abs(fftshift(fft(decode)));
    subplot(4,2,2);
    plot(f,message_spectrum);
    title("message spectrum")
    subplot(4,2,4);
    plot(f,quantized_spectrum);
    title("quantized spectrum")
    subplot(4,2,8);
    plot(f,decoded_spectrum);
    title("decoded spectrum")
end