function [t,x] =m_adambashforth2(f, intervalo,x0,N)
% Método multipaso Adams-Bashforth de 2 pasos
% Resuelve dy/dt = f(t,y) usando la fórmula:
% x_(i+2) = x_(i+1) + (h/2)*(3*f(t_(i+1),x_(i+1)) - f(t_i,x_i))
% Inputs:
%   f: función handle de la EDO @(t,y)
%   intervalo: [t_inicial, t_final]
%   x0: condición inicial
%   N: número de pasos
% Outputs:
%   t: vector de tiempos (N×1)
%   x: solución (N×m) donde m es dimensión de y


%x_(i+2) = x_(i+1) + h/2*(3f(t_(i+1),x_(i+1) - f(t_i,x_i))


t = linspace(intervalo(1),intervalo(2),N)';
h = (intervalo(2)-intervalo(1))/N;
[t,y] = ode45(f,t,x0);

x(1,:) = y(1,:);
x(2,:) = y(2,:);

for i = 1:(N-2)
    x(i+2,:) = x(i+1,:)+ (h/2)*(3*f(t(i+1),x(i+1,:)) - f( t(i), x(i,:) ))'; 
end



