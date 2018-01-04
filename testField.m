
NAME = '000355.jpg';
LABEL     = "Labels/label_" + NAME + ".mat";
LABEL_NUM = "Labels/label_number_" + NAME + ".mat";
PATH_IMG = "Data/" + NAME;
load(LABEL);
load(LABEL_NUM);
I_ORG = imread(PATH_IMG{1});
I = im2double(I_ORG);
testRes = getLabelGraph(labels, numlabels);

% realDistances = getGraphDistance(testRes,numlabels);
realDistances = getGraphDistanceSingle(testRes,1,2);

[result,pixCount] = findMeanColor(I,labels,numlabels);

Iclone = I;
[rC,cC, ~] = size(I);

for r=1:rC
    for c=1:cC
        tmp = result{labels(r,c)+1};
        Iclone(r,c,1) = tmp(1,1) / 256;
        Iclone(r,c,2) = tmp(1,2) / 256;
        Iclone(r,c,3) = tmp(1,3) / 256;
    end
end

%resultShouldBeZero = calculateEdgeCost(I_ORG, labels, 1, 3);
%resultShouldNOTBeZero = calculateEdgeCost(I_ORG, labels, 1, 2);


%Initialization for sets
sets = cell(1,numlabels);
numSets = numlabels;
for i = 1:numlabels
    sets{1,i} = i;
end


minDist = Inf;
set1Index = -1;
set2Index = -1;
%Constants from the paper
highCompLevel = 0.1;
boundary = 6;
%Graph 
graph = testRes;


%Just define de sets here it can either be multiple superpixel labels or
%just 1 label

set1 = [1,2];
set2 = 8;

d = complexityAdaptiveDistance(I , labels , graph , numlabels, set1 , set2, highCompLevel, boundary);



% FOR ACTUAL CODE DONT DELETE PLS

% for i = 1:numSets
%     for j = i:numSets
%         set1 = sets{1,i};
%         set2 = sets{1,j};
%         if (~isempty(set1) && ~isempty(set2))
%             d = complexityAdaptiveDistance(I , labels , graph , numlabels, set1 , set2, highCompLevel, boundary);
%             if(d < minDist)
%                 set1Index = i;
%                 set2Index = j;
%                 minDist = d;
%             end
%         end
%         disp(sprintf("%d of %d || i = %f , j = %f , dist = %f" , (i-1) * numSets + j , (numSets*numSets)/2 , i , j , d));
%     end
% end





%imshow(Iclone);
%figure; plot(testRes,'NodeLabel', testRes.Nodes.Name);
 


