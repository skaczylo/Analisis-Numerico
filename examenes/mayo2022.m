% SCRIPT PARA LA RESOLUCIÓN DE UN PROBLEMA DE CONTORNO MEDIANTE EL MÉTODO DE TIRO
%
% Descripción del problema:
% Este script resuelve numéricamente el siguiente problema de valor de contorno
% lineal de segundo orden:
%
%     -x''(t) + (1 - t/2)x'(t) + x(t) = 0,   para t en el intervalo [0, 1]
%     x'(0) = 4
%     x(1) = -3
%
% Método de resolución:
% Se emplea el "Método de tiro" para transformar este problema de contorno en 
% la resolución de dos problemas de valor inicial (PVI) independientes:
%   - y_1(t) con valores iniciales (y_1(0), y_1'(0)) = (0, 4)
%   - y_2(t) con valores iniciales (y_2(0), y_2'(0)) = (1, 0)
%
% Ambos PVI se aproximan utilizando el Método de Euler explícito con N=100 
% subintervalos. Posteriormente, se combinan linealmente las soluciones para 
% forzar que se cumpla la condición final x(1) = -3.
%
% Finalmente, el script compara la aproximación con la solución exacta 
% analítica x(t) = -t^2 + 4t - 6, calcula el error máximo cometido en 
% la malla y representa gráficamente los resultados.


%Resolvemos y1
%el sistema es equivalente a 
%x' = y
%y' = (1-t/2)y +x
%con valor inicial (x(0),y(0)) = (0,4)
%Resolvemos y1
%el sistema es equivalente a 
%
%x' = y
%y' = (1-t/2)y +x
%con valor inicial (x(0),y(0)) = (0,4)

f = @(t,x) [x(2); (1-t/2)*x(2) + x(1)];  %x = [x,y]
intervalo = [0,1];
N= 100;
h = (intervalo(2)-intervalo(1))/N;
t = linspace(intervalo(1),intervalo(2),N+1)';


m_eulerExplicito = @(t,x) x + h*f(t,x)';



%Resolvemos y1
y1_0 = [0,4];
y_1(1,:) = y1_0; %y_1 = [y1,y1']

for i = 1:N
    y_1(i+1,:) = m_eulerExplicito(t(i), y_1(i,:));
end

%Resolvemos y2
y2_0 = [1,0];
y_2(1,:) = y2_0; %y_2 = [y2,y2']


for i = 1:N
    y_2(i+1,:) = m_eulerExplicito(t(i), y_2(i,:));
end

%Construimos la sol aproximada

x = y_1(:,1) + ((-3-y_1(end,1))/y_2(end,1))*y_2(:,1);
sol_exacta = -t.^2 +4*t-6;

error = abs(x-sol_exacta);
max_error = max(error);
fprintf("El error maximo cometido es: %e",max_error);

figure;
plot(t,x);
hold on;
plot(t, sol_exacta);

pause(2);

figure;
plot(t,error);






