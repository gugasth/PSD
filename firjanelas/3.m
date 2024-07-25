clear all; close all; clc;
M = 71;

limiar_seguranca = 20;
Omega_c1 = 50+limiar_seguranca;
Omega_c2 = 900-limiar_seguranca;
Omega_s = 2000;
wc1 = Omega_c1*2*pi/Omega_s;
wc2 = Omega_c2*2*pi/Omega_s;
%% Resposta ao impulso do filtro ideal h[n]
n = [-1*((M-1)/2):(M-1)/2];
h_n = ((sin(wc2.*n) - sin(wc1.*n))./(pi.*n)); %resposta ao impulso para ≠0
h_n(((M-1)/2)+1) = (wc2 - wc1)/pi; %resposta ao impulso para n=0
w_hamm = 0.54 + 0.46*cos(2*n.*pi/(M));%coeficientes da janela de hamming
w_hann = 0.5 + 0.5*cos(2*n.*pi/(M));%coeficientes da janela de hanning
w_black = 0.42+0.5*cos(2*n.*pi/(M))+0.08*cos(4*n.*pi/(M)); %coeficientes da janela de blackman
h_ret = h_n;
h_hamm = w_hamm.*h_n;
h_hann = w_hann.*h_n;
h_black = w_black.*h_n;

figure(3)
freqz(h_ret,1);
title('Filtro FIR passa-faixa - Janela Retangular')

figure
freqz(h_hamm,1);
title('Filtro FIR passa-faixa - Janela de Hammming')


figure
freqz(h_hann,1);
title('Filtro FIR passa-faixa - Janela de Hanning')

figure
freqz(h_black,1);
title('Filtro FIR passa-banda - Janela de Blackman')

%% Sinal
tmin = 0;
tmax = 2;
Fs=2000;
Ts=1/Fs;

L=(tmax-tmin)/Ts;
t=tmin:Ts:tmax-Ts;
s = 5*sin(2*pi*50*t) + 2*sin(2*pi*350*t) + sin(2*pi*900*t);
S = fft(s);
S = abs(2*S/L);
S = fftshift(S);
freq = Fs*(-(L/2):(L/2)-1)/L;
%% Gráficos do sinal
figure(1)
subplot(3,1,1),plot(t,s);
title('Sinal')
xlabel('t')
ylabel('s(t)')
subplot(3,1,2),plot(freq,S)
title('Espectro de Amplitude de s(t)')
xlabel('f (Hz)')
ylabel('|S(f)|')
h_hamm = w_hamm.*h_n;
h_hann = w_hann.*h_n;
h_black = w_black.*h_n;
s_f_h_ret = filter(h_ret,1,s);
S_F_h_ret = fft(s_f_h_ret);
S_F_h_ret = abs(2*S_F_h_ret/L);
S_F_h_ret = fftshift(S_F_h_ret);
subplot(3,1,3),plot(freq,S_F_h_ret)
title('Espectro de Amplitude do sinal Filtrado ')
xlabel('f (Hz)')
ylabel('|S(f)|')

