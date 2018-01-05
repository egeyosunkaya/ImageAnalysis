function distance = complexityAdaptiveDistance(image,edgeImg, labels , labelCounts , graphDistances ,colorHists,gradient, numLabels, labelSet1 , labelSet2 , labelIndices)
highCompLevel = 0.1;
boundary = 6;

 DL = getLowComplexityDistance(image, labels , graphDistances , colorHists,gradient, labelSet1, labelSet2 , edgeImg , labelIndices);
 DH = getHighComplexityDistance(image,labels , graphDistances , colorHists,gradient, labelSet1, labelSet2 , labelIndices);
 
 rm = 0;
 rn = 0;

 for i = labelSet1
     rm = rm + (double(labelCounts(1,i))) / double(numLabels);
 end
 
 for j = labelSet2
     rn = rn + double(labelCounts(1,j)) / double(numLabels);
 end
 
 Ds = rm + rn;
 temp = (length(labelSet1) + length(labelSet2));
 temp = double(temp) / double(numLabels);
 alpha = -log2(temp);
 temp = double(alpha - boundary) / double(highCompLevel);
 p = double(1 + double(exp(-temp)));
 p = 1.0 / p;
 
 
 
 distance = p*DL +(1-p)*DH + 2*Ds;
end

