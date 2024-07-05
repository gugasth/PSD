% Limpa todas as variáveis e figuras anteriores
clear all; close all; clc;

% Definição dos parâmetros do filtro
M = 200;           % Comprimento do filtro menos um
N = M + 1;         % Comprimento total do filtro
Omega_p = 4;       % Frequência de corte da banda de passagem
Omega_r = 4.2;     % Frequência de corte da banda de rejeição
Omega_s = 10;      % Frequência de amostragem

% Calcula os índices de truncamento
kp = floor(N * Omega_p / Omega_s);
kr = floor(N * Omega_r / Omega_s);

% Ajusta kp se a diferença entre kr e kp for maior do que 1
if (kr - kp) > 1
    kp = kr - 1;
end

% Constrói a janela
A = [ones(1, kp + 1) zeros(1, M/2 - kr + 1)];



% Calcula os coeficientes do filtro FIR usando a janela
k = 1:M/2;
h = zeros(1, M+1);

for n = 0:M
    h(n+1) = A(1) + 2 * sum((-1).^k .* A(k+1) .* cos(pi .* k .* (1 + 2*n) / N));
end

% Normaliza os coeficientes
h = h ./ N;

% Calcula a resposta em frequência do filtro
[H, w] = freqz(h, 1, 2048, Omega_s);

% Plota a resposta em frequência em decibéis versus a frequência
figure(1)
plot(w, 20*log10(abs(H)))
axis([0 5 -50 10])
ylabel('Resposta de Módulo (dB)');
xlabel('Frequência (rad/s)');
title('Resposta em Frequência');

