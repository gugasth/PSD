clear all; close all; clc;

% Parâmetros do filtro
Omega_c1 = 10; % Frequência de corte inferior em rad/s
Omega_c2 = 35; % Frequência de corte superior em rad/s
Omega_s = 100; % Frequência de amostragem em rad/s

% Frequências normalizadas
wc1 = Omega_c1 * 2 * pi / Omega_s;
wc2 = Omega_c2 * 2 * pi / Omega_s;

% Valores de M
M_values = [10, 100, 1000];

for i = 1:length(M_values)
    M = M_values(i);
    n = 1:M/2;

    % Filtro ideal
    h0 = 1 - (wc2 - wc1) / pi;
    haux = (sin(wc1.*n) - sin(wc2.*n)) ./ (pi.*n);
    h_ideal = [fliplr(haux) h0 haux];

    % Criar figura para o valor atual de M
    figure;

    % Janela de Hamming
    h_aux = hamming(M + 1)';
    h_ham = h_ideal .* h_aux;
    [H_ham, w] = freqz(h_ham, 1, 2048, Omega_s);

    subplot(311);
    plot(w, 20*log10(abs(H_ham)));
    axis([0 Omega_s/2 -150 10]);
    ylabel('Resposta de Módulo (dB)');
    xlabel('Frequência (rad/s)');
    title(['Resposta em Frequência - Janela de Hamming, M = ', num2str(M)]);
    grid on;

    % Janela de Hanning
    h_aux = hanning(M + 1)';
    h_han = h_ideal .* h_aux;
    [H_han, w] = freqz(h_han, 1, 2048, Omega_s);

    subplot(312);
    plot(w, 20*log10(abs(H_han)));
    axis([0 Omega_s/2 -150 10]);
    ylabel('Resposta de Módulo (dB)');
    xlabel('Frequência (rad/s)');
    title(['Resposta em Frequência - Janela de Hanning, M = ', num2str(M)]);
    grid on;

    % Janela de Blackman
    h_aux = blackman(M + 1)';
    h_black = h_ideal .* h_aux;
    [H_black, w] = freqz(h_black, 1, 2048, Omega_s);

    subplot(313);
    plot(w, 20*log10(abs(H_black)));
    axis([0 Omega_s/2 -150 10]);
    ylabel('Resposta de Módulo (dB)');
    xlabel('Frequência (rad/s)');
    title(['Resposta em Frequência - Janela de Blackman, M = ', num2str(M)]);
    grid on;
end

