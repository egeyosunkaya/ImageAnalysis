function hcd = getHighComplexityDistance(image,labels,labelGraph,gradient,labelSet1,labelSet2)
Dmin = Inf;
Dg = Inf;

for i = labelSet1
    for j = labelSet2
        Dmin = min(Dmin, getColorDistance(image,labels,gradient,i,j));
        Dg = min(Dg, getGraphDistanceSingle(labelGraph,i,j));
    end
end

hcd = 0.4*Dg + Dmin;


end

