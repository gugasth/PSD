clear all; close all; clc;
M = 301;


% Primeiro Filtro
Omega_c1 = 697;
Omega_c2 = 852;

% Segundo Filtro
Omega_c3 = 770;
Omega_c4 = 941;

% Terceiro Filtro
Omega_c5 = 852;
Omega_c6 = 1209;

Omega_s = 8000;

wc1 = Omega_c1*2*pi/Omega_s;
wc2 = Omega_c2*2*pi/Omega_s;

wc3 = Omega_c3*2*pi/Omega_s;
wc4 = Omega_c4*2*pi/Omega_s;

wc5 = Omega_c5*2*pi/Omega_s;
wc6 = Omega_c6*2*pi/Omega_s;

%% Resposta ao impulso do filtro ideal h[n]
n = [-1*((M-1)/2):(M-1)/2];
h_n = ((sin(wc2.*n) - sin(wc1.*n))./(pi.*n)); %resposta ao impulso para ≠0
h_n(((M-1)/2)+1) = (wc2 - wc1)/pi; %resposta ao impulso para n=0

h_n2 = ((sin(wc4.*n) - sin(wc3.*n))./(pi.*n)); %resposta ao impulso para ≠0
h_n2(((M-1)/2)+1) = (wc4 - wc3)/pi; %resposta ao impulso para n=0

h_n3 = ((sin(wc6.*n) - sin(wc5.*n))./(pi.*n)); %resposta ao impulso para ≠0
h_n3(((M-1)/2)+1) = (wc6 - wc5)/pi; %resposta ao impulso para n=0


w_hamm = 0.54 + 0.46*cos(2*n.*pi/(M));%coeficientes da janela de hamming
w_hann = 0.5 + 0.5*cos(2*n.*pi/(M));%coeficientes da janela de hanning
w_black = 0.42+0.5*cos(2*n.*pi/(M))+0.08*cos(4*n.*pi/(M)); %coeficientes da janela de blackman

h_ret = h_n;

h_hamm1 = w_hamm.*h_n;
h_hann1 = w_hann.*h_n;
h_black1 = w_black.*h_n;

h_hamm2 = w_hamm.*h_n2;
h_hann2 = w_hann.*h_n2;
h_black2 = w_black.*h_n2;

h_hamm3 = w_hamm.*h_n3;
h_hann3 = w_hann.*h_n3;
h_black3 = w_black.*h_n3;

%% Sinal
tmin = 0;
tmax = 2;
Fs=8000;
Ts=1/Fs;

L=(tmax-tmin)/Ts;
t=tmin:Ts:tmax-Ts;

s = sin(2*pi*770*t) + sin(2*pi*852*t) + sin(2*pi*941*t);
S = fft(s);
S = abs(2*S/L);
S = fftshift(S);
freq = Fs*(-(L/2):(L/2)-1)/L;


%% Gráficos do sinal
figure(1)
subplot(3,2,1),plot(t,s);
title('Sinal original')
xlabel('t')
xlim([0 0.2])
ylim([-5 5])
ylabel('s(t)')
subplot(3,2,2),plot(freq,S)
title('Espectro de Amplitude do sinal original')
xlabel('f (Hz)')
ylabel('|S(f)|')
xlim([0 1000])

s_f_h_ret = filter(h_black1,1,s);
S_F_h_ret = fft(s_f_h_ret);
S_F_h_ret = abs(2*S_F_h_ret/L);
S_F_h_ret = fftshift(S_F_h_ret);

subplot(3,2,3),plot(freq,S_F_h_ret)
title('Espectro de Amplitude do sinal Filtrado em 770hz')
xlabel('f (Hz)')
ylabel('|S(f)|')
xlim([0 1000])

s_f_h_ret2 = filter(h_black2,1,s);
S_F_h_ret2 = fft(s_f_h_ret2);
S_F_h_ret2 = abs(2*S_F_h_ret2/L);
S_F_h_ret2 = fftshift(S_F_h_ret2);

subplot(3,2,4),plot(freq,S_F_h_ret2)
title('Espectro de Amplitude do sinal Filtrado em 852hz')
xlabel('f (Hz)')
ylabel('|S(f)|')
xlim([0 1000])


s_f_h_ret3 = filter(h_black3,1,s);
S_F_h_ret3 = fft(s_f_h_ret3);
S_F_h_ret3 = abs(2*S_F_h_ret3/L);
S_F_h_ret3 = fftshift(S_F_h_ret3);

subplot(3,2,5),plot(freq,S_F_h_ret3)
title('Espectro de Amplitude do sinal Filtrado em 941hz')
xlabel('f (Hz)')
ylabel('|S(f)|')
xlim([0 1000])
