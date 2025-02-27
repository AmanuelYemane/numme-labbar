% c)

% Initialisera värden
k = 1;
alfa = 1;

r0 = 1; rN1 = 2;
Ti = 450;
Te = 20;

N = 25;

diff = 1;

while diff > 0.05

h = (rN1 - r0)/(N+1); % Steglängd
rj = [r0+h:h:rN1-h]'; % Inre punkter

A = zeros(N,N); % Skapa matrisen A

A(1,1:2) = [-2*rj(1)/(h^2) rj(1)/(h^2)+1/(2*h)]; % Första raden (rad 1, kolumn 1-2)

for ii=2:N-1
    A(ii,ii-1) = rj(ii)/(h^2)-1/(2*h); % rad ii kolumn ii-1
    A(ii,ii) = -2*rj(ii)/(h^2);
    A(ii,ii+1) = rj(ii)/(h^2)+1/(2*h);
end

A(N,N-1:N) = [rj(N)/(h^2)-1/(2*h) ((k/h)/(k/h+alfa))*(rj(N)/(h^2)+1/(2*h))-2*rj(N)/(h^2)];

A = sparse(A); % Gles matris

% Skapa högerledet

b = zeros(N,1);

b(1) = -(rj(1)/(h^2)-1/(2*h))*Ti;
b(N) = -(Te*alfa/(k/h+alfa))*(rj(N)/(h^2)+1/(2*h));

% Lös systemet för T
T = A\b;

old = TN1;

TN1 = (Te*alfa+(k/h)*T(N))/(k/h+alfa);

disp(TN1)
disp(N)

N = 2*N;

if N >= 75
    diff = abs(old-TN1);
end

if diff <= 0.05
    figure(1)
    plot(rj, T)
    title('Temperaturfördelning i cylinderväggen')
    xlabel('r')
    ylabel('T')
    legend('Temperatur')
end

end

% Svar: 200.2283930616815 N=800

% d)

r0 = 1; rN1 = 2;
Ti = 450;
Te = 20;

N = 10000;

diff = 1;

for ii = 0:0.5:10

alfa = ii;

h = (rN1 - r0)/(N+1); % Steglängd
rj = [r0+h:h:rN1-h]'; % Inre punkter

A = zeros(N,N); % Skapa matrisen A

A(1,1:2) = [-2*rj(1)/(h^2) rj(1)/(h^2)+1/(2*h)]; % Första raden (rad 1, kolumn 1-2)

for ii=2:N-1
    A(ii,ii-1) = rj(ii)/(h^2)-1/(2*h); % rad ii kolumn ii-1
    A(ii,ii) = -2*rj(ii)/(h^2);
    A(ii,ii+1) = rj(ii)/(h^2)+1/(2*h);
end

A(N,N-1:N) = [rj(N)/(h^2)-1/(2*h) ((k/h)/(k/h+alfa))*(rj(N)/(h^2)+1/(2*h))-2*rj(N)/(h^2)];

A = sparse(A); % Gles matris

% Skapa högerledet

b = zeros(N,1);

b(1) = -(rj(1)/(h^2)-1/(2*h))*Ti;
b(N) = -(Te*alfa/(k/h+alfa))*(rj(N)/(h^2)+1/(2*h));

% Lös systemet för T
T = A\b;

TN1 = (Te*alfa+(k/h)*T(N))/(k/h+alfa);

disp(TN1)

figure(2)
plot(alfa, TN1, 'ob')
hold on

end

figure(2)
title('Temperturvärdet i ytterradien som funktion av alfa')
xlabel('alfa')
ylabel('T')


% När alfa går mot oändlighet kommer temperaturvärdet i ytterradien att gå
% mot den omgivande luftens temperatur, som i det här fallet är 20 grader C

