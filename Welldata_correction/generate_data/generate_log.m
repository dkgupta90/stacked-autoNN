% This program is used to create log data 

function log_data = generate_log(range, no_samples)

rand_data = rand(no_samples, 1);

% take moving average 3 times
rand_data = movmean(rand_data, 3);
rand_data = movmean(rand_data, 3);
%rand_data = movmean(rand_data, 3);

% Normalize data
maxd = max(rand_data);
mind = min(rand_data);
rand_data = (rand_data - mind) ./ (maxd - mind);
log_data = rand_data .* (range(2) - range(1)) + range(1);

%plot(log_data, 1:no_samples, 'r')

end