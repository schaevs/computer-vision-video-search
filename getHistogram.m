function histogram = getHistogram(frameNum, kMeans)
    prefix = '/Volumes/lil kleine/174PS3/sift/friends_000000';
    suffix = '.jpeg.mat';
    mid = int2str(frameNum);
    if frameNum<1000
        mid = ['0' mid];
    end
    if frameNum<100
        mid = ['0' mid];
    end
    
    filename = [prefix mid suffix];
    load(filename);


    k = 1500
    d2 = dist2(kMeans', descriptors);
    closestWordDist = min(d2);
    correspondingWord = zeros(numel(closestWordDist),1);
    
    for i = 1:numel(closestWordDist)
        correspondingWord(i) = find( d2(:,i) == closestWordDist(i) );
    end
    
    [histY,~]  = histc(correspondingWord, 1:1500);
    
    histogram = histY;
    