clear all
M = 52;
N = M+1;
Omega_p = 4;
Omega_r = 4.2;
Omega_s = 10;
kp = floor(N*Omega_p/Omega_s);
kr = floor(N*Omega_r/Omega_s);
A = [ones(1,kp+1) zeros(1,M/2-kr+1)];
if (kr-kp)>1
kp=kr-1;
end
k = 1:M/2;
for n=0:M,
h(n+1) = A(1) + 2*sum((-1).^k.*A(k+1).*cos(pi.*k*(1+2*n)/N));
end;
h = h./N;
[H,w]=freqz(h,1,2048,Omega_s);
figure(1)
plot(w,20*log10(abs(H)))
axis([0 5 -50 10])
ylabel('Resposta de Módulo (dB)');
xlabel('Frequência (rad/s)');
title('Resposta em Frequência');
