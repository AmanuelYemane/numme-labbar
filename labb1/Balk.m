clear all

H = 0.5;
tol = 1e-8; % Given tolerans
t = 4; % Startgissning

f = @(t) 8*exp(-(t/2))*cos(3*t) - H; % f(t) = 0
fp = @(t) -4*exp(-(t/2))*cos(3*t) - 24*exp(-(t/2))*sin(3*t);

difft = 1; iter = 0; maxiter = 100;

% a)

% Newton's method
while difft > tol && iter < maxiter
    iter = iter + 1; % Increase num of iterarions
    tnew = t-f(t)/fp(t); % Update with Newton's method
    difft = abs(tnew - t); % |t(n+1)-t(n)|
    t = tnew; % Assign new t
    disp([iter tnew difft]) % Display
end

% b)

% Sekantmetoden