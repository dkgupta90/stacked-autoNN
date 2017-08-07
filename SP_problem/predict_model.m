close all;
clc;
clear all;

format long;

%% Read the data from file and split into input and output for the encoder
fulldata = importdata('train_data/SP_data_sd_5_0.dat');

inputs = fulldata(1:2:end, :)';
targets = fulldata(2:2:end, :)';
clearvars fulldata;

%% Train a neural network using input and output
net=feedforwardnet([20 25 30 25 20], 'trainscg');

% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio = 20/100;
net.divideParam.testRatio = 0/100;
 
net.trainParam.epochs = 50000;
net.performParam.regularization = 0.0;
net.trainParam.mu_max = 1e15;
%net.performFcn = 'mae';
net.performParam.normalization = 'standard';

net.trainParam.max_fail = 50;


%net.trainParam.showWindow = false;
%net.layers{1}.transferFcn = 'purelin';

net.trainParam.showCommandLine = true; 
     
net.input.processFcns = {'mapminmax'}; % Remove normalization
net.output.processFcns= {'mapminmax'}; 
% Train the Network
[net,tr] = train(net,inputs,targets, 'UseParallel', 'yes');
SP_net = net;
save SP_net;
