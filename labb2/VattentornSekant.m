function Sh = sekant(f, beta, N, intervall)
    h = (intervall(2)-intervall(1))/N;
    x = intervall(1):h:intervall(2);
    fx = f(x, beta);
    Sh = (h./3)*(fx(1)+4*sum(fx(2:2:end-1))+2*sum(fx(3:2:end-2))+fx(end));
end

% Anonym funktion för integranden
f = @(x, beta) pi.*((exp(beta.*x)+8)./(1+(x./5).^3)).^2;

% Intervall och antalet delintervall
a = 0; b = 20;
intervall = [a b];
N = 1280;

% F(beta)
F = @(beta) sekant(f, beta, N, intervall) - 1500;

tol = 10e-8;

betaOld = 0.1; % beta0
beta = 0.15; % beta1

diffBeta = 1; iter = 0; maxiter = 100;

diff = []; % Initialisera tom array

% Sekantmetoden
while diffBeta > tol && iter < maxiter
    iter = iter + 1; % Inkrementera antalet iterationer
    betaNew = beta-F(beta)*(beta-betaOld)/(F(beta)-F(betaOld)); % Sekantmetoden
    diffBeta = abs(betaNew-beta); % |t(n+1)-t(n)|
    betaOld = beta; % Uppdatera betaOld
    beta = betaNew; % Uppdatera beta
    disp([iter betaNew diffBeta]) % Display
    diff = [diff; diffBeta]; % Lägg till diffBeta i arrayen
end