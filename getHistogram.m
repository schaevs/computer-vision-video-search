function histogram = getHistogram(descriptors, kMeans)
    k = 1500;
    d2 = dist2(kMeans', descriptors);
    closestWordDist = min(d2);
    correspondingWord = zeros(numel(closestWordDist),1);
    
    for i = 1:numel(closestWordDist)
        correspondingWord(i) = find( d2(:,i) == closestWordDist(i) );
    end
    
    [histogram,~]  = histc(correspondingWord, 1:1500);
    