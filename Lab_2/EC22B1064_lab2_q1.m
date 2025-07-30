am=1;
ac=1;
kf=100;
fc=1000;
fm=100;
fs=1e5;
t=0:1/fs:0.05;
F=(kf*am);
m_t=am*cos(2*pi*fm*t);
s_t=fmmod(m_t,fc,fs,F);
% using in built
figure;
sgtitle("EC22B1062")
subplot(3,1,1)
plot(t,m_t)
title("message signal")
subplot(3,1,2)
plot(t,s_t);
title("modulated signal")
demod_t=fmdemod(s_t,fc,fs,F);
subplot(3,1,3)
plot(t,demod_t);
title("demodulated signal")