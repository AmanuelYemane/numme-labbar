% a) Vi verifierade att (5) är en lösning till differentialekvationen (4)
% genom att verifiera att den uppfyller begynnelsevillkoret

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
        hold on
        tval = linspace(0, 80, 1000);
        plot(tval, exactSol(tval), '-', 'LineWidth', 1.5)
        hold on
    end
end

exactSol = @(t) 93/65.*exp((-2).*t) - 3/13.*cos(3.*t) + 2/13.*sin(3.*t);

eulerFram(50, 8, exactSol, 0)
eulerFram(100, 8, exactSol, 0)
eulerFram(200, 8, exactSol, 0)
eulerFram(400, 8, exactSol, 0)

tval = linspace(0, 8, 400);
plot(tval, exactSol(tval), '-', 'LineWidth', 1.5)

% När n ökar kommer den approximativa lösningen allt närmare den
% analytiska lösningen

% Svara på frågan om noggrannhetsordning

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
        loglog(h, diff, 'o')
        hold on
        disp("n = " + n + ": " + diff)
        
        figure(3)
        plot(tvalues, yvalues, 'o', 'LineWidth', 1.5)
        hold on
    else 
        figure(6)
        subplot(2, 2, place)
        plot(tvalues, yvalues, 'o', 'LineWidth', 1.5)
        hold on
        tval = linspace(0, 80, 1000);
        plot(tval, exactSol(tval), '-', 'LineWidth', 1.5)
        hold on
    end

end

eulerBak(50, 8, exactSol, 0)
eulerBak(100, 8, exactSol, 0)
eulerBak(200, 8, exactSol, 0)
eulerBak(400, 8, exactSol, 0)

plot(tval, exactSol(tval), '-', 'LineWidth', 1.5)

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