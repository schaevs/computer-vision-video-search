function verifiedResults = spatialVerification(qImNum, topNums)
    verifiedResults = [];
    for i = topNums
        samplesPer = 100
        k =  1500
        descriptorSamples = zeros(1,128);
        descriptorSamplesImgIn = zeros(1,2);

        %for each image, randomly sample @samplesPer descriptors
        for j = topNums
            topNums
            j
            [descriptors, orients, positions, scales] = getSIFT(j);

            [xmax,~] = size(descriptors);
            if xmax >= samplesPer
                j
                randvals = randi([1 xmax],samplesPer,1);
                descriptorSamplesImgIn = [descriptorSamplesImgIn; [j*ones(samplesPer,1) randvals]];
                descriptorSamples = [descriptorSamples; descriptors(randvals,:),];
            end
        end


        descriptorSamples = descriptorSamples(2:end,:);
        descriptorSamplesImgIn = descriptorSamplesImgIn(2:end,:);

        [membership,kMeans,~] = kmeansML(k,descriptorSamples');
        
        histograms = zeros(numel(topNums),128);
        [descriptorsQ, orientsQ, positionsQ, scalesQ] = getSIFT(topNums(j))
        
        normprods = zeros(numel(topNums),1);
        for j = numel(topNums)
            [descriptors, orients, positions, scales] = getSIFT(topNums(j))
            histograms(j,:) = getHistogram(descriptors,kMeans)
            normprods(j,:) = dot(transpose(histograms(j,:)), getHistogram(descriptorsQ,kMeans))/(norm(transpose(histograms(j,:))));
        end
        
        sorted = sort(normprods);
        
        verifiedResults = [ topNums(find(normprods == sorted(1))) verifiedResults ];
        topNums = topNums(1:end-1);
        
    end