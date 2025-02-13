% a) Vi verifierade att (5) är en lösning till (4) genom att derivera (5)
% med avseende på t, och därefter konstatera att denna derivata är lika
% med sin(3t)-2y enligt (4)

% b) c)
function eulerFram(n, T, exactSol, place)
    f = @(t, y) sin(3.*t) - 2.*y;
    t = 0;
    intervall = [t T];
    y = 1.2; % Begynnelsevärde (t=0)
    tvalues = zeros(n+1, 1); yvalues = zeros(n+1, 1);
    tvalues(1) = t; yvalues(1) = y;
    h = (intervall(2)-intervall(1))/n;
    for i = 1:n
        y = y+h*f(t, y);
        t = t+h;
        tvalues(i+1) = t;
        yvalues(i+1) = y;
    end
    if T == 8
        diff = abs(yvalues(n+1) - exactSol(T));
        figure(2)
        loglog(h, diff, 'o')
        hold on
        disp("n = " + n + ": " + diff)
        
        figure(1)
        plot(tvalues, yvalues, 'o', 'LineWidth', 1.5)
        hold on
    else 
        figure(5)
        subplot(2, 2, place)
        plot(tvalues, yvalues, 'o', 'LineWidth', 1.5)
        xlabel("t")
        ylabel("y")
        hold on
        tvals = linspace(0, 80, 1000);
        plot(tvals, exactSol(tvals), '-', 'LineWidth', 1.5)
        legend(sprintf('n = %d', n), 'Analytisk lösning')
        hold on
    end
end

exactSol = @(t) 93/65.*exp((-2).*t) - 3/13.*cos(3.*t) + 2/13.*sin(3.*t);

disp('Felet för framåt Euler:')
eulerFram(50, 8, exactSol, 0)
eulerFram(100, 8, exactSol, 0)
eulerFram(200, 8, exactSol, 0)
eulerFram(400, 8, exactSol, 0)

figure(1)
tvals = linspace(0, 8, 100);
title("Lösning av systemet med framåt Euler på intervallet [0,8] för olika värden på n")
xlabel("t")
ylabel("y")
plot(tvals, exactSol(tvals), '-', 'LineWidth', 1.5)
legend('n = 50', 'n = 100', 'n = 200', 'n = 400', 'Analytisk lösning')

figure(2)
title('Felet i slutpunkten med framåt Euler för olika n')
xlabel('h')
ylabel('Felet e(h)')
legend('n = 50', 'n = 100', 'n = 200', 'n = 400')

figure(5)
sgtitle('Numerisk lösning av systemet med framåt Euler på intervallet [0,80] för olika n')


% När n ökar kommer den approximativa lösningen allt närmare den
% analytiska lösningen


% Vi använder en logaritmisk skala för att plotta varje eh och utgår från 
% formeln e(h) ≈ ch^(p). Eftersom grafen plottas med logaritmiska axlar 
% kommer en linje som har formen log(e(h))≈p*log(h)+log(c) plottas. Grafen 
% som plottas är linjär, där p är lutningen på linjen, och den kan tydligt 
% avläsas till 1. Därmed har p värdet 1 och metoden framåt Euler har 
% noggrannhetsordning 1. På samma sätt får vi även noggranhetsordningen för
% bakåt Euler till 1.

% Vi kan också komam fram till detta värde på p genom att undersöka kvoten 
% e(h)/e(h/2). Kvoten har ungefär värdet 2 för alla testvärden på h.
% Enligt definitionen av noggranhetesordning är e(h)/e(h/2) ≈ 2^p, därmed
% är p = 1.

% d)

function eulerBak(n, T, exactSol, place)
    f = @(t, y) sin(3.*t) - 2.*y;
    t = 0;
    intervall = [t T];
    y = 1.2; % Begynnelsevärde (t=0)
    tvalues = zeros(n+1, 1); yvalues = zeros(n+1, 1);
    tvalues(1) = t; yvalues(1) = y;
    h = (intervall(2)-intervall(1))/n;
    for i = 1:n
        y = (y+h*sin(3*(t+h)))/(1+2*h); % Euler bakåt efter löst ekvation
        t = t+h;
        tvalues(i+1) = t;
        yvalues(i+1) = y;
    end

    if T == 8
        diff = abs(yvalues(n+1) - exactSol(T));
        figure(4)
        disp("h = " + h + ", diff = " + diff)
        plot(h, diff, 'o')
        hold on
        disp("n = " + n + ": " + diff)
        
        figure(3)
        plot(tvalues, yvalues, 'o', 'LineWidth', 1.5)
        hold on
    else 
        figure(6)
        subplot(2, 2, place)
        plot(tvalues, yvalues, 'o', 'LineWidth', 1.5)
        xlabel("t")
        ylabel("y")        
        hold on
        tvals = linspace(0, 80, 1000);
        plot(tvals, exactSol(tvals), '-', 'LineWidth', 1.5)
        legend(sprintf('n = %d', n), 'Analytisk lösning')
        hold on
    end

end

disp('Felet för bakåt Euler:')
eulerBak(50, 8, exactSol, 0)
eulerBak(100, 8, exactSol, 0)
eulerBak(200, 8, exactSol, 0)
eulerBak(400, 8, exactSol, 0)

figure(3)
plot(tvals, exactSol(tvals), '-', 'LineWidth', 1.5)
title("Lösning av systemet med bakåt Euler på intervallet [0,8] för olika värden på n")
xlabel("t")
ylabel("y") 
legend('n = 50', 'n = 100', 'n = 200', 'n = 400', 'Analytisk lösning')

figure(4)
title('Felet i slutpunkten med bakåt Euler för olika n')
xlabel('h')
ylabel('Felet e(h)')
legend('n = 50', 'n = 100', 'n = 200', 'n = 400')

figure(6)
sgtitle('Numerisk lösning av systemet med bakåt Euler på intervallet [0,80] för olika n')

% e)

eulerFram(50, 80, exactSol, 1)
eulerFram(100, 80, exactSol, 2)
eulerFram(400, 80, exactSol, 3)
eulerFram(800, 80, exactSol, 4)


% f)

eulerBak(50, 80, exactSol, 1)
eulerBak(100, 80, exactSol, 2)
eulerBak(400, 80, exactSol, 3)
eulerBak(800, 80, exactSol, 4)