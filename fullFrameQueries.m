histograms = zeros(6671,1500);
load('kMeans.mat');
%bignum = 0;
try
    load('histograms.mat');
catch
    for i = 60:6671
        i
        [descriptors, ~, ~, ~] = getSIFT(i);
        histograms(i,:) = transpose(getHistogram(descriptors,kMeans));
    end
end


for j = [70 3000 6000]
    P = histograms(j,:);
    comparisons = zeros(6671,1);%bignum*ones(6671,1);
    
    for i = 60:6671
        if i == j
            continue
        end
        W = transpose(histograms(i,:));
        comparisons(i,:) = dot(P,W)/(norm(P)*norm(W));
    end
    
    for i = 1:6671
        if isnan(comparisons(i,:))
            comparisons(i,:) = 0;
        end
    end
    
    
    sortedComparisons = sort(comparisons,'descend');
    closestNSP = sortedComparisons(1:5);
    
    subplot(3,2,1)
    imshow(getIm(j));
    for i = 1:5
        closeImNum = find(comparisons == closestNSP(i));
        subplot(3,2,i+1);
        imshow(getIm(closeImNum));
    end
    
    print(gcf, '-djpeg', ['query' int2str(j)]);

    
end
clf