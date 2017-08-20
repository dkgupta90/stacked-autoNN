% this function plots the log suite for the given logs

function status = plot_logsuite(depth, density, porosity, Vsh, Vp, Vp_cal, Sh_cal)

nplots = 5;
% density
subplot(1, nplots, 1);
plot(density, -depth);
title('density');

% porosity
subplot(1, nplots, 2);
plot(porosity, -depth);
title('porosity');

% shalevolume
subplot(1, nplots, 3);
plot(Vsh, -depth);
title('Shale volume');

% velocity
subplot(1, nplots, 4);
plot(Vp, -depth);
hold on;
plot(Vp_cal, -depth, 'r');
hold off;
title('P-wave velocity');

% hydrate volume
subplot(1, nplots, 5);
plot(Sh_cal, -depth);
title('Gas hydrate sat.');

end