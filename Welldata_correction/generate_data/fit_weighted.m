
clc;
clear all;

%% Values of constituent parameters used
rhoSand = 2700;
rhoClay = 2600;
rhoH = 920;
rhoW = 1030;
Vpsand = 6040;
Vpclay = 3410;
Vph = 3700;
Vpw = 1500;

%% Parameter range for generating synthetic data
Sh = [0; 0.2];
Vsh = [0.5; 0.8];
porosity = [0.3; 0.6];

%% weighted euqation parameters
W = 0.9;
n = 2;

%% Generate random Sh and Vsh logs

depth = 0.1:0.1:100;
no_samples = length(depth); % no of random samples

Sh_log = generate_log(Sh, no_samples);
Vsh_log = generate_log(Vsh, no_samples);
porosity_log = generate_log(porosity, no_samples);

Csand = (1 - porosity_log) .* (1 - Vsh_log);
Cclay = (1 - porosity_log) .* Vsh_log;
Chydrate = porosity_log .* Sh_log;
Cwater = porosity_log .* (1 - Sh_log);

density_log = get_bulk_density(rhoSand, Csand,...
       rhoClay, Cclay, ...
       rhoW, Cwater, ...
       rhoH, Chydrate);


Vp_log = get_weighted_Vp(W, n, density_log, ...
rhoSand, Vpsand, Csand,...
rhoClay, Vpclay, Cclay, ...
rhoW, Vpw, Cwater, ...
rhoH, Vph, Chydrate,...
porosity_log, Sh_log);

maxden = max(density_log)
minden = min(density_log)
maxVp = max(Vp_log)
minVp = min(Vp_log)
   
   
   
% plotting the logsuite
plot_logsuite(depth, density_log, porosity_log, Vsh_log, Vp_log, Vp_log, Sh_log);


temp(:, 1) = depth;
temp(:, 2) = density_log;
temp(:, 3) = porosity_log; %0.4 .* ones(size(density));
temp(:, 4) = Vsh_log;
temp(:, 5) = Vp_log;
temp(:, 6) = Vp_log;
temp(:, 7) = Sh_log;
save('../data/final_synthetic02.dat', 'temp', '-ascii');

