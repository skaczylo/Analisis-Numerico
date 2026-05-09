% --- FICHERO datos.m ---
f = @(t,x) [-0.1*x(1)+2*x(2);-2*x(1)-0.1*x(2)];
intervalo = [0, 10];
x0 = [0, 1];
N = 1000;
sol_exacta = @(t) [exp(-0.1.*t).*sin(2*t), exp(-0.1.*t).*cos(2.*t)];

