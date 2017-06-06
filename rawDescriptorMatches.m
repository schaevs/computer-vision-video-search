%selectRegions
%dist2
%display

load('twoFrameData.mat');

ind = selectRegion(im1, positions1);
%[sz,~] = size(ind);
%descriptors12 = zeros(sz,128);

descrptors12 = descriptors1(ind,:);

%for i = 1:sz
 %   descriptors12(i,:) = descriptors1(ind(i),:);
%end

d2 = dist2(descriptors12, descriptors2);



[~, i1] = find(d2 < 0.5);

posMatched1 = [];
scalesMatched1 = [];
orientsMatched1 = [];

for idx = 1:numel(i1)
    %if sum(find(i2(idx)==ind))==0
        element = i1(idx);
        posMatched1 = [posMatched1; positions1(element,:)];
        scalesMatched1 = [scalesMatched1; scales1(element)];
        orientsMatched1 = [orientsMatched1; orients1(element)];
    %end
end

displaySIFTPatches(posMatched1, scalesMatched1, orientsMatched1, im1)

%posMatched2 = positions2(i2);



%for i = max(d2)
 %   pos = [pos find(d2(i,:))];
%end

%displaySIFTPatches(scales2, orients2)
%displaySIFTPatches()