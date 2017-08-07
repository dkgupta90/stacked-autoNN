% This function creates the huge data to make the autoencoder learn

%% The parameters below are somethings known apriori
lb = [1, 25, -1000, 0.5, -5];
ub = [8, 75, 1000, 1.5, 5];
x = -20:2.5:20; %sampling points for which features will be generated

format long;    %for increasing the number of significant digits

%% Parameters for creating the massive dataset
noise_rem = 10;
nconst_count = 7;   %number of noisy samples of this type per noise-free sample
nscaled_count = 0;
no_samples = 10000; %Total number of noisefree samples
sd_max = 5;   %maximum noise defined as standard deviation
sd_fix = 0; %this defines the lower bound and the noise is randomly generated
            %based on sd above this value and lower than sd_max
            
%File for writing the data
fid = fopen('train_data/SP_data_sd_5_0_2.dat', 'w');    %file for writing the training data
k = 0; %sample count

for itr = 1:1:no_samples
    randN = rand(1, 5); % 5 random no's to generate a model from 5D space mentioned above
    paramV = lb + (ub - lb).*randN; %random model chosen
    V = SP_sphere(x, paramV(1), paramV(2), paramV(3), paramV(4), paramV(5));    %sample generated
    
    %adding the noise-free data, first the input is added to file, and in
    %next line output is added. Since this is noisefree data, input is same
    %as output.
    fprintf(fid, '%f\t', V);
    fprintf(fid, '\n');
    fprintf(fid, '%f\t', V);
    fprintf(fid, '\n');
    k = k+1;
    
    if (100 - mod(itr, 100)) > 100
        continue;
    end
    %adding constant noise data sd b/w 0.2 and 1
    for j = 1:1:nconst_count
        sd = sd_max *rand(1);   %deciding the noise amount randomly
        V1 = add_noise(V, sd, 'constant', sd_fix); %adds noise
        
        %adding the constant noise data
        fprintf(fid, '%f\t', V1);
        fprintf(fid, '\n');
        fprintf(fid, '%f\t', V);
        fprintf(fid, '\n');
        k = k+1;
    end

    %adding scaled noise data sd b/w 0.2 and 1
    for j = 1:1:nscaled_count
        sd = sd_max *rand(1);
        V1 = add_noise(V, sd, 'scaled', sd_fix); 
        
        %adding the scaled noise data
        fprintf(fid, '%f\t', V1);
        fprintf(fid, '\n');
        fprintf(fid, '%f\t', V);
        fprintf(fid, '\n');
        k = k+1;
    end
end

fclose(fid);