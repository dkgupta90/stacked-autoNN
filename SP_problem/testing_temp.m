% Stacked autoencoder implementation
clc;
clear all;

load autoenc1;
load autoenc2;
load SP_net;

%% Read the data from file and split into input and output for the encoder
%fulldata = importdata('testProb1_data_1.dat');
fulldata = importdata('train_data/SP_data_sd_2o5_0.dat');

inputs = fulldata(1:2:end, :)';
targets = fulldata(2:2:end, :)';
clearvars fulldata;

% normalizing the input and output

%outputs = mapminmax(outputs);
view(autoenc1);
outputs = autoenc1(inputs);

% normalization
[inputs_n, inputs_s] = mapminmax(inputs);
[targets_n, targets_s] = mapminmax(targets);

%% Output of shallow autoencoder
feature1 = tansig(autoenc1.IW{1}*inputs_n + repmat(autoenc1.b{1}, 1, size(inputs, 2)));
feature2 = (autoenc1.LW{2}*feature1 + repmat( autoenc1.b{2}, 1, size(inputs, 2)));
%denormalization
feature2 = mapminmax('reverse', feature2, targets_s);
error1 = sum(sum(abs(feature2 - outputs)))%/(size(feature2, 1)*size(feature2, 2))

%% testing the output of a 4 layer network

outputs = SP_net(inputs);

feature1 = tansig(SP_net.IW{1}*inputs_n + repmat( SP_net.b{1}, 1, size(inputs, 2)));
feature2 = tansig(SP_net.LW{2, 1}*feature1+ repmat( SP_net.b{2}, 1, size(inputs, 2)));
feature3 = tansig(SP_net.LW{3, 2}*feature2+ repmat( SP_net.b{3}, 1, size(inputs, 2)));
feature4 = (SP_net.LW{4, 3}*feature3+ repmat( SP_net.b{4}, 1, size(inputs, 2)));
%denormalization
feature4 = mapminmax('reverse', feature4, targets_s);
error12 = sum(sum(abs(feature4 - outputs)))%/(size(feature2, 1)*size(feature2, 2))

%% Output of deep autoencoder

outputs = SP_net(inputs);

feature1 = tansig(autoenc1.IW{1}*inputs_n + repmat( autoenc1.b{1}, 1, size(inputs, 2)));
feature2 = tansig(autoenc2.IW{1}*feature1+ repmat( autoenc2.b{1}, 1, size(inputs, 2)));
feature3 = tansig(autoenc2.LW{2}*feature2+ repmat( autoenc2.b{2}, 1, size(inputs, 2)));
feature4 = (autoenc1.LW{2}*feature3+ repmat( autoenc1.b{2}, 1, size(inputs, 2)));
%denormalization
feature4 = mapminmax('reverse', feature4, targets_s);
error12 = sum(sum(abs(feature4 - outputs)))%/(size(feature2, 1)*size(feature2, 2))

