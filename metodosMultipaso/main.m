% main.m — Demostración de los métodos multipaso explícitos
% PVI de prueba:  x'(t) = -2x,  x(0) = 1  en [0, 2]
% Solución exacta: x(t) = e^{-2t}
clear; clc; close all;

f   = @(t,x) -2*x;
sol = @(t) exp(-2*t);
intervalo = [0, 2];
x0 = 1;
N  = 50;

[t, xAB] = m_adambashforth2(f, intervalo, x0, N);
[~, xPM] = m_puntomedio(f, intervalo, x0, N);

figure; hold on; grid on;
plot(t, xAB, '-o', 'DisplayName', 'Adams-Bashforth 2 pasos');
plot(t, xPM, '-s', 'DisplayName', 'Punto medio (leapfrog)');
plot(t, sol(t), 'k--', 'LineWidth', 1.5, 'DisplayName', 'exacta');
legend show; xlabel('t'); ylabel('x(t)');
title('Métodos multipaso explícitos');
