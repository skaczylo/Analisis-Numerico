% --- SCRIPT testmeuler.m ---
% Limpieza total antes de empezar
clear all; % Borra variables de la mesa (Workspace)
clc;       % Limpia el texto de la ventana de comandos
close all; % Cierra todas las ventanas de gráficos abiertas


datos; 
[t, x] = meuler(f, intervalo, x0, N);
graficas;

