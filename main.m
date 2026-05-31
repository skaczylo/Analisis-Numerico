% El método RK2 admite dos parámetros (a,b) que definen la variante de la
% familia; los fijamos al pasarlo como handle de 4 argumentos a testmet.
testmet(@(f,intervalo,x0,N) metodosMonopaso.m_rungekuta2(f,intervalo,x0,N,1,4));