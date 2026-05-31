% =========================================================================
% Descripcion: Script principal que define el problema de valor inicial:
% x'(t) = 2*x(t) + t^2, x(0) = 1, t en [0, 2].
% 
% Tareas ejecutadas:
% 1) Aproximacion de la solucion llamando a 'metrk2.m' con a=1, b=4, N=100.
% 2) Calculo del error global en norma infinito comparando con la solucion
%    exacta x(t) = (1/4)*(5*exp(2*t) - 2*t^2 - 2*t - 1).
% 3) Representacion grafica de la solucion numerica y la solucion exacta.
% =========================================================================

%Calculamos la aproximación mediante el metodo de Runge Kutta

%Datos
f = @(t,x) 2*x + t.^2;
x0 = 1;
intervalo = [0,2];
N = 100;
a=1;
b=4;

[t,xi] = metodosMonopaso.m_rungekuta2(f,intervalo,x0,N,a,b);

x = (1/4)*(5*exp(2*t)-2*t.^2-2*t-1);

%Calculo error norma infinito

error = max(abs(xi-x));
fprintf("Error maximo %e",error);

figure;
plot(t,xi);

hold on;
plot(t,x);