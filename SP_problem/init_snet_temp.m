function [snet, initWeights] = init_snet_temp(str_init, snet, str_wb, i, j, x)

%% Read the data from file and split into input and output for the encoder
%fulldata = importdata('testProb1_data_1.dat');
fulldata = importdata('train_data/SP_data_sd_2o5_0.dat');

inputs = fulldata(1:2:end, :)';
targets = fulldata(2:2:end, :)';
clearvars fulldata;
load autoenc1;
    
if (nargin == 1)
    snet = str_init;
    snet.IW{1} = autoenc1.IW{1};
    snet.b{1} = autoenc1.b{1};
    snet.LW{2, 1} = autoenc1.LW{2, 1};
    snet.b{2} = autoenc1.b{2};
    
else
    snet.IW{1} = autoenc1.IW{1};
    snet.LW{i, 1} = autoenc1.LW{i, 1};
    snet.b{i} = autoenc1.b{i};
end




end