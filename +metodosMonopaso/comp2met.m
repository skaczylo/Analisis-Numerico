function comp2met(met1, met2)
    % COMP2MET Compara dos métodos numéricos visual y numéricamente
    
    clc;
    close all;
    
 
    datos; 
    
    % Ejecutar ambos métodos
    [t1, x1] = met1(f, intervalo, x0, N);
    [t2, x2] = met2(f, intervalo, x0, N);
    
    n = size(x1, 2); % Número de ecuaciones
    
    if n == 1
        % --- CASO ESCALAR ---
        figure;
        plot(t1, x1, 'r', 'LineWidth', 1.5); hold on;
        plot(t2, x2, 'b--', 'LineWidth', 1.5); % 'b--' es azul discontinuo
        legend('Método 1', 'Método 2');
        title('Comparación de Soluciones (Escalar)'); grid on;
        
        pause;
        
        % Figura 2: Diferencia (Error entre ellos)
        figure;
        plot(t1, abs(x1 - x2), 'k', 'LineWidth', 1.5);
        title('Diferencia absoluta entre métodos'); grid on;
        
    else
        % --- CASO R2 o R3 ---
        % Figura 1: Componentes (Subplots)
        figure;
        for i = 1:n
            subplot(n, 1, i);
            plot(t1, x1(:,i), 'r', 'LineWidth', 1.5); hold on;
            plot(t2, x2(:,i), 'b--', 'LineWidth', 1.5);
            title(['Componente x_', num2str(i)]);
            legend('Met 1', 'Met 2'); grid on;
        end
        
        pause;
        
        % Figura 2: Diferencia por componentes
        figure;
        for i = 1:n
            subplot(n, 1, i);
            plot(t1, abs(x1(:,i) - x2(:,i)), 'k');
            title(['Diferencia en x_', num2str(i)]); grid on;
        end
        
        pause;
        
        % Figura 3: Trayectorias
        figure;
        if n == 2
            plot(x1(:,1), x1(:,2), 'r', 'LineWidth', 1.5); hold on;
            plot(x2(:,1), x2(:,2), 'b--', 'LineWidth', 1.5);
            xlabel('x_1'); ylabel('x_2');
        else % n == 3
            plot3(x1(:,1), x1(:,2), x1(:,3), 'r'); hold on;
            plot3(x2(:,1), x2(:,2), x2(:,3), 'b--');
            xlabel('x_1'); ylabel('x_2'); zlabel('x_3');
        end
        title('Comparación de Trayectorias'); legend('Met 1', 'Met 2'); grid on;
    end
    
    % --- CÁLCULO DE LA NORMA INFINITO ---
    % La diferencia máxima absoluta entre todos los puntos y todas las componentes
    error_max = max(max(abs(x1 - x2)));
    fprintf('\n--------------------------------------------\n');
    fprintf('Comparación finalizada.\n');
    fprintf('Norma Infinito de la diferencia: %e\n', error_max);
    fprintf('--------------------------------------------\n');

end