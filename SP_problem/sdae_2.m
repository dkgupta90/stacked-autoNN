% Stacked autoencoder implementation
clc;
clear all;
close all;
%% Read the data from file and split into input and output for the encoder
%fulldata = importdata('testProb1_data_1.dat');
fulldata = importdata('train_data/SP_data_sd_2o5_0.dat');

inputs = fulldata(1:2:end, :)';
targets = fulldata(2:2:end, :)';
clearvars fulldata;

%% Autoencoder 1
load autoenc1;

%% Autoencoder 2
[inputs_n, inputs_s] = mapminmax(inputs);
feature1 = tansig(autoenc1.IW{1}*inputs_n + repmat( autoenc1.b{1}, 1, size(inputs_n, 2)));

autoenc2 = feedforwardnet([17], 'trainscg');
% Set up Division of Data for Training, Validation, Testing
autoenc2.divideParam.trainRatio = 100/100;
autoenc2.divideParam.valRatio = 0/100;
autoenc2.divideParam.testRatio = 0/100;
autoenc2.trainParam.epochs = 10000;
autoenc2.performParam.regularization = 0.1;
autoenc2.trainParam.mu_max = 1e15;
%autoenc1.performFcn = 'mae';
%autoenc1.performParam.normalization = 'standard';
autoenc2.trainParam.max_fail = 25;
%autoenc2.trainParam.showWindow = true;
autoenc2.layers{1}.transferFcn = 'tansig';
autoenc2.layers{2}.transferFcn = 'tansig';
autoenc1.trainParam.showCommandLine = true; 
autoenc2.input.processFcns = {'removeconstantrows'}; % Remove normalization
autoenc2.output.processFcns= {'removeconstantrows'};      
% Train the Network
[autoenc2,tr] = train(autoenc2, feature1, feature1, 'UseParallel', 'yes');
save autoenc2;




%-------------------------------------------------------------------------
% rng('default');
% 
% hidden_size = [17 25];
% 
% autoenc1 = trainAutoencoder(targets, hidden_size(1), ...
%     'MaxEpochs',5000, ...
%     'SparsityProportion',0.15);