% evaluating the test suite for problem 1 - 2 variable problem
clc;
clear all;
fulldata = importdata('SP_test_5.dat');

V = fulldata(1:2:end, :)';
V1 = fulldata(2:2:end, :)';
%load net_prob1_case2;
load snet3;

%V1correct = net_prob1_case2(V1);
V1correct = snet3(V1);

rms_noise = sum((V - V1).* (V - V1), 1)./size(V, 1);
rms_correct = sum((V - V1correct).* (V - V1correct), 1)./size(V, 1);
% rms_change = rms_noise.^1 - rms_correct.^1;
%  rms_change_p = rms_change(rms_change >= 0);
%  rms_change_n = rms_change(rms_change < 0);
%  plot(1:1:length(rms_change_p), rms_change_p, '+r')
%  hold on;
%  plot(1:1:length(rms_change_n), rms_change_n, '*b');
%  hold off;

%% new rating criteria
noise_reduc = sum((rms_noise) - (rms_correct))/size(V, 2);
full_noise = sum((rms_noise))/size(V, 2);
reduction = noise_reduc/full_noise

plot(1:1:length(noise_reduc), noise_reduc, 'o');

sum(noise_reduc)/length(noise_reduc)
% 
% temp(:, 1) = 1:1:length(noise_reduc);
% temp(:, 2) = noise_reduc;
% temp(:, 3) = noise_reduc * 0;

%save('noise_reduc_dist_prob1_case1.dat', 'temp', '-ascii');

% a = floor(rand(1)*1000);
% sample_check = a;
% plot(V(:, sample_check))
% hold on;
% plot(V1(:, sample_check), 'r')
% plot(V1correct(:, sample_check), 'k')
% 
% rms_noise = sum((V(:, sample_check) - V1(:, sample_check)).* (V(:, sample_check) - V1(:, sample_check)))./length(V(:, sample_check))
% rms_correct = sum((V(:, sample_check) - V1correct(:, sample_check)).* (V(:, sample_check) - V1correct(:, sample_check)))./length(V(:, sample_check))
% noise_reduc = 100 * (rms_noise - rms_correct)/rms_noise
% 
% title(['Improvement : ', num2str(noise_reduc), '%']);

% temp = [];
% 
% temp(:, 1) = V(:, sample_check);
% temp(:, 2) = V1(:, sample_check);
% temp(:, 3) = V1correct(:, sample_check);

%save(['prob1_case1_testsample_', num2str(sample_check), '.dat'], 'temp', '-ascii');
