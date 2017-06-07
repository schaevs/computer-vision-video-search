%sample many descriptors from the entire data set  AT LEAST 15000 SAMPLES, K = 1500
%DESCRIPTORS
%PICK 2 PATCHES
%25
%pass these descriptors and a K value to kmeansML()
%which will give us the visual words contained in variable "means"
%pick top 25 patches for each cluster by distance from center of cluster
%choose two representative clusters.

samplesPer = 11
k =  1500
prefix = '/Volumes/lil kleine/174PS3/sift/friends_000000'
suffix = '.jpeg.mat'
descriptorSamples = zeros(1,128);
descriptorSamplesImgIn = zeros(1,2);
for i = 60:6671
    mid = int2str(i);
    if i<1000
        mid = ['0' mid];
    end
    if i<100
        mid = ['0' mid];
    end
    
    filename = [prefix mid suffix];
    %m = matfile(filename)
    load(filename);
    
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
extF = '/Volumes/lil kleine/174PS3/frames/';
extS = '/Volumes/lil kleine/174PS3/sift/';
prefix = 'friends_000000';
suffixF = '.jpeg';
suffixS = '.jpeg.mat';
for i = 1:300
    inds = find(membership == i);
    i
    %dist22 = dist2(transpose(means(:,i)),descriptorSamples(i,:));
    
    for j = 1:numel(inds) %get all corresponding
        if j < 26
            nIm = descriptorSamplesImgIn(inds(j),1);
            nD = descriptorSamplesImgIn(inds(j),2);
            
            mid = int2str(nIm);
            if nIm<1000
                mid = ['0' mid];
            end
            if nIm<100
                mid = ['0' mid];
            end
            
            im = imread([extF prefix mid suffixF]);
            load([extS prefix mid suffixS]);
            
            subplot(5,5,j);
            [patch] = getPatchFromSIFTParameters(positions(nD,:), scales(nD,:), orients(nD,:), rgb2gray(im));
            imshow(patch);
        end
    end
    
    print(gcf, '-djpeg', ['plot' int2str(i)])

end
