format long

% a)

% Anynoma funktioner för varje punkt
P = {
    @(X) [(X(1) - 175)^2 + (X(2) - 950)^2 - 60^2; (X(1) - 160)^2 + (X(2) - 1008)^2 - 45^2];
    @(X) [(X(1) - 410)^2 + (X(2) - 2400)^2 - 75^2; (X(1) - 381)^2 + (X(2) - 2500)^2 - 88^2];
    @(X) [(X(1) - 675)^2 + (X(2) - 1730)^2 - 42^2; (X(1) - 656)^2 + (Xk(2) - 1760)^2 - 57^2]
    };

% Anonyma funktioner för Jacobianen till varje vektorvärd funktion P(i)
J = {
    @(X) [2*X(1) - 350, 2*X(2) - 1900; 2*X(1) - 320, 2*X(2) - 2016];
    @(X) [2*X(1) - 820, 2*X(2) - 4800; 2*X(1) - 762, 2*X(2) - 5000];
    @(X) [2*X(1) - 1350, 2*X(2) - 3460; 2*X(1) - 1312, 2*X(2) - 3520]
    };

% Startgissningar
X = {
    [200;1000]; % P1
    [400;2600]; % P2
    [670;1780] % P3
    };

tol = 1e-8; hnorm = 1; iter = 0; maxiter = 20;

for i=1:3
    hnorm = 1; iter = 0;
    disp("For P" + i + ":")
    while hnorm > tol && iter < maxiter
        iter = iter + 1;
        h = -J{i}(X{i})\P{i}(X{i}); % Newtons metod för system
        X{i} = X{i} + h;
        hnorm = norm(h);
        disp([iter X{i}(1) X{i}(2) hnorm]);
    end
end

% Svar på frågor
%
% Koordinaterna blir P1≈(205,1002), P2≈(458,2458), P3≈(712,1750).
% Vi kan veta att Newtons metod konvergerar som den ska eftersom vi har
% valt startgissningar som bör ligga i närheten av de sökta punkterna
% (efter uppritning och analys av cirklarna). Vi vet också att Jacobianen 
% för respektive P måste vara inverterbar för varje n, dvs detJ≠0 i varje
% iteration, vilket vi på förhand inte kan vara säkra på då det finns
% värden på X(1) och X(2) som gör att detJ=0. Men i och med att de punkter
% som metoden konvergerar mot stämmer överens med förväntningarna på de
% sökta punkterna kan vi anta att detJ≠0 för alla iterationer och att
% Newtons metod därmed konvergerar som den ska. För att försäkra sig
% ytterligare kan en kontroll implementeras som i varje iteration kollar
% att detJ faktiskt är skiljt från 0, men det är inte nödvändigt i det här
% fallet. Konvergenshastigheten är kvadratisk för varje punkt.

% b)

% Anonym funktion för den naiva ansatsen
p = @(c, x) c(1) + c(2)*x + c(3)*x.^2 + c(4)*x.^3 + c(5)*x.^4;

x = [0, X{1}(1), X{2}(1), X{3}(1), 1020]';
y = [0, X{1}(2), X{2}(2), X{3}(2), 0]';

% Matris A
A = [ones(size(x)) x x.^2 x.^3 x.^4];

c = A\y;

% Ta fram x-värden i intervallet (0, 1020)
xvalues = linspace(x(1), x(end), 100);

figure
plot(xvalues, p(c, xvalues), '-r', 'LineWidth', 1.5)
hold on
plot (x, y, 'ro')
title('Road')
legend('Väg', 'Interpolationspunkter', 'Location', 'Best')

% Koeffecienterna blir
disp("c0 = " + c(1))
disp("c1 = " + c(2))
disp("c2 = " + c(3))
disp("c3 = " + c(4))
disp("c4 = " + c(5))

% Koefficienterna i polynomet blir:
% c0 = 0, c1 ≈ -0.58, c2 ≈ 0.04, c3 ≈ -8.1e-05, c4 ≈ 4.0e-08

