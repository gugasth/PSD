clear all; close all; clc;

% Parâmetros do filtro passa-faixa
M = 52;           % Comprimento do filtro menos um
N = M + 1;        % Comprimento total do filtro
Omega_r1 = 2;     % Frequência de corte inferior da banda de rejeição
Omega_p1 = 3;     % Frequência de corte inferior da banda de passagem
Omega_p2 = 7;     % Frequência de corte superior da banda de passagem
Omega_r2 = 8;     % Frequência de corte superior da banda de rejeição
Omega_s = 20.0;   % Frequência de amostragem

% Calcular índices de truncamento
kp1 = floor(N * Omega_p1 / Omega_s);
kr1 = floor(N * Omega_r1 / Omega_s);
kp2 = floor(N * Omega_p2 / Omega_s);
kr2 = floor(N * Omega_r2 / Omega_s);

% Construir as janelas
A1 = [zeros(1, kr1) ones(1, M/2 - kp1 + 1)];
A2 = [zeros(1, kr2) ones(1, M/2 - kp2 + 1)];


% Calcular coeficientes do filtro FIR passa-faixa
k = 1:(M-1)/2;
h = zeros(1, M+1);

for n = 0:M
    h(n+1) = A1(1) * cos(pi * n) + 2 * sum((-1).^k .* A1(k+1) .* cos(pi * k .* (1 + 2*n) / N)) ...
           + A2(1) * cos(pi * n) + 2 * sum((-1).^k .* A2(k+1) .* cos(pi * k .* (1 + 2*n) / N));
end

% Normalizar coeficientes
h = h ./ N;

% Calcular resposta em frequência
[H, w] = freqz(h, 1, 2048, Omega_s);

% Plotar resposta em frequência
figure;
plot(w, 20*log10(abs(H)));
ylabel('Resposta de Módulo (dB)');
xlabel('Frequência (rad/s)');
title('Resposta em Frequência - Filtro Passa-Faixa');
grid on;

