function im = getIm(nIm)
    extF = '/Volumes/lil kleine/174PS3/frames/';
    extS = '/Volumes/lil kleine/174PS3/sift/';
    prefix = 'friends_000000';
    suffixF = '.jpeg';
    suffixS = '.jpeg.mat';
    mid = int2str(nIm);
    if nIm<1000
        mid = ['0' mid];
    end
    if nIm<100
        mid = ['0' mid];
    end
    im = imread([extF prefix mid suffixF]);