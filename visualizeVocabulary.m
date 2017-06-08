
samplesPer = 11
k =  1500
%prefix = '/Volumes/lil kleine/174PS3/sift/friends_000000'
%suffix = '.jpeg.mat'
descriptorSamples = zeros(1,128);
descriptorSamplesImgIn = zeros(1,2);
for i = 60:6671
   
    [descriptors, orients, positions, scales] = getSIFT(i);
    
    [xmax,~] = size(descriptors);
    if xmax >= samplesPer
        i
        randvals = randi([1 xmax],samplesPer,1);
        descriptorSamplesImgIn = [descriptorSamplesImgIn; [i*ones(samplesPer,1) randvals]];
        descriptorSamples = [descriptorSamples; descriptors(randvals,:),];
    end
end


descriptorSamples = descriptorSamples(2:end,:);
descriptorSamplesImgIn = descriptorSamplesImgIn(2:end,:);

[membership,means,~] = kmeansML(k,descriptorSamples');

for i = 1:300
    inds = find(membership == i);
    i
    for j = 1:numel(inds) %get all corresponding
        if j < 26
            nIm = descriptorSamplesImgIn(inds(j),1);
            nD = descriptorSamplesImgIn(inds(j),2);
            
            im = getIm(nIm);
            [descriptors, orients, positions, scales] = getSIFT(nIm);
            
            subplot(5,5,j);
            [patch] = getPatchFromSIFTParameters(positions(nD,:), scales(nD,:), orients(nD,:), rgb2gray(im));
            imshow(patch);
        end
    end
    
    print(gcf, '-djpeg', ['plot' int2str(i)]);

end
