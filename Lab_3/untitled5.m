
am=1;
fm=100;
fs=10000;
t=0:1/fs:0.05;
x=real(am*sin(2*pi*fm*t));
n=[1 2 3 4];
x_min=min(x);
x_max=max(x);
disp("EC22B1062")
for i=1:4
    fprintf("for N= %d\n", n(i));
    L=2^n(i);
    fprintf("No of levels are: %d\n", L);
    delta=((x_max-x_min)/(L-1));
    fprintf("Step size is: %.6f\n", delta);  
    q=(round((x-x_min)/delta)*delta+x_min);
    qe=x-q;
    qe_max=max(qe);
    fprintf("Maximum quantization error is: %.6f\n", qe_max);
    sp=var(x);
    qnp=var(qe);
    sqnr=10*log10(sp/qnp);
    fprintf("SQNR in dB is: %.6f\n\n", sqnr); 
end
