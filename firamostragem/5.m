clear all; close all; clc;

% Parâmetros do filtro passa-faixa
M = 52;           % Comprimento do filtro menos um
N = M + 1;        % Comprimento total do filtro
Omega_r1 = 3;     % Frequência de corte inferior da banda de rejeição
Omega_p1 = 2;     % Frequência de corte inferior da banda de passagem
Omega_p2 = 8;     % Frequência de corte superior da banda de passagem
Omega_r2 = 7;     % Frequência de corte superior da banda de rejeição
Omega_s = 20.0;   % Frequência de amostragem

% Calcular índices de truncamento
kp1 = floor(N * Omega_p1 / Omega_s);
kr1 = floor(N * Omega_r1 / Omega_s);
kp2 = floor(N * Omega_p2 / Omega_s);
kr2 = floor(N * Omega_r2 / Omega_s);

% Ajusta kp se a diferença entre kr e kp for maior do que 1
if (kr1 - kp1) > 1
    kp1 = kr1 - 1;
end

% Ajusta kp se a diferença entre kr e kp for maior do que 1
if (kr2 - kp2) > 1
    kp2 = kr2 - 1;
end

A = zeros(1, N);
A(kp1:kp2) = 1;

h = zeros(1, N);

k = 1:M/2;

for n = 0:M
    h(n + 1) = 2 * sum((-1).^(k+1) .* A(k + 1) .* sin(pi * k * (1 + 2 *
n) / N));
end

h = h ./ N;

% Calcular resposta em frequência
[H, w] = freqz(h, 1, 2048, Omega_s);

% Plotar resposta em frequência
figure;
plot(w, 20*log10(abs(H)));
axis([0 10 -300 50]);
ylabel('Resposta de Módulo (dB)');
xlabel('Frequência (rad/s)');
title('Resposta em Frequência');

% Plotando a resposta ao impulso
figure(2)
stem(h)
ylabel('Resposta ao impulso')
xlabel('Amostras (n)')


