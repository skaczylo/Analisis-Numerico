function [t,x] =m_puntomedio(f, intervalo,x0,N)
% Método multipaso del punto medio (2 pasos)
% Resuelve dy/dt = f(t,y) usando la fórmula:
% x_(i+2) = x_(i+1) + 2*h*f(t_(i+1), x_(i+1))
% Inputs:
%   f: función handle de la EDO @(t,y)
%   intervalo: [t_inicial, t_final]
%   x0: condición inicial
%   N: número de pasos
% Outputs:
%   t: vector de tiempos (Nx1)
%   x: solución (N×m) donde m es dimensión de y


%metodo de 2 pasos => calcular x_0 y x_1
t = linspace(intervalo(1),intervalo(2),N)';
h = (intervalo(2)-intervalo(1))/N;
[y,ode_sol]  = ode45(f,t,x0);

x(1,:) = ode_sol(1,:);
x(2,:) = ode_sol(2,:);

for i =1:(N-2)
    x(i+2,:) = x(i+1,:) + 2*h*f(t(i+1),x(i+1,:))' ;
end

