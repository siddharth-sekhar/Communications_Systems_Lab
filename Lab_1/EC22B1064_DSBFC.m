Fs = 10000;    
t = -0.1:0.0001:0.1;      
fc = 1000;          
fm = 100;           
Ac = 1;             

modulation_indices = [0.5, 1, 1.5]; 

figure;
subplot_index = 1;

for u = modulation_indices
    Am = u * Ac; 
    disp(u);
    message = Am * sin(2 * pi * fm * t);
    carrier = Ac * cos(2 * pi * fc * t);

   
    dsbfc = Ac * (1 + message) .* cos(2 * pi * fc * t);

    dsbfc_envelope = abs(hilbert(dsbfc));
    demodulated_dsbfc = dsbfc_envelope - Ac;  

    
    subplot(3, 2, subplot_index);
    plot(t, dsbfc);
    title(['DSBFC Signal for Modulation Index u = ' num2str(u)]);
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
    subplot_index = subplot_index + 1;

    subplot(3, 2, subplot_index);
    plot(t, demodulated_dsbfc);
    title(['Demodulated Signal for Modulation Index u = ' num2str(u)]);
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
    subplot_index = subplot_index + 1;
end

figure;
subplot_index = 1;

for u = modulation_indices
    Am = u * Ac;
    message = Am * sin(2 * pi * fm * t);
    dsbfc = Ac * (1 + message) .* cos(2 * pi * fc * t);

    N = length(dsbfc);
    f = linspace(-Fs/2,Fs/2,(length(message))); 
    Y = abs(fftshift(fft(dsbfc)));

    subplot(3, 1, subplot_index);
    plot(f, Y);
    title(['Frequency Domain for Modulation Index u = ' num2str(u)]);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    grid on;
    subplot_index = subplot_index + 1;
end
