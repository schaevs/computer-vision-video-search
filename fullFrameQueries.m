histograms = zeros(6671,1500);
load('kMeans.mat');
for i = 60:6671
    i
    [descriptors, ~, ~, ~] = getSIFT(i);
    histograms(i,:) = transpose(getHistogram(descriptors,means));
end
    