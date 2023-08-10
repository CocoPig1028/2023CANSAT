dzero = [0; 0; 350;]; %m
vzero = [1; 2; 5;]; %m/s
azero = [0; 0; 0;]; %m/s^2

%g = -9.81;
g = -0.5;
%m/s^2

%시간 배열 생성
t_start=0; %시작 시간 t
t_end=60; %종료 시간 t
dt=0.01; %시간 간격(변화량)

t=t_start:dt:t_end; %t변화

d_x = dzero(1) + vzero(1) * t + azero(1) * t.^2; %x궤적
d_y = dzero(2) + vzero(2) * t + azero(2) * t.^2; %y궤적
d_z = dzero(3) + vzero(3) * t + 1 / 2 * (g + azero(3)) * t.^2; %z궤적

syms time;
eqn = dzero(3) + vzero(3) * time + 1 / 2 * (g + azero(3)) * time.^2 == 0; % 땅에 도착했을 때의 시간 공식
sol = solve(eqn, time); % 땅에 도착했을 때의 시간 공식

positive_roots = [];
for i = 1:numel(sol)
    if isreal(sol(i)) && sol(i) > 0
        positive_roots = [positive_roots; sol(i)];
    end
end

s_x = dzero(1) + vzero(1) * positive_roots + azero(1) * positive_roots.^2;
s_y = dzero(2) + vzero(2) * positive_roots + azero(2) * positive_roots.^2;

f_d = (s_x.^2 + s_y.^2)^(1 / 2)

format long
x_land = double(s_x)
y_land = double(s_y)
time = double(positive_roots)
distance = double(f_d) %발사장에서 착륙지점까지의 거리

figure;
plot3(d_x, d_y, d_z);
xlabel({'X distance', '(m)'});
ylabel({'Y distance', '(m)'});
zlabel({'Z distance', '(m)'});

grid on;
xlim([0 200]);
ylim([0 200]);
zlim([0 400]);