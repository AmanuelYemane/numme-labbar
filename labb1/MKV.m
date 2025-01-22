clear all

load STHLMTEMP

k = 2*pi/365;

% Number of collected data 
n = length(Tdm);
% Timevector (days
t = (1:n)';

% Konstruct matrix
A = [ones(n, 1), sin(k*t), cos(k*t), sin(2*k*t), cos(2*k*t)];

% Adjusted model with the use of Least squares (Minstakvadratmetoden)
c = A\Tdm;

% Adjusted tempreture temperaturen
T_anp = A * c;

% Differance between the mesured datapoints and the adjusted tempreture
residuals = Tdm - T_anp;
% Square the residual
least_squares_sum = sum(residuals.^2);

% Model values
c0 = c(1);
c1 = c(2);
c2 = c(3);
c3 = c(4);
c4 = c(5);

% Plot
figure;
subplot(2, 1, 1);
plot(t, Tdm, '.', 'LineWidth', 2); % Plot the model in red
hold on;
plot(t, T_anp, 'b', 'LineWidth', 2);   % Plot the data points in blue
legend ('Uppmätta temperaturer', 'Anpassad modell', 'Location', 'Best')
xlabel ('Tid (dagar)')
ylabel ('Temperatur (grader)')
grid on;

% Plot residual
subplot(2, 1, 2);
plot(t, residuals, '.', 'LineWidth', 1.5);
xlabel('Tid (dagar)');
ylabel('Residual (grader)');
title('Residualer: Tdm - Tmod');
grid on;


