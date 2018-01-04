function distance = complexityAdaptiveDistance(image , labels , graph , numLabels, labelSet1 , labelSet2 , highCompLevel, boundary)
 DL = getLowComplexityDistance(image, labels , graph , labelSet1, labelSet2);
 DH = getHighComplexityDistance(image,labels , graph , labelSet1, labelSet2);
 
 rm = 0;
 rn = 0;
 for i = labelSet1
     rm = rm + (nnz(labels(labels == i)) / nnz(labels));
 end
 
 for j = labelSet2
     rn = rn + (nnz(labels(labels == j)) / nnz(labels));
 end
 
 Ds = rm + rn;
 temp = (length(labelSet1) + length(labelSet2));
 temp = double(temp) / double(numLabels);
 alpha = -log2(temp);
 temp = double(alpha - boundary) / double(highCompLevel);
 p = (1 + exp(-temp));
 p = 1 / p;
 
 
 
 distance = p*DL +(1-p)*DH + 2*Ds;
end

