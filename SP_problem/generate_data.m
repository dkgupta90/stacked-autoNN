%create data file

z = 4;
theta = 40; %degrees
K = -500;
q = 0.5;
x0 = 0;

x = -20:2.5:20;

V = SP_sphere(x, z, theta, K, q, x0);

%V = awgn(V, 50);

temp(:, 1) = x;
temp(:, 2) = V;

save('real_data.dat', 'temp', '-ascii');