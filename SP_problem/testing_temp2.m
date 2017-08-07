clc;
clear all;

%% Read the data from file and split into input and output for the encoder
%fulldata = importdata('testProb1_data_1.dat');
fulldata = importdata('train_data/SP_data_sd_2o5_0.dat');

inputs = fulldata(1:2:end, :)';
targets = fulldata(2:2:end, :)';
clearvars fulldata;

%% Create the deep network
hidden_size = [21];
load autoenc1;
snet = autoenc1;
snet.initFcn = 'init_snet_temp';
snet.numInputs = 1;
snet.numLayers = 2;
snet.biasConnect = [1; 1];
snet.inputConnect = [1; 0];
snet.layerConnect = [0 0; 1 0];
snet.outputConnect = [0 1];

%snet = feedforwardnet(hidden_size, 'trainscg');
% Set up Division of Data for Training, Validation, Testing
snet.divideParam.trainRatio = 80/100;
snet.divideParam.valRatio = 20/100;
snet.divideParam.testRatio = 0/100;
snet.trainParam.epochs = 2000;
snet.performParam.regularization = 0.0;
%snet.trainParam.mu_max = 1e15;
%snet.performFcn = 'mae';
%snet.performParam.normalization = 'standard';
snet.trainParam.max_fail = 25;
snet.trainParam.showWindow = true;
snet.layers{1}.transferFcn = 'tansig';
%snet.layers{2}.transferFcn = 'purelin';
%snet.trainParam.showCommandLine = true; 
snet.input.processFcns = {'mapminmax'}; % Remove normalization
snet.output.processFcns= {'mapminmax'}; 
%snet.configure(snet, inputs, targets);

% defining custom init function for weights and biases
%snet.initFcn = 'init_snet_temp';
%snet = init(snet);
%snet = init_snet_temp(snet);
%snet.initFcn = '';




% Train the Network

[snet,tr] = train(snet, inputs, targets, 'UseParallel', 'yes');
save snet;

