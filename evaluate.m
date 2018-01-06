function [precision,recall] = evaluate(NAME,boundingBoxes, threshold)
tmpName = extractBefore(NAME,'.jpg');
PATH_REAL = "Data/" + tmpName + ".txt";
fileID = fopen(PATH_REAL{1},'r');
formatSpec = ' %d ';
BoundingData = fscanf(fileID,formatSpec);

[realObjectCount,~] = size(BoundingData);
realObjectCount = (realObjectCount - 1)/4;
correctObjects  = 0;
[~,detectedCount] = size(boundingBoxes);

for i=1:detectedCount
    ourBox = boundingBoxes{1,i};
    topX = ourBox(1,1);
    topY = ourBox(1,2);
    lowX = ourBox(1,3);
    lowY = ourBox(1,4);
    for b=1:realObjectCount
        rtopX = BoundingData(1 + (4*(b-1)),1);
        rtopY = BoundingData(2 + (4*(b-1)),1);
        rlowX = BoundingData(3 + (4*(b-1)),1);
        rlowY = BoundingData(4 + (4*(b-1)),1);
        ourBox  = [ topX,   topY,   lowX-topX, lowY-topY  ];
        realBox = [ rtopX, rtopY, rlowX-rtopX, rlowY-rtopY];
        overlapRatio = bboxOverlapRatio(ourBox,realBox);
        if overlapRatio > threshold
            correctObjects = correctObjects + 1;
            break;
        end
    end
end


recall = correctObjects /realObjectCount ;
precision = correctObjects /detectedCount ;
end

