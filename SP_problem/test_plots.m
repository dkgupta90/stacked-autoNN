% evaluating the test suite for problem 1 - 2 variable problem
clc;
clear all;
fulldata = importdata('SP_test_5.dat');

V = fulldata(1:2:end, :)';
V1 = fulldata(2:2:end, :)';
%load net_prob1_case2;
load snet3;
V1correct = snet3(V1);

sampleno = 282;
temp(:, 1) = 1:1:17;
temp(:, 2) = V(:, sampleno);
temp(:, 3)= V1(:, sampleno);
temp(:, 4) = V1correct(:, sampleno);
save('SP_sample_282.dat', 'temp', '-ascii');
no_samples = length(V(1, :));

for i = 270:1:no_samples
    i
   x = 1:1:length(V(:, 1));
   plot(x, V(:, i));
   hold on;
   plot(x, V1(:, i), 'k');
   plot(x, V1correct(:, i), 'r');
   hold off;
end