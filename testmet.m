function testmet(metodo)
% TESTMET Ejecuta un método numérico genérico y dibuja su solución
% Entrada: metodo (nombre de la función con @ pues si @ ejecutaria directamente el metodo antes de pasarlo como argumento y fallaria)

    % 1. Limpiamos solo la pantalla y las ventanas (¡OJO! No usamos clear all 
    % aquí dentro porque borraríamos la variable 'metodo' que acaba de entrar)
    clc;
    close all;

    datos; 
    [t, x] = metodo(f, intervalo, x0, N);
    graficas;

end