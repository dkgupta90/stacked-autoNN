close all;
clc;
clear all;

format long;

%% Read the data from file and split into input and output for the encoder
fulldata = importdata('train_data/SP_data_sd_2o5_0.dat');

inputs = importdata('corrected_input_10_0o2.dat');
targets = fulldata(2:2:end, :)';
clearvars fulldata;
%dlmwrite('input_SP1.dat', targets, 'delimiter','\t');
%dlmwrite('output_SP1.dat', targets, 'delimiter','\t');

%% Train a neural network using input and output
net=feedforwardnet([10]);

% Create a Fitting Network
%hiddenLayerSize = 10;
%net = fitnet(hiddenLayerSize);

% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio = 20/100;
net.divideParam.testRatio = 0/100;
 
net.trainParam.epochs = 200;
net.performParam.regularization = 0.2;
net.trainParam.mu_max = 1e15;

net.trainParam.max_fail = 10;

net.trainParam.showWindow = true;
%net.trainParam.showCommandLine = true; 
     
% Train the Network
[net,tr] = train(net,inputs,targets);
SP_data_10_0o2 = net;
save SP_data_10_0o2;

%corrected_input = SP_data_10_0o2(inputs);
%dlmwrite('corrected_input_10_0o2.dat', corrected_input, 'delimiter','\t');

%Test the Network

%     lb = [1, 25, -1000, 1.5, 5];
%     ub = [8, 75, 1000, 1.5, 5];
%     x = -40:2.5:40;
%     randN = rand(1, 5); %generate a random model
%     paramV = lb + (ub - lb).*randN;
%     V = SP_sphere(x, paramV(1), paramV(2), paramV(3), paramV(4), paramV(5));
%     V1 = add_noise(V, 3, 'constant');
%     V1correct = net(V1);
%     plot(V1)
%     hold on;
%     plot(V, 'red')
%     plot(V1correct, 'green')
    
    
    
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs)
 
% View the Network
%view(net)
 
% Plots
% Uncomment these lines to enable various plots.
% figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure, plotfit(targets,outputs)
% figure, plotregression(targets,outputs)
% figure, ploterrhist(errors)
