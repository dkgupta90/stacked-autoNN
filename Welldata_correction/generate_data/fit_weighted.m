
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
Sh = [0; 0.4];
Vsh = [0.3; 0.7];
%porosity = 0.7 .* ones(size(porosity));
Csand = (1 - porosity) .* (1 - Vsh);
Cclay = (1 - porosity) .* Vsh;
%Chydrate = porosity1 .* Sh1;
%Cwater = porosity1 .* (1 - Sh1);

%% weighted euqation parameters
W = 0.8;
n = 10;

Sh_cal = zeros(size(depth)); % calculated saturation log
Vp_cal = zeros(size(depth));
for i = 1:1:length(depth)
   error = 1e9;
   for S = 0:0.01:1
       Chyd = porosity(i) .* S;
       Cwater = porosity(i) .* (1 - S);
       Vnew = get_weighted_Vp(W, n, density(i), ...
       rhoSand, Vpsand, Csand(i),...
       rhoClay, Vpclay, Cclay(i), ...
       rhoW, Vpw, Cwater, ...
       rhoH, Vph, Chyd,...
       porosity(i), S);
       if (abs(Vnew - Vp(i)) < error)
           Vp_cal(i) = Vnew;
           Sh_cal(i) = S;
           error = abs(Vnew - Vp(i));
       end
   end
end
   
   
   
% plotting the logsuite
plot_logsuite(depth, density, porosity, Vsh, Vp, Vp_cal, Sh_cal);


temp(:, 1) = depth;
temp(:, 2) = density;
temp(:, 3) = porosity; %0.4 .* ones(size(density));
temp(:, 4) = Vsh;
temp(:, 5) = Vp;
temp(:, 6) = Vp_cal;
temp(:, 7) = Sh_cal;
save('../../data/final_synthetic01.dat', 'temp', '-ascii');

