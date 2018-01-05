function distance = complexityAdaptiveDistance(image,edgeImg, labels , labelCounts , graphDistances ,colorHists,gradient, numLabels, labelSet1 , labelSet2 , labelIndices)
highCompLevel = 0.1;
boundary = 5.6;

 DL = getLowComplexityDistance(image, labels , graphDistances , colorHists,gradient, labelSet1, labelSet2 , edgeImg , labelIndices);
 DH = getHighComplexityDistance(image,labels , graphDistances , colorHists,gradient, labelSet1, labelSet2 , labelIndices);
 
 rm = 0;
 rn = 0;
 [sx , sy] = size(labels);
 sz = sx*sy;
 
 if(length(labelSet1) > 6 || length(labelSet2) > 6)
     asd = 4;
 end
 
 for i = labelSet1
     rm = rm + (double(labelCounts(1,i))) / double(sz);
     
 end
 
 for j = labelSet2
     rn = rn + double(labelCounts(1,j)) / double(sz);
 end
 
 Ds = rm + rn;

 
 temp = (length(labelSet1) + length(labelSet2));
 temp = double(temp) / double(numLabels);
 alpha = double(-1*double(log2(temp)));
 temp = double(boundary - alpha) / double(highCompLevel);
 p = double(1 + double(exp(temp)));
 p = double(1.0 / double(p));

 %p = 1/10;
 
 
 %disp(sprintf("Tm = %d | Tn = %d | p = %0.4f" ,length(labelSet1), length(labelSet2),p));
 distance = p*DL +(1-p)*DH + 4*Ds;
end

