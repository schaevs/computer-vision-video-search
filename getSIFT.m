function [descriptors, orients, positions, scales] = getSIFT(frameNum)
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
    descriptors = descriptors;
    orients = orients;
    positions = positions;
    scales = scales;
    
    