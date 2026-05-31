function comp2solexac(metodo)
    % COMP2SOLEXAC Compara un método numérico con la solución exacta

    clc;
    close all;
    
    datos; 
    
    % Comprobación de seguridad: vemos si sol_exacta existe en datos.m
    if ~exist('sol_exacta', 'var')
        error('Para usar esta función, debes definir "sol_exacta" en tu archivo datos.m');
    end
    
   
    [t,x_metodo] = metodo(f,intervalo,x0,N);
    x_exac = sol_exacta(t);

    n = size(x0,2);
   
    if n == 1
        % --- CASO ESCALAR ---
        figure;
        plot(t, x_exac, 'k', 'LineWidth', 1.5); hold on; % Exacta en negro
        plot(t, x_metodo, 'r--', 'LineWidth', 1.5);       % Aproximada en rojo discontinuo
        title('Solución: Exacta vs Aproximada');
        legend('Exacta', 'Aproximada'); grid on;
        
        pause(1); % Pausa automática de 1 segundo
        
        figure;
        plot(t, abs(x_exac - x_metodo), 'm', 'LineWidth', 1.5); % Error en magenta
        title('Diferencia (Error de la aproximación)'); 
        xlabel('t'); ylabel('Error Absoluto'); grid on;
        
    else
        % ---CASO EN R^2 o R^3 ---
        % Figura 1: Componentes
        figure;
        for i = 1:n
            subplot(n, 1, i);
            plot(t, x_exac(:,i), 'k', 'LineWidth', 1.5); hold on;
            plot(t, x_metodo(:,i), 'r--', 'LineWidth', 1.5);
            title(['Componente x_', num2str(i), '(t)']);
            legend('Exacta', 'Aprox'); grid on;
        end
        
        pause(1);
        
        % Figura 2: Diferencia por componentes
        figure;
        for i = 1:n
            subplot(n, 1, i);
            plot(t, abs(x_exac(:,i) - x_metodo(:,i)), 'm', 'LineWidth', 1.5);
            title(['Diferencia (Error) en componente x_', num2str(i)]); 
            xlabel('t'); grid on;
        end
        
        pause(1);
        
        % Figura 3: Trayectorias
        figure;
        if n == 2
            plot(x_exac(:,1), x_exac(:,2), 'k', 'LineWidth', 1.5); hold on;
            plot(x_metodo(:,1), x_metodo(:,2), 'r--', 'LineWidth', 1.5);
            xlabel('x_1'); ylabel('x_2');
        else % n == 3
            plot3(x_exac(:,1), x_exac(:,2), x_exac(:,3), 'k', 'LineWidth', 1.5); hold on;
            plot3(x_metodo(:,1), x_metodo(:,2), x_metodo(:,3), 'r--', 'LineWidth', 1.5);
            xlabel('x_1'); ylabel('x_2'); zlabel('x_3');
        end
        title('Trayectorias: Exacta vs Aproximada');
        legend('Exacta', 'Aproximada'); grid on;
    end
    
    % Calculamos el máximo error absoluto cometido en toda la simulación
    error_max = max(max(abs(x_exac - x_metodo)));
    
    fprintf('\n-------------------------------------------------\n');
    fprintf(' Análisis del Error del método\n');
    fprintf('-------------------------------------------------\n');
    fprintf(' Norma Infinito (Error Máximo Global): %e\n', error_max);
    fprintf('-------------------------------------------------\n');

end
