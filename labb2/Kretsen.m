% b)

myode = @(t, y, R, L, C) [y(2); -((R.*y(2)) + 1./C.*y(1))./L];

% c)

y0 = [1; 0];
tspan = [0 20];
[t1, y1] = ode45(@(t, y) myode(t, y, 1, 2, 0.5), tspan, y0);

q1 = y1(:,1); % Första kolumnen
i1 = y1(:,2); % Andra kolumnen

figure(1)
subplot(1,2,1)
plot(t1, q1, '--o', t1, i1, '--or')

[t2, y2] = ode45(@(t, y) myode(t, y, 0, 2, 0.5), tspan, y0);

q2 = y2(:,1); % Första kolumnen
i2 = y2(:,2); % Andra kolumnen

figure(1)
subplot(1,2,2)
plot(t2, q2, '--o', t2, i2, '--or')

% d)

function eulerFram(n, myode, place)
    y0 = [1; 0];
    t = 0;
    T = 40;
    intervall = [t T];
    yvalues = zeros(2, n+1);
    yvalues(:,1) = y0;
    y = y0;
    h = (intervall(2)-intervall(1))/n;
    tvals = linspace(t, T, n+1);

    for ii = 1:n
        y = y+h*myode(t, y, 1, 2, 0.5);
        t = t+h;
        yvalues(:,ii+1) = y;
    end

    figure(2)
    subplot(2, 2, place)

    q = yvalues(1,:); % Första kolumnen
    i = yvalues(2,:); % Andra kolumnen

    plot(tvals, q, '--o', tvals, i, '--o')
    hold on;
    % Plotta ode45
    y0 = [1; 0];
    [t3, y3] = ode45(@(t, y) myode(t, y, 0, 2, 0.5), intervall, y0);

    q3 = y3(:,1); % Första kolumnen
    i3 = y3(:,2); % Andra kolumnen

    figure(2)
    subplot(2, 2, place)
    plot(t3, q3, '-', t3, i3, '-')
    hold on;
end

eulerFram(40, myode, 1);
eulerFram(80, myode, 2);
eulerFram(160, myode, 3);
eulerFram(320, myode, 4);