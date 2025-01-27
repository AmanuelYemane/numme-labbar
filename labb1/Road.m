%format long

% a)

% Anynoma funktioner för varje punkt
P = {
    @(X) [(X(1) - 175)^2 + (X(2) - 950)^2 - 60^2; (X(1) - 160)^2 + (X(2) - 1008)^2 - 45^2];
    @(X) [(X(1) - 410)^2 + (X(2) - 2400)^2 - 75^2; (X(1) - 381)^2 + (X(2) - 2500)^2 - 88^2];
    @(X) [(X(1) - 675)^2 + (X(2) - 1730)^2 - 42^2; (X(1) - 656)^2 + (X(2) - 1760)^2 - 57^2]
    };

% Anonyma funktioner för Jakobianen till varje funktion
J = {
    @(X) [2*X(1) - 350, 2*X(2) - 1900; 2*X(1) - 320, 2*X(2) - 2016];
    @(X) [2*X(1) - 820, 2*X(2) - 4800; 2*X(1) - 762, 2*X(2) - 5000];
    @(X) [2*X(1) - 1350, 2*X(2) - 3460; 2*X(1) - 1312, 2*X(2) - 3520]
    };

% Startgissningar
X = {
    [200;1000];
    [1000;1000];
    [1000;1000]
    };


% P1
tol = 1e-5; hnorm = 1; iter = 0; maxiter = 20;

for i=1:3
    hnorm = 1; iter = 0;
    disp("For P" + i + ":")
    while hnorm > tol && iter < maxiter
        iter = iter + 1;
        h = -J{i}(X{i})\P{i}(X{i});
        X{i} = X{i} + h;
        hnorm = norm(h);
        disp([iter X{i}(1) X{i}(2) hnorm]);
    end
end

% Svara på frågor

% b)
% Vi får P0=(0,0), P1=(205,1002), P2=(458,2458), P3=(641,1750), P4=(1020,0)

% Anonym funktion för den naiva ansatsen
p = @(c, x) c(1) + c(2)*x + c(3)*x.^2 + c(4)*x.^3 + c(5)*x.^4;

x = [0, 205, 458, 641, 1020]';
y = [0, 1002, 2458, 1750, 0]';

% Matris A
A = [ones(size(x)) x x.^2 x.^3 x.^4];

c = A\y;

% Get some x values in the interval (0, 1020)
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

