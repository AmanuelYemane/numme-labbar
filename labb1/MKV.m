clear all

load STHLMTEMP

k = 2*pi/365;

% Number of collected data 
n = length(Tdm);
% Timevector (days
t = (1:n)';

% For model 1
% Konstruct matrix 1
A1 = [ones(n, 1), sin(k*t), cos(k*t), sin(2*k*t), cos(2*k*t)];
% Adjusted model with the use of Least squares (Minstakvadratmetoden)
c1 = A1\Tdm;
% Adjusted tempreture temperaturen
T_anp1 = A1 * c1;
% Differance between the mesured datapoints and the adjusted tempreture
residuals1 = Tdm - T_anp1;
% Square the residual
least_squares_sum1 = sum(residuals1.^2);


% For model 2
% Konstruct matrix 2
A2 = [ones(n, 1), t, t.^2, sin(k*t), cos(k*t), sin(2*k*t), cos(2*k*t)];
% Adjusted model with the use of Least squares (Minstakvadratmetoden)
c2 = A2\Tdm;
% Adjusted tempreture temperaturen
T_anp2 = A2 * c2;
% Differance between the mesured datapoints and the adjusted tempreture
residuals2 = Tdm - T_anp2;
% Square the residual
least_squares_sum2 = sum(residuals2.^2);

% Model values
c0_model1 = c1(1);
c1_model1 = c1(2);
c2_model1 = c1(3);
c3_model1 = c1(4);
c4_model1 = c1(5);

% Plot model 1
figure;
subplot(2, 2, 1);
plot(t, Tdm, '.', 'LineWidth', 2); % Plot the model in red
hold on;
plot(t, T_anp1, 'b', 'LineWidth', 2);   % Plot the data points in blue
legend ('Uppmätta temperaturer', 'Anpassad modell', 'Location', 'Best')
xlabel ('Tid (dagar)')
ylabel ('Temperatur (grader)')
title('Residualer1: Tdm - Tmod');
grid on;

% Plot model 2
subplot(2,2,2);
plot(t, Tdm, '.', 'LineWidth', 2);
hold on;
plot(t, T_anp2, 'r', 'LineWidth', 2);   % Plot the data points in blue
legend ('Uppmätta temperaturer', 'Anpassad modell', 'Location', 'Best')
xlabel ('Tid (dagar)')
ylabel ('Temperatur (grader)')
grid on;


% Plot residual1
subplot(2, 2, 3);
plot(t, residuals1, '.', 'LineWidth', 1.5);
xlabel('Tid (dagar)');
ylabel('Residual (grader)');
title('Residualer1: Tdm - Tmod');
grid on;

% Plot residual2
subplot(2, 2, 4);
plot(t, residuals2, '.', 'LineWidth', 1.5);
xlabel('Tid (dagar)');
ylabel('Residual (grader)');
title('Residualer2: Tdm - Tmod');
grid on;

