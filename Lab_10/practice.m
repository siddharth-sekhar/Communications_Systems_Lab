fs = 500;
t = 0:1/fs:1;
f = 5;
x = sin(2*pi*f*t);
delta = 0.04;
y = zeros(1, length(x));
encoded = ones(1,length(x));

for i = 2:length(x)
    error = x(i)-y(i-1);
    if error>0
        y(i)=y(i-1)+delta;
        encoded(i)=1;
    else
        y(i)=y(i-1)-delta;
        encoded(i)=0;
    end
end

decoded = ones(1,length(x));

for i=2:length(encoded)
    if encoded(i)==1
        decoded(i)=decoded(i-1)+delta;
    else
        decoded(i)=decoded(i-1)-delta;
    end
end
fc=10;
[b,a]=butter(5,fc/(fs/2),'low');
demodulated = filter(b,a,decoded);

subplot(4,1,1);
plot(t,x);
title("Message signal");

subplot(4,1,2);
stairs(t,y);
title("Quantized signal");

subplot(4,1,3);
stairs(t,encoded);
title("Encoded Signal");

subplot(4,1,4);
stairs(t,demodulated);
title("Decoded signal");


