function V = SP_sphere(x, z, theta, K, q, x0)

thetaRad = (theta/180) * pi;
numer = (x - x0).*cos(thetaRad) + z*sin(thetaRad);
denom = ((x-x0).^2 + z.^2).^q;

V = K.*(numer./denom);
V = V';

end