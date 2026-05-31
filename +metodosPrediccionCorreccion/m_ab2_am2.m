function [t,x] = m_ab2_am2(f, intervalo,x0,N)
%M_AB2_AM2 
% Queremos implementar el metod de Adams Moulton de 2 pasos
% pero es implicito 
%si hiciesemos x(i+2,:) = x(i+1,:) + (h/12)*(5*f(t(i+2), x(i+2,:)) + 8*f(t(i+1),x(i+1,:)) - f(t(i),x(i,:)))';
% matlab fallaria pues x(i+2,:) no estaría inicializado

%Aplicamos entonces metodo Predictor corrector
%Metodo predictor = Metodo Adams Bashforth de 2 pasos
%x_(i+2) = x_(i+1) + (h/2)*(3*f(t_(i+1),x_(i+1)) - f(t_i,x_i))
%Metodo corrector = Metodo Adams Moulton de 2 pasos
% x_(i+2) = x_(i+1) + h/12(5 f_(i+2) + 8f_(i+1) - f_i)


[t,y] = metodosMonopaso.meulermod(f,intervalo,x0,N);
x(1,:) = y(1,:);
x(2,:) = y(2,:);
h = (intervalo(2)-intervalo(1))/N;

vf(1,:) = f(t(1), x(1,:)); %vf(1) = f_i y vf(2) = f_(i+1)


for i = 1:(N-2)

    vf(2,:) = f(t(i+1),x(i+1,:))';
    %Metodo de prediccion
    x(i+2,:) = x(i+1,:)+ (h/2)*(3*vf(2,:) -  vf(1,:));

    %Evaluacion + Correcion => ya no fallara f_(i+2) pues hemos realizado
    %una prediccion de de x(i+2)
    x(i+2,:) = x(i+1,:) + (h/12)*(5*f(t(i+2),x(i+2,:))' + 8*vf(2,:) -vf(1,:));

    %Evaluacion final para siguiente iteracion
    vf(1,:) = vf(2,:); 

end




