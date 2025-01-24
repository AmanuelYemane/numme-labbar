clear all

H = 0.5;
tol = 1e-8;
t = 4;

e = exp(1); % Euler's number
f = @(t) 8*e.^(-(t/2))*cos(3*t);
fp = @(t) -4*e.^(-(t/2))*cos(3*t) - 24*e.^(-(t/2))*sin(3*t);


difft = 1; iter = 0; maxiter = 100;

while difft > tol && iter < maxiter
    iter = iter + 1; % Increase num of iterarions
    tnew = t-f(t)/fp(t); % Update with newtons
    difft = abs (tnew - t); % |x(n+1)-x(n)|
    t = tnew; % Assign new x
    disp ([iter tnew difft]) % Display
end