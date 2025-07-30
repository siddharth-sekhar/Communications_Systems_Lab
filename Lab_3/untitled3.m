am=10;
fm=100;
fs=10000;
t=0:1/fs:0.05;
x=am*sin(2*pi*fm*t);
sgtitle("EC22B1062");
subplot(5,1,1);
plot(t,x);
title("message signal")
n=[1 2 3 4];
x_min=min(x);
x_max=max(x);
for i=1:4
    L=2^n(i);
    delta=(x_max-x_min)/(L-1);
    q=(round((x-x_min)/delta)*delta+x_min);
    subplot(5,1,i+1);
    stairs(t,q);
    title(['Quantized Signal with N = ', num2str(n(i)), ' bits']);
end

