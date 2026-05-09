function [t,x]=mrk3(f,intervalo,x0,N)
% La función meuler resuelve un problema de valor inicial de la forma
% x'(t)=f(t,x(t)) en [t0,T]
% x(t0)=x0,
% con x0 en R^n, mediante el método de Euler (explícito).
%
% ENTRADA:
% f: función (definida en formato anónimo o como fichero de tipo función de Matlab) del
% problema que se quiere resolver, con dos argumentos de entrada: el primero es un número
% real y el segundo es un vector columna de tipo (n,1) o un vector fila de tipo (1,n)
% intervalo: [t0,T], donde está planteado el sistema de ecuaciones diferenciales
% x0: vector inicial de tipo (1,n)
% N: número de subintervalos
%
% SALIDA:
% t: vector, de tipo (N+1,1), de nodos de [t0,T] donde se va a aproximar la solución
% x: matriz, de tipo (N+1,n), de valores de la solución aproximada en los nodos

% --- Inicialización correcta ---

n = size(x0,2);
t0 = intervalo(1);
T = intervalo(2);
h = (T-t0)/N;

t = linspace(t0,T,N+1)';

x = zeros(N+1,n);
x(1,:) = x0;

for i = 1:N
    
    F1 = f(t(i),x(i,:)');
    F2 = f(t(i)+h/2, x(i,:)'+h*F1/2);
    F3 = f(t(i) + 3*h/4, x(i,:)'+3*h*F2/4);

    x(i+1,:) = x(i,:) + h*(2*F1'+3*F2'+4*F3')/9;

end
