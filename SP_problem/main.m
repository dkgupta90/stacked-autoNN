clc;
clear all;

%load real data


lb = [1, 25, -1000, 0.5, -5];
ub = [8, 75, 1000, 1.5, 5];

randN = rand(1, 5)

paramV = lb + (ub - lb).*randN
%paramV = [4, 40.0, -500.01, 0.5, 0.0];
%error = calculate_error(paramV)
options=optimset('Algorithm', 'sqp', 'Display','iter','TolFun', 1e-15, 'TolX', 1e-15, 'TOlCon', 1e-15,...
'MaxFunEvals', 10000);
param = fmincon(@calculate_error, paramV, [], [], [], [], lb, ub, [], options)



%paramV = [4, 40.0, -500.01, 0.5, 0.0];
%error = calculate_error(paramV)


[Xreal, Vreal] = textread('real_data.dat', '%f%f');
Vg = SP_sphere(Xreal, param(1), param(2), param(3), param(4), param(5));
plot(Xreal, Vreal);
hold on;
plot(Xreal, Vg, 'r*');
hold off;



