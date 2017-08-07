close all;
load net;

lb = [1, 25, -1000, 0.5, 5];
ub = [8, 75, 1000, 1.5, 5];
x = -20:2.5:20;
randN = rand(1, 5); %generate a random model
paramV = lb + (ub - lb).*randN;
V = SP_sphere(x, paramV(1), paramV(2), paramV(3), paramV(4), paramV(5));
V1 = add_noise(V, 2, 'uniform');
V1correct = net(V1);
FigHandle = figure('Position', [100, 100, 1500, 1000]);
hold on;
plot(V1)
plot(V, 'red')
plot(V1correct, 'green')
legend('noisy signal', 'noisefree signal', 'AE corrected signal')

rms_noise = sum((V - V1).* (V - V1))./length(V)
rms_correct = sum((V - V1correct).* (V - V1correct))./length(V)
noise_reduc = 100 * (rms_noise - rms_correct)/rms_noise

title(['Improvement : ', num2str(noise_reduc), '%']);

hold off;

