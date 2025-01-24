clear all

load STHLMTEMP

% Constant
k = 2*pi/365;

% Number of collected data 
n = length(Tdm);
% Timevector (days)
t = (1:n)';

% For model 1
% Anonymous function for the model
model1 = @(c, t) c(1) + c(2)*sin(k*t) + c(3)*cos(k*t) + c(4)*sin(2*k*t) + c(5)*cos(2*k*t);
% Construct matrix 1
A1 = [ones(n, 1), sin(k*t), cos(k*t), sin(2*k*t), cos(2*k*t)];
% Get c with Least squares (Minstakvadratmetoden), we have A1c = Tdm, 
% so we solve the normal equations (A1')A1c=(A1')Tdm with 
% c = A1'*A1\(A1'*Tdm), which is basically the same as
c = A1\Tdm;
% Differance between the measured data points and the adjusted temperature
residuals1 = Tdm - model1(c, t); % Same as Tdm - A1 * c;
% Square the residual
least_squares_sum1 = sum(residuals1.^2);

% For model 2
% Anonymous function for the model
model2 = @(a, t) a(1) + a(2)*t + a(3)*t.^2 + a(4)*sin(k*t) + a(5)*cos(k*t) + a(6)*sin(2*k*t) + a(7)*cos(2*k*t);
% Construct matrix 2
A2 = [ones(n, 1), t, t.^2, sin(k*t), cos(k*t), sin(2*k*t), cos(2*k*t)];
% Get 'a' with Least squares (Minstakvadratmetoden)
a = A2\Tdm;
% Differance between the measured data points and the adjusted temperature
residuals2 = Tdm - model2(a, t); 
% Square the residual
least_squares_sum2 = sum(residuals2.^2);

% Model values
c0 = c(1);
c1 = c(2);
c2 = c(3);
c3 = c(4);
c4 = c(5);

% Create figure
figure;

% Plot model 1
subplot(2, 2, 1) % Divide the figure into 2x2 grid and plot in first square
plot(t, Tdm, '.', 'LineWidth', 1.5) % Plot each data point with a bullet
hold on
plot(t, model1(c, t), 'b', 'LineWidth', 1.5) % Plot the data points in a blue line
legend('Uppmätta temperaturer', 'Anpassad modell', 'Location', 'Best')
xlabel('Tid (dagar)')
ylabel('Temperatur (grader)')
title('Model 1')
grid on

% Plot model 2
subplot(2,2,2)
plot(t, Tdm, '.', 'LineWidth', 1.5)
hold on
plot(t, model2(a, t), 'r', 'LineWidth', 1.5) % Plot the data points in a red line
legend('Uppmätta temperaturer', 'Anpassad modell', 'Location', 'Best')
xlabel('Tid (dagar)')
ylabel('Temperatur (grader)')
title('Model 2')
grid on

% Plot residual 1
subplot(2, 2, 3)
plot(t, residuals1, '.', 'LineWidth', 1.5)
xlabel('Tid (dagar)')
ylabel('Residual (grader)')
title('Residualer1: Tdm - Tmod1')
grid on

% Plot residual 2
subplot(2, 2, 4)
plot(t, residuals2, '.', 'LineWidth', 1.5)
xlabel('Tid (dagar)')
ylabel('Residual (grader)')
title('Residualer2: Tdm - Tmod2')
grid on

disp("minstakvadratsumman modell 1 = " + least_squares_sum1);
disp("minstakvadratsumman modell 2 = " + least_squares_sum2);

% e) 

