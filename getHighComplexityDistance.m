function hcd = getHighComplexityDistance(image,labels,labelGraph,labelSet1,labelSet2,b)
Dmin = Inf;
Dg = Inf;

for i = labelSet1
    for j = labelSet2
        Dmin = min(Dmin, getColorDistance(image,labels,i,j));
        Dg = min(Dg, getGraphDistanceSingle(labelGraph,i,j));
    end
end

hcd = b*Dg + Dmin;


end

