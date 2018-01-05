function sets = mergePixels(I, labels , graph ,colorHists, gradient , sets)
minDist = Inf;
highCompLevel = 0.1;
boundary = 6;
numSets = length(sets);
numlabels = max(max(labels));
for i = 1:numSets
    for j = i+1:numSets
        set1 = sets{1,i};
        set2 = sets{1,j};
        if (~isempty(set1) && ~isempty(set2))
            d = complexityAdaptiveDistance(I , labels , graph ,colorHists,gradient, numlabels, set1 , set2, highCompLevel, boundary);
            if(d < minDist)
                set1Index = i;
                set2Index = j;
                minDist = d;
            end
        end
        disp(sprintf("%d of %d || i = %f , j = %f , dist = %f" , (i-1) * numSets + j , (numSets*numSets)/2 , i , j , d));
    end
end

sets{1,set1Index} = cat(2,sets{1,set1Index},sets{1,set2Index});
sets(:,set2Index) = [];
end

