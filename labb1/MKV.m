clear all

load STHLMTEMP

format long

% Konstant
k = 2*pi/365;

% Antalet punkter
n = length(Tdm);
% Tidsvektor (dagar)
t = (1:n)';

% Modell 1
% Anonym funktion för modellen
model1 = @(c, t) c(1) + c(2)*sin(k*t) + c(3)*cos(k*t) + c(4)*sin(2*k*t) + c(5)*cos(2*k*t);
% Skapa matris A1
A1 = [ones(n, 1), sin(k*t), cos(k*t), sin(2*k*t), cos(2*k*t)];
% Få fram c med MKV, vi har A1c = Tdm, 
% så vi löser normalekvationen (A1')A1c=(A1')Tdm med
% c = A1'*A1\(A1'*Tdm), vilket är samma som (i princip)
c = A1\Tdm;
% Differensvektor mellan mätpunkterna och den anpassade modellen (residualen)
residuals1 = Tdm - model1(c, t); % Same as Tdm - A1 * c;
% Minstakvadratsumman
least_squares_sum1 = sum(residuals1.^2);

% Modell 2
% Anonym funktion för modellen
model2 = @(a, t) a(1) + a(2)*t + a(3)*t.^2 + a(4)*sin(k*t) + a(5)*cos(k*t) + a(6)*sin(2*k*t) + a(7)*cos(2*k*t);
% Skapa matris A1
A2 = [ones(n, 1), t, t.^2, sin(k*t), cos(k*t), sin(2*k*t), cos(2*k*t)];
% Ta fram a med MKV
a = A2\Tdm;
% Differensvektor mellan mätpunkterna och den anpassade modellen (residualen)
residuals2 = Tdm - model2(a, t); 
% Minstakvadratsumman
least_squares_sum2 = sum(residuals2.^2);

% Modellvärden
disp("c0 = " + c(1))
disp("c1 = " + c(2))
disp("c2 = " + c(3))
disp("c3 = " + c(4))
disp("c4 = " + c(5))

% Plota modell 1
subplot(2, 2, 1) % Dela in fiiguren i en 2x2 grid
plot(t, Tdm, '.', 'LineWidth', 1.5) % Plota varje datapunkt med en punkt
hold on
plot(t, model1(c, t), 'b', 'LineWidth', 1.5) % Plota modellen med en blå linje
legend('Uppmätta temperaturer', 'Anpassad modell', 'Location', 'Best')
xlabel('Tid (dagar)')
ylabel('Temperatur (grader)')
title('Model 1')
grid on

% Plota modell 2
subplot(2,2,2)
plot(t, Tdm, '.', 'LineWidth', 1.5)
hold on
plot(t, model2(a, t), 'r', 'LineWidth', 1.5)
legend('Uppmätta temperaturer', 'Anpassad modell', 'Location', 'Best')
xlabel('Tid (dagar)')
ylabel('Temperatur (grader)')
title('Model 2')
grid on

% Plota residual 1
subplot(2, 2, 3)
plot(t, residuals1, '.', 'LineWidth', 1.5)
xlabel('Tid (dagar)')
ylabel('Residual (grader)')
title('Residualer1: Tdm - Tmod1')
grid on

% Plota residual 2
subplot(2, 2, 4)
plot(t, residuals2, '.', 'LineWidth', 1.5)
xlabel('Tid (dagar)')
ylabel('Residual (grader)')
title('Residualer2: Tdm - Tmod2')
grid on

disp("minstakvadratsumman modell 1 = " + least_squares_sum1);
disp("minstakvadratsumman modell 2 = " + least_squares_sum2);

% d) 

% Svar på frågor:
% Minstakvadratsumman är mindre för modell 2 vilket också går att avläsa
% marginellt när man jämför residualernas grafer

% e) 

% Svar på frågor:
% Runt 1850 sker det en ökning av dygnsmedeltemperaturen. Det kan
% vara pågrund av den inustriella relolutionen, som såg en ökning i
% förbrännelse av fossila bränslen, vilket bidrar till den globala
% uppvärmningnen. 


