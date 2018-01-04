function lcd = getLowComplexityDistance(image,labels,labelGraph,labelSet1,labelSet2)
Dmax = -Inf;
Dg = Inf;
De = 0;

lsum = 0;

for i = labelSet1
    for j = labelSet2
        Dmax = max(Dmin, getColorDistance(image,labels,i,j));
        Dg = min(Dg, getGraphDistanceSingle(labelGraph,i,j));
        [de, l] = calculateEdgeCost(image, labels, i,j);
        lsum = l + lsum;
        De = De + l * de;
    end
end

De = De/lsum;

lcd = Dg + Dmax + De;


end

