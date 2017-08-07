%% This function adds upto n% normal noise

function yn = add_noise(y, dev, noiseType, min_dev)

if nargin == 3
    min_dev = 0;
end
% dev is the deviation in the Gaussian set that you want to have
    len = length(y);
    randno = min_dev + (dev-min_dev) * randn(len, 1);   % Generates random no. approx b/w 0 and 1
    randno = (randno./10);
    randno2 = rand(size(randno));
    randno2(randno2 > 0.5) = 1;
    randno2(randno2 <= 0.5) = 0;
    randno = randno .* randno2;
    if strcmp(noiseType, 'scaled') == 1
        yn = y.*(1 + randno); %scaled with signal amplitude
    elseif strcmp(noiseType, 'constant') == 1
        ymean = sum(y)/len;
        yn = y + ymean*randno;
    elseif strcmp(noiseType, 'uniform') == 1
        randno = (rand(len, 1) * (dev/5)) - 0.3;
        randno = 1 + randno;
        ymean = sum(y)/len;
        yn = y .*randno;
    elseif strcmp(noiseType, 'masked') == 1
        dev_frac = ceil(dev * len / 100);
        mute_indices = ceil(rand(dev_frac, 1) * len);
        yn = y;
        yn(mute_indices) = 0;
    end
end
    
    
    