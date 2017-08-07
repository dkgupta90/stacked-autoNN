% This function does brute force search in the parameter space to find the
% best fitting plot in the data

fname = 'prob1_case1_testsample_70.dat';
data = importdata(fname);

V = data(:, 1);
V1 = data(:, 2);
V1correct = data(:, 3);

x = 0.05:0.05:1;


y = 0.5:0.01:4;
z = 0.3:0.005:1.3;
[Y, Z] = meshgrid(y, z);

Y = Y(:);
Z = Z(:);
models = length(Y);

error = 99999999;

for i = 1:1:models
   Vtemp = test_prob1(x, Y(i), Z(i)); 
   new_error = sum((V1 - Vtemp).*(V1 - Vtemp))/length(V);
   
   if (error > new_error)
       error = new_error
       V2 = Vtemp;
   end
end

real_error = sum((V - V1).*(V - V1))/length(V)
ae_error = sum((V - V1correct).*(V - V1correct))/length(V)
error = sum((V - V2).*(V - V2))/length(V)

temp(:, 1) = x;
temp(:, 2) = V;
temp(:, 3) = V1;
temp(:, 4) = V1correct;
temp(:, 5) = V2;
save(fname, 'temp', '-ascii');
plot(V);
hold on;
plot(V1correct, 'r');
plot(V1, 'k');
plot(V2, 'c');