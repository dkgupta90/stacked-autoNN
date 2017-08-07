% this script is used to test temporary codes

x = 0:0.01:1;
z = 0.52;
theta = 2;

y = z * sin(theta) * x + (cos(theta)/z) * (x.*x);
plot(x, y)
