% --- SCRIPT graficas.m ---


n = size(x, 2); 

if n == 1
    % I) CASO ESCALAR (1 ecuación)
    figure; % Abre ventana
    plot(t, x, 'r', 'LineWidth', 1.5); % Color rojo
    xlabel('t'); ylabel('x(t)');
    title('Solución del problema escalar');
    grid on;

elseif n == 2
    % II) CASO EN R^2 (2 ecuaciones)
    % Gráfica de las componentes
    figure; %abre nueva ventana y dibuja
    subplot(2,1,1); 
    plot(t, x(:,1), 'r', 'LineWidth', 1.5); % Componente 1 en rojo
    title('Componente x_1(t)'); grid on;
    
    subplot(2,1,2); 
    plot(t, x(:,2), 'g', 'LineWidth', 1.5); % Componente 2 en verde
    title('Componente x_2(t)'); grid on;
    
    pause(2); 
    
    % Trayectoria (Plano de fase)
    figure; %abre nueva ventana y dibuja
    plot(x(:,1), x(:,2), 'r', 'LineWidth', 1.5); % Trayectoria en rojo
    xlabel('x_1'); ylabel('x_2');
    title('Trayectoria (Plano de fase)'); grid on;

elseif n == 3
    % CASO EN R^3 (3 ecuaciones, como el sistema de Lorenz)
    figure;
    subplot(3,1,1); plot(t, x(:,1), 'r'); title('Componente x_1(t)');
    subplot(3,1,2); plot(t, x(:,2), 'g'); title('Componente x_2(t)');
    subplot(3,1,3); plot(t, x(:,3), 'b'); title('Componente x_3(t)');
    
    pause(2);
    
    % Trayectoria en 3D
    figure;
    plot3(x(:,1), x(:,2), x(:,3), 'r'); % plot3 para dibujos en 3D
    xlabel('x_1'); ylabel('x_2'); zlabel('x_3');
    title('Trayectoria en 3D'); grid on;
end


