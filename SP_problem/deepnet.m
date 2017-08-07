clc;
clear all;

%% Read the data from file and split into input and output for the encoder
%fulldata = importdata('testProb1_data_1.dat');
fulldata = importdata('train_data/SP_data_sd_5_0_2.dat');

inputs = fulldata(1:2:end, :)';
targets = fulldata(2:2:end, :)';
clearvars fulldata;

%% Create the deep network
hidden_size = [34 17 34];
load autoenc1;
snet = feedforwardnet(hidden_size, 'trainscg');%autoenc1;
snet.initFcn = 'init_snet';
snet.init();

% Set up Division of Data for Training, Validation, Testing
snet.divideParam.trainRatio = 80/100;
snet.divideParam.valRatio = 20/100;
snet.divideParam.testRatio = 0/100;
snet.trainParam.epochs = 10000;
snet.performParam.regularization = 0.0;
snet.trainParam.mu_max = 1e15;
%snet.performFcn = 'mae';
%snet.trainFcn = 'trainlm';
snet.performParam.normalization = 'standard';
snet.trainParam.max_fail = 50;
%snet.trainParam.showWindow = true;
snet.layers{1}.transferFcn = 'tansig';
snet.layers{2}.transferFcn = 'tansig';
snet.layers{3}.transferFcn = 'tansig';
snet.layers{4}.transferFcn = 'purelin';

% snet.layers{1}.initFcn = 'init_snet';
% snet.layers{2}.initFcn = 'init_snet';
% snet.layers{3}.initFcn = 'init_snet';
% snet.layers{4}.initFcn = 'init_snet';
% 
% snet.biases{1}.initFcn = 'init_snet';
% snet.biases{2}.initFcn = 'init_snet';
% snet.biases{3}.initFcn = 'init_snet';
% snet.biases{4}.initFcn = 'init_snet';



%snet.layers{2}.transferFcn = 'purelin';
snet.trainParam.showCommandLine = true; 
snet.input.processFcns = {'mapminmax'}; % Remove normalization
snet.output.processFcns= {'mapminmax'};      
%snet = init_snet(snet);
%snet = init(snet);
% poolobj = gcp('nocreate');
% delete(poolobj);
% %--------------------------
% c = parcluster('local');
% c.NumWorkers = 32;
% parpool(c, c.NumWorkers);
[snet,tr] = train(snet, inputs, targets, 'UseParallel', 'yes', 'showResources', 'yes');
save snet;

