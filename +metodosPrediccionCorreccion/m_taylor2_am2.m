% Script: Método Predictor-Corrector P(EC)E con Taylor y Adams-Moulton 2
% 
% Resuelve el PVI: x'(t) = 2 + 3*cos(x*t^2), x(0) = 1 en [0, 2]
% 
% Algoritmo:
%   - Obtiene x(1) y x(2) usando método de Taylor de orden 2
%   - En cada paso i:
%     * Predictor: calcula predicción con método de Taylor
%     * Evaluación + Corrector: refina con Adams-Moulton 2 pasos
%   - Grafica la solución aproximada

f = @(t,x) (2 +3*cos(x*t^2));
x0 = 1;
intervalo = [0,2];
N = 400; 
h = (intervalo(2)-intervalo(1))/N;

t =linspace(intervalo(1),intervalo(2),N)'; %vector columna

%metodo taylor 
m_taylor = @(ti,xi) (xi + h*f(ti,xi) + (h^2)/2*((-6)*ti*xi*sin(xi*ti^2)-3*(ti^2)*f(ti,xi)));

x(1) = x0;
x(2) = m_taylor(t(1),x(1));

vf = [f(t(1),x(1)), f(t(2),x(2))]; %vf(1) = f_i; vf(2) = f_(i+1)


for i = 1:(N-2)

    %Prediccion x_(i+2)
    x(i+2) = m_taylor(t(i+1),x(i+1));

    %evaluacion + correcion
    x(i+2) = x(i+1) + (h/12)*(5*f(t(i+2),x(i+2)) + 8*vf(2)-vf(1));
    vf(1) = vf(2);
    vf(2) = f(t(i+2),x(i+2)); 
end

figure;
plot(t,x);

%hold on;
%[t,y] = ode45(f,t,x0);
%plot(t,y);



