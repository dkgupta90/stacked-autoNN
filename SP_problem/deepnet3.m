clc;
clear;

%% Read the data from file and split into input and output for the encoder
%fulldata = importdata('testProb1_data_1.dat');
fulldata = importdata('train_data/SP_data_sd_5_0.dat');

inputs = fulldata(1:2:end, :)';
targets = fulldata(2:2:end, :)';
clearvars fulldata;

%% Create the deep network
hidden_size = [25 20 17 20 25];
load autoenc1;
snet3 = autoenc1;
snet3 = feedforwardnet(hidden_size, 'trainscg');%autoenc1;
snet3.initFcn = 'init_snet3';
snet3.init();
snet3.numInputs = 1;
snet3.numLayers = 6;
snet3.biasConnect = [1; 1; 1; 1; 1; 1];
snet3.inputConnect = [1; 0; 0; 0; 0; 0];
snet3.layerConnect = [0 0 0 0 0 0; 1 0 0 0 0 0; 0 1 0 0 0 0; 0 0 1 0 0 0; 0 0 0 1 0 0; 0 0 0 0 1 0];
snet3.outputConnect = [0 0 0 0 0 1];


% Set up Division of Data for Training, Validation, Testing
snet3.divideParam.trainRatio = 80/100;
snet3.divideParam.valRatio = 20/100;
snet3.divideParam.testRatio = 0/100;
snet3.trainParam.epochs = 50000;
snet3.performParam.regularization = 0.0;
snet3.trainParam.mu_max = 1e15;
%snet3.performFcn = 'mae';
snet3.performParam.normalization = 'standard';
snet3.trainParam.max_fail = 200;
%snet3.trainParam.showWindow = true;
snet3.layers{1}.transferFcn = 'tansig';
snet3.layers{2}.transferFcn = 'tansig';
snet3.layers{3}.transferFcn = 'tansig';
snet3.layers{4}.transferFcn = 'tansig';
snet3.layers{5}.transferFcn = 'tansig';
snet3.layers{6}.transferFcn = 'purelin';
%snet3.efficiency.memoryReduction = 12;
% snet3.layers{1}.initFcn = 'init_snet3';
% snet3.layers{2}.initFcn = 'init_snet3';
% snet3.layers{3}.initFcn = 'init_snet3';
% snet3.layers{4}.initFcn = 'init_snet3';
% 
% snet3.biases{1}.initFcn = 'init_snet3';
% snet3.biases{2}.initFcn = 'init_snet3';
% snet3.biases{3}.initFcn = 'init_snet3';
% snet3.biases{4}.initFcn = 'init_snet3';



%snet3.layers{2}.transferFcn = 'purelin';
snet3.trainParam.showCommandLine = true; 
snet3.input.processFcns = {'mapminmax'}; % Remove normalization
snet3.output.processFcns= {'mapminmax'};      
%snet3 = init_snet3(snet3);
%snet3 = init(snet3);
[snet3,tr] = train(snet3, inputs, targets, 'UseParallel', 'yes');
save snet3;

