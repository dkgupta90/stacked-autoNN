% Stacked autoencoder implementation
clc;
clear all;
close all;
%% Read the data from file and split into input and output for the encoder
%fulldata = importdata('testProb1_data_1.dat');
fulldata = importdata('train_data/SP_data_sd_5_0_2.dat');

inputs = fulldata(1:2:end, :)';
targets = fulldata(2:2:end, :)';
clearvars fulldata;

%% Autoencoder 1
autoenc1 = feedforwardnet([34], 'trainscg');
% Set up Division of Data for Training, Validation, Testing
autoenc1.divideParam.trainRatio = 80/100;
autoenc1.divideParam.valRatio = 20/100;
autoenc1.divideParam.testRatio = 0/100;
autoenc1.trainParam.epochs = 10000;
autoenc1.performParam.regularization = 0.05;
autoenc1.trainParam.mu_max = 1e15;
%autoenc1.performFcn = 'mae';
autoenc1.performParam.normalization = 'standard';
autoenc1.trainParam.max_fail = 100;
%autoenc1.trainParam.showWindow = true;
autoenc1.layers{1}.transferFcn = 'tansig';
%autoenc1.layers{2}.transferFcn = 'purelin';
autoenc1.trainParam.showCommandLine = true; 
autoenc1.input.processFcns = {'mapminmax'}; % Remove normalization
autoenc1.output.processFcns= {'mapminmax'};      
% Train the Network
[autoenc1,tr] = train(autoenc1, inputs, targets, 'UseParallel', 'yes');
save autoenc1;



%% Autoencoder 2
[inputs_n, inputs_s] = mapminmax(inputs);
feature1 = tansig(autoenc1.IW{1}*inputs_n + repmat( autoenc1.b{1}, 1, size(inputs_n, 2)));

autoenc2 = feedforwardnet([17], 'trainscg');
% Set up Division of Data for Training, Validation, Testing
autoenc2.divideParam.trainRatio = 80/100;
autoenc2.divideParam.valRatio = 20/100;
autoenc2.divideParam.testRatio = 0/100;
autoenc2.trainParam.epochs = 10000;
autoenc2.performParam.regularization = 0.05;
autoenc2.trainParam.mu_max = 1e15;
%autoenc1.performFcn = 'mae';
autoenc2.performParam.normalization = 'standard';
autoenc2.trainParam.max_fail = 100;
%autoenc2.trainParam.showWindow = true;
autoenc2.layers{1}.transferFcn = 'tansig';
autoenc2.layers{2}.transferFcn = 'tansig';
autoenc2.trainParam.showCommandLine = true; 
autoenc2.input.processFcns = {'removeconstantrows'}; % Remove normalization
autoenc2.output.processFcns= {'removeconstantrows'};      
% Train the Network
[autoenc2,tr] = train(autoenc2, feature1, feature1, 'UseParallel', 'yes');
save autoenc2;

% %% Autoencoder 3
% [inputs_n, inputs_s] = mapminmax(inputs);
% feature2 = tansig(autoenc2.IW{1}*feature1 + repmat( autoenc2.b{1}, 1, size(feature1, 2)));
% 
% autoenc3 = feedforwardnet([17], 'trainscg');
% % Set up Division of Data for Training, Validation, Testing
% autoenc3.divideParam.trainRatio = 80/100;
% autoenc3.divideParam.valRatio = 20/100;
% autoenc3.divideParam.testRatio = 0/100;
% autoenc3.trainParam.epochs = 10000;
% autoenc3.performParam.regularization = 0.04;
% autoenc3.trainParam.mu_max = 1e15;
% %autoenc3.performFcn = 'mae';
% autoenc3.performParam.normalization = 'standard';
% autoenc3.trainParam.max_fail = 100;
% %autoenc3.trainParam.showWindow = true;
% autoenc3.layers{1}.transferFcn = 'tansig';
% autoenc3.layers{2}.transferFcn = 'tansig';
% autoenc3.trainParam.showCommandLine = true; 
% autoenc3.input.processFcns = {'removeconstantrows'}; % Remove normalization
% autoenc3.output.processFcns= {'removeconstantrows'};      
% % Train the Network
% [autoenc3,tr] = train(autoenc3, feature2, feature2, 'UseParallel', 'yes');
% save autoenc3;


%-------------------------------------------------------------------------
% rng('default');
% 
% hidden_size = [17 25];
% 
% autoenc1 = trainAutoencoder(targets, hidden_size(1), ...
%     'MaxEpochs',5000, ...
%     'SparsityProportion',0.15);