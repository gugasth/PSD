pkg load signal

% Limpa todas as variáveis e figuras anteriores
clear all; close all; clc;

% Definição dos parâmetros do filtro
Ap = 1;
Ar = 40;
Omega_p = 1000;       % Frequência de corte da banda de passagem
Omega_r = 1200;     % Frequência de corte da banda de rejeição
Omega_s = 5000;      % Frequência de amostragem

delta_p = (10^(0.05*Ap) - 1)/(10^(0.05*Ap) + 1);
delta_r = 10^(-0.05*Ar);

F = [Omega_p Omega_r];
A = [1 0];
ripples = [delta_p delta_r];
[M,Wn,beta,FILTYPE] = kaiserord(F,A,ripples,Omega_s);
kaiser_win = kaiser(M+1,beta);
h = fir1(M,Wn,FILTYPE,kaiser_win,'noscale');
figure(1)
stem(0:M,h)
ylabel('h[n]');
xlabel('n)');
title('Resposta ao Impulso');




[H,w]=freqz(h,1,2048,Omega_s);
figure(2)
plot(w,20*log10(abs(H)))
axis([0 Omega_s/2 -90 10])
ylabel('Resposta de Módulo (dB)');
xlabel('Frequência (Hz)');
title('Resposta em Frequência');
