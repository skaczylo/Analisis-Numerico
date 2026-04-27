% --- SCRIPT testode45.m ---

% Limpieza total antes de empezar
clear all; % Borra variables de la mesa (Workspace)
clc;       % Limpia el texto de la ventana de comandos
close all; % Cierra todas las ventanas de gráficos abiertas

% PASO 1: Cargar los datos
% Simplemente escribimos el nombre del archivo (sin el .m)
datos; 

% PASO 2: Resolver usando la función de MATLAB
% f, intervalo y x0 ya existen porque los cargó 'datos'
[t, x] = ode45(f, intervalo, x0);

% PASO 3: Dibujar los resultados
% Este script usará las variables 't' y 'x' que acabamos de crear
graficas;

fprintf('Proceso finalizado. Si no ves la trayectoria, pulsa ENTER en la Command Window.\n');