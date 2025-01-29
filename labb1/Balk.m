clear all

format long

% a)

H = 0.5;
tol = 1e-8; % Given tolerans
t = 4.3; % Startgissning t0

f = @(t) 8.*exp(-(t./2)).*cos(3.*t) - H; % f(t) = 0
fp = @(t) -4.*exp(-(t./2)).*cos(3.*t) - 24.*exp(-(t./2)).*sin(3.*t);

% Plota funktionen för att se nollställen och välja startgissningar
figure
tv = linspace(0, 10, 100);
plot(tv, f(tv), 'r', 'LineWidth', 1.5)
grid on


difft = 1; iterN = 0; maxiter = 100;

diffN = [];

disp("H=0.5, Netons metod:")

% Newtons metod
while difft > tol && iterN < maxiter
    iterN = iterN + 1; % Inkrementera antalet iterationer
    tnew = t-f(t)/fp(t); % Newtons metod
    difft = abs(tnew - t); % |t(n+1)-t(n)|
    t = tnew; % Uppdatera t
    disp([iterN tnew difft]) % Display
    diffN = [diffN; difft]; % Lägg till difft i arrayen
end

% Svar på frågor
%
% Med startvärdet 4.3 krävdes 5 iterationer och svaret blev ~4.5

% b)

told = 4.2; % t0
t = 4.3; % t1

difft = 1; iterS = 0; maxiter = 100;

diffS = []; % Initialisera tom array

disp("H=0.5, sekantmetoden:")

% Sekantmetoden
while difft > tol && iterS < maxiter
    iterS = iterS + 1; % Inkrementera antalet iterationer
    tnew = t-f(t)*(t-told)/(f(t)-f(told)); % Sekantmetoden
    difft = abs(tnew - t); % |t(n+1)-t(n)|
    told = t; % Uppdatera told
    t = tnew; % Uppdatera t
    disp([iterS tnew difft]) % Display
    diffS = [diffS; difft]; % Lägg till difft i arrayen
end

% Svar på frågor:
%
% Med startvärden t0=4.2 och t1=4.3 krävdes 6 iterationer och resultatet
% blev ~4.5. Med de valda startvärdena krävde Newtons metod färre
% iterationer än sekantmetoden. Anledningen till detta är att Newtons metod
% generellt har en högre konvergenshastighet. Newtons metod konvergerar
% kvadratiskt medan sekantmetoden konvergerar superlinjärt.

% c)

figure
semilogy(1:iterN, diffN, '-bo', 'LineWidth', 1.5)
hold on
semilogy(1:iterS, diffS, '-ro', 'LineWidth', 1.5)
xlabel('Antalet iterationer (n)')
ylabel('Differensen i t')
title('Konvergensen av Newtons metod och sekantmetoden')
grid on
legend('Newtons metod', 'Sekantmetoden', 'Location', 'Best')

% d)

H = 2.8464405473;
t = 2.0; % Startgissning t0

f = @(t) 8.*exp(-(t./2)).*cos(3.*t) - H; % f(t) = 0

difft = 1; iterN = 0; maxiter = 100;

diffN = [];

disp("H=2.8464405473, Newtons metod:")

% Newtons metod
while difft > tol && iterN < maxiter
    iterN = iterN + 1; % Inkrementera antalet iterationer
    tnew = t-f(t)/fp(t); % Newtons metod
    difft = abs(tnew - t); % |t(n+1)-t(n)|
    t = tnew; % Uppdatera t
    disp([iterN tnew difft]) % Display
    diffN = [diffN; difft]; % Lägg till difft i arrayen
end

figure
semilogy(1:iterN, diffN, '-bo', 'LineWidth', 1.5)
xlabel('Antalet iterationer (n)')
ylabel('Differensen i t')
title('Konvergensen av Newtons metod')
grid on
legend('Newtons metod', 'Location', 'Best')

% Svar på frågor:
%
% T≈2.04. Konvergenshastighet är betydligt lägre för detta värde på H, då metoden
% verkar konvergera linjärt snarare än kvadratiskt. Anledningen till att 
% metoden beter sig annorlunda för detta värde på H är att funktionen f(t) 
% har en lokal maximipunkt i det sökta nollstället. På grund av det kommer 
% både f(t) och f'(t) vara väldigt små i närheten av nollstället vilket 
% kommer göra att Newtons metod tappar i fart då ökningen i t (-f(t)/f'(t)) 
% blir väldigt liten. Metoden kommer därför ta väldigt korta steg, vilket kommer 
% göra att den kräver fler iterationer och konvergerar linjärt snarare än 
% kvadratiskt. Vad gäller känsligheten för valet av startvärdet skiljer sig 
% metoden från a) på så sätt att den tål en större felmarginal. 
% Det beror på att avståndet till övriga nollställen är större för denna
% funktion samt att avståndet är längre till funktionens närmsta
% extrempunkt där derivatan kommer ändras drastiskt och göra att metoden
% konvergerar mot en annan punkt.