clear all; close all; clc;

% Parâmetros do filtro
M = 52; % Comprimento do filtro menos um
N = M + 1; % Comprimento do filtro
Omega_r = 4.0; % Frequência de corte da banda de passagem
Omega_p = 4.2; % Frequência de corte da banda de rejeição
Omega_s = 10.0; % Frequência de amostragem

% Calcular índices de truncamento
kp = floor(N * Omega_p / Omega_s);
kr = floor(N * Omega_r / Omega_s);

% Ajusta kp se a diferença entre kr e kp for maior do que 1
if (kr - kp) > 1
    kp = kr - 1;
end

A = [zeros(1, kr+1) ones(1, M/2 - kp + 1)];

h = zeros(1, N);

% Calcular coeficientes do filtro FIR passa-altas
k = 1:M/2;

for n = 0:M
    h(n+1) = A(1) + 2 * sum((-1).^k .* A(k+1) .* cos(pi * k * (1 + 2*n) / N));
end

h = h ./ N;

% Calcular resposta em frequência
[H, w] = freqz(h, 1, 2048, Omega_s);

% Plotar resposta em frequência
figure;
plot(w, 20*log10(abs(H)));
axis([0 5 -50 10]);
ylabel('Resposta de Módulo (dB)');
xlabel('Frequência (rad/s)');
title('Resposta em Frequência - Filtro Passa-Altas');

% Plotando a resposta ao impulso
figure(2)
stem(h)
ylabel('Resposta ao impulso')
xlabel('Amostras (n)')

