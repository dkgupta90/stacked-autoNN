% test suite for problem 1

%% Create the test suite

test_samples = 1000;
no_constant_noise = 0;
no_scaled_noise = 1000;

lb = [1, 25, -1000, 0.5, -5];
ub = [8, 75, 1000, 1.5, 5];
x = -20:2.5:20;

sd_max = 5;
sd_fix = 0.0;
fid = fopen('SP_test_5.dat', 'w');


%Iterating over no_constant_noise
for sample = 1:1:no_constant_noise
    
    randN = rand(1, 5); %generate a random model
    paramV = lb + (ub - lb).*randN;
    V = SP_sphere(x, paramV(1), paramV(2), paramV(3), paramV(4), paramV(5));
    %adding the noise-free data
    fprintf(fid, '%f\t', V);
    fprintf(fid, '\n');
    sd = sd_max * rand(1);
    V1 = add_noise(V, sd, 'constant', sd_fix);
    fprintf(fid, '%f\t', V1);
    fprintf(fid, '\n');
end

for sample = 1:1:no_scaled_noise
    
    randN = rand(1, 5); %generate a random model
    paramV = lb + (ub - lb).*randN;
    V = SP_sphere(x, paramV(1), paramV(2), paramV(3), paramV(4), paramV(5));
    %adding the noise-free data
    fprintf(fid, '%f\t', V);
    fprintf(fid, '\n');
    sd = sd_max * rand(1);
    V1 = add_noise(V, sd, 'scaled', sd_fix);
    fprintf(fid, '%f\t', V1);
    fprintf(fid, '\n');
end

fclose(fid);