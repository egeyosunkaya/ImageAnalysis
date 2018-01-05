function lcd = getLowComplexityDistance(image,labels,labelGraph,colorHists,gradient,labelSet1,labelSet2)
Dmax = -Inf;
Dg = Inf;
De = 0;

lsum = 0;

for i = labelSet1
    for j = labelSet2
        Dmax = max(Dmax, getColorDistance(image,labels,colorHists,gradient,i,j));
        Dg = min(Dg, getGraphDistanceSingle(labelGraph,i,j));
        [de, l] = calculateEdgeCost(image, labels, i,j);
        lsum = l + lsum;
        De = De + l * de;
    end
end

if(lsum == 0)
    De = 0;
else
    De = De/lsum;
end

lcd = Dg + Dmax + De;


end

