clear all

format long

% a)

H = 0.5;
tol = 1e-8; % Given tolerans
t = 4.3; % Startgissning t(0)

f = @(t) 8*exp(-(t/2))*cos(3*t) - H; % f(t) = 0
fp = @(t) -4*exp(-(t/2))*cos(3*t) - 24*exp(-(t/2))*sin(3*t);

difft = 1; iterN = 0; maxiter = 100;

diffN = [];

% Newton's Method
while difft > tol && iterN < maxiter
    iterN = iterN + 1; % Increase num of iterarions
    tnew = t-f(t)/fp(t); % Update with Newton's Method
    difft = abs(tnew - t); % |t(n+1)-t(n)|
    t = tnew; % Assign new t
    %disp([iterN tnew difft]) % Display
    diffN = [diffN; difft]; % add difft to the array
end

% Svar på frågor:

% b)

% Secant Method

told = 4.6; % t(0)
t = 4.3; % t(1)

difft = 1; iterS = 0; maxiter = 100;

diffS = []; % Initialize empty array

while difft > tol && iterS < maxiter
    iterS = iterS + 1; % Increase num of iterarions
    tnew = t-f(t)*(t - told)/(f(t)-f(told)); % Update with the Secant Method
    difft = abs(tnew - t); % |t(n+1)-t(n)|
    told = t; % Assign new told
    t = tnew; % Assign new t
    %disp([iterS tnew difft]) % Display
    diffS = [diffS; difft]; % add difft to the array
end

% Svar på frågor:

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
t = 2; % Startgissning t(0)

f = @(t) 8*exp(-(t/2))*cos(3*t) - H; % f(t) = 0

difft = 1; iterN = 0; maxiter = 100;

diffN = [];

% Newton's Method
while difft > tol && iterN < maxiter
    iterN = iterN + 1; % Increase num of iterarions
    tnew = t-f(t)/fp(t); % Update with Newton's Method
    difft = abs(tnew - t); % |t(n+1)-t(n)|
    t = tnew; % Assign new t
    disp([iterN tnew difft]) % Display
    diffN = [diffN; difft]; % add difft to the array
end

figure
semilogy(1:iterN, diffN, '-bo', 'LineWidth', 1.5)
xlabel('Antalet iterationer (n)')
ylabel('Differensen i t')
title('Konvergensen av Newtons metod')
grid on
legend('Newtons metod', 'Location', 'Best')

% Svar på frågor: