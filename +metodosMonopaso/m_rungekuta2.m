% =========================================================================
% Descripcion: Funcion que implementa la familia de metodos de Runge-Kutta 
% de dos etapas y orden dos definidos por la formula iterativa:
%
% x_{i+1} = x_i + h * ( (1-a)*f(t_i + h*b, x_i) + ...
%             a*f(t_i + h*(1 - 2*(1-a)*b)/(2*a), x_i + (h/(2*a))*f(t_i + h*b, x_i)) )
% =========================================================================

function [t, x] = m_rungekuta2(f, intervalo, x0, N, a, b)
    % Generacion del vector temporal (N subintervalos implican N+1 nodos)
    t = linspace(intervalo(1), intervalo(2), N+1)';
    h = (intervalo(2) - intervalo(1)) / N;
    
    % Preasignacion de memoria para el vector solucion
   
    x(1,:) = x0;

    % Bucle de iteracion del metodo Runge-Kutta
    for i = 1:N
        % Evaluacion de la primera etapa
        eval_1 = f(t(i) + h*b, x(i,:));
        
        % Evaluacion de la segunda etapa
        t_eval2 = t(i) + h * (1 - 2*(1-a)*b) / (2*a);
        x_eval2 = x(i,:) + (h/(2*a)) * eval_1';
        eval_2 = f(t_eval2, x_eval2);
        
        % Calculo del siguiente nodo
        x(i+1,:) = x(i,:) + h * ((1-a)*eval_1' + a*eval_2');
    end
end