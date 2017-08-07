function [snet, initWeights] = init_snet(str_init, snet, str_wb, i, j, x)

%% Read the data from file and split into input and output for the encoder
%fulldata = importdata('testProb1_data_1.dat');
fulldata = importdata('train_data/SP_data_sd_5_0.dat');

inputs = fulldata(1:2:end, :)';
targets = fulldata(2:2:end, :)';
clearvars fulldata;
load autoenc1;
load autoenc2;

if (nargin == 1)
    snet = str_init;
    snet.IW{1} = autoenc1.IW{1};
    snet.LW{2, 1} = autoenc2.IW{1};
    snet.LW{3, 2} = autoenc2.LW{2, 1};
    snet.LW{4, 3} = autoenc1.LW{2, 1};
    %% adding the biases
    snet.b{1} = autoenc1.b{1};
    snet.b{2} = autoenc2.b{1};
    snet.b{3} = autoenc2.b{2};
    snet.b{4} = autoenc1.b{2};
    
    snet.biases{1}.size = 34;
    snet.biases{2}.size = 17;
    snet.biases{3}.size = 34;
    snet.biases{4}.size = 17;
    snet.inputs{1}.size = 17;
    snet.layers{1}.size = 34;
    snet.layers{2}.size = 17;
    snet.layers{3}.size = 34;
    snet.layers{4}.size = 17;
    
    snet.inputWeights{1}.size = [34 17];
    snet.layerWeights{2, 1}.size = [17 34];
    snet.layerWeights{3, 2}.size = [34 17];
    snet.layerWeights{4, 3}.size = [17 34];

else
    if i == 1
        snet.b{1} = autoenc1.b{1};
    elseif i == 2
        snet.b{2} = autoenc2.b{1};
    elseif i == 3
        snet.b{3} = autoenc2.b{2};
    elseif i == 4
        snet.b{4} = autoenc1.b{2};
    end
%     snet.IW{1} = autoenc1.IW{1};
%     snet.LW{i, 1} = autoenc1.LW{i, 1};
%     snet.b{i} = autoenc1.b{i};
end


end