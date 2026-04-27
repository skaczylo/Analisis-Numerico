% --- FICHERO datos.m ---

f = @(t,x) [ x(2) ; -9*x(1) + 8*sin(t) ];
intervalo = [0, 2*pi];
x0 = [0, 4];
N = 1000;

