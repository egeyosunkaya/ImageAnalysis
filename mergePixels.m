function sets = mergePixels(I, edgeImg, labels ,numlabels, graphDistances ,colorHists, oHists , sets,labelIndices)
minDist = Inf;

numSets = length(sets);



labelCounts = zeros(1,numlabels);
for i = 1:numlabels
    labelCounts(1,i) = nnz(labels == i);
end
for i = 1:numSets
    for j = i+1:numSets
        set1 = sets{1,i};
        set2 = sets{1,j};
        if (~isempty(set1) && ~isempty(set2))
            d = complexityAdaptiveDistance(I,edgeImg, labels,labelCounts , graphDistances ,colorHists,oHists, numlabels, set1 , set2, labelIndices);
            if(d < minDist)
                set1Index = i;
                set2Index = j;
                minDist = d;
            end
        end
        disp(sprintf("%d of %d || i = %f , j = %f , dist = %f" , (i-1) * numSets + j , double(numSets*numSets) , i , j , d));
    end
end

sets{1,set1Index} = cat(2,sets{1,set1Index},sets{1,set2Index});
sets(:,set2Index) = [];
end

