%Graficas

n = size(x,2);

if n == 1
    figure;
    plot(t,x);
elseif n ==2
    figure(1);
    subplot(2,1,1);
    plot(t,x(:,1));
    xlabel('t');
    ylabel('x_1(t)');

    subplot(2,1,2);
    plot(t,x(:,2));
    xlabel('t');
    ylabel('x_2(t)');
    
    pause(4);
    figure(2);
    plot(x(:,1),x(:,2));
    xlabel('x_1(t)');
    ylabel('x_2(t)');

end



