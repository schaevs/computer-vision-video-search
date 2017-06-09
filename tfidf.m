load('kMeans.mat');
try
    load('histograms.mat');
catch
    histograms = zeros(6671,1500);
    for i = 60:6671
        i
        [descriptors, ~, ~, ~] = getSIFT(i);
        histograms(i,:) = transpose(getHistogram(descriptors,kMeans));
    end
end

%sums = sum(histograms);
try
    load('tfidfM.mat');
catch    
    N = 6671-60+1;
    tfidfM = zeros(size(histograms));
    for d = 60:6671
        d
        nd = sum(histograms(d,:)); %num words in document d
        for i = 1:1
            nid = histograms(d,i); %number of occurences of word i in document d
            ni = numel(find(histograms(:,i)>0)); %number of documents containing word i
            tfidfM(d,i) = (nid/nd)*log(N/ni);
        end
    end
end


%%find and delete stop words from tfidfM
freq = zeros(1500,1);
for i = 1:1500
    freq(i,:) = numel(find(histograms(:,i)>0));
end
topFreq = sort(freq,'descend');

for i = 1:500 %delete 500 most frequent words
    find(freq == topFreq(i));
    tfidfM(:, find(freq == topFreq(i))) = [] ;
    freq(find(freq == topFreq(i)),:) = [] ;
end


%%query region
for j = [ 410 ]
    [descriptorsQ, orientsQ, positionsQ, scalesQ] = getSIFT(j);
    indQ = selectRegion(getIm(j), positionsQ);
    print(gcf, '-djpeg', ['tfidfregionQueryQim' int2str(j)]);
    clf
    descriptorsQselected = descriptorsQ(indQ,:);
    
    P = tfidfM(j,:);
    %getHistogram(descriptorsQselected,kMeans);
    comparisons = zeros(6671,1);%bignum*ones(6671,1);
    
    for i = 60:6671
        if i == j
            continue
        end
        W = transpose(tfidfM(i,:));
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
    
    print(gcf, '-djpeg', ['tfidfregionQuery' int2str(j)]);
    clf
    
end

