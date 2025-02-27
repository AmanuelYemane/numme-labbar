format long

f = @(x, beta) pi.*((exp(beta.*x)+8)./(1+(x./5).^3)).^2;

a = 0; b = 20;
N = 100;
h = (b-a)/N;

beta = 0.2;

for i = 1:7
    x = a:h:b;
    fx = f(x, beta);

    % Trapetsregeln
    Th(i) = h*(sum(fx)-0.5*(fx(1)+fx(end)));
    
    % Simpsons metod
    Sh(i) = (h./3)*(fx(1)+4*sum(fx(2:2:end-1))+2*sum(fx(3:2:end-2))+fx(end));

    h = h/2;
end

disp(['Integralvärdet Th ≈ ', num2str(Th)])
disp(['Integralvärdet Sh ≈ ', num2str(Sh)])

kvotTh = abs(Th(2:end-1)-Th(1:end-2))./abs(Th(3:end)-Th(2:end-1));
kvotSh = abs(Sh(2:end-1)-Sh(1:end-2))./abs(Sh(3:end)-Sh(2:end-1));
disp('Kvot Th: '); disp(kvotTh');
disp('Kvot Sh: '); disp(kvotSh');

