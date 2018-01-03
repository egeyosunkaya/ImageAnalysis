
NAME = '000355.jpg';
LABEL     = "Labels/label_" + NAME + ".mat";
LABEL_NUM = "Labels/label_number_" + NAME + ".mat";
PATH_IMG = "Data/" + NAME;
load(LABEL);
load(LABEL_NUM);
I = im2double(imread(PATH_IMG{1}));
testRes = getLabelGraph(labels, numlabels);

[result,pixCount] = findMeanColor(I,labels,numlabels);

Iclone = I;
[rC,cC, ~] = size(I);

for r=1:rC
    for c=1:cC
        tmp = result{labels(r,c)+1};
        Iclone(r,c,1) = tmp(1,1) / 256;
        Iclone(r,c,2) = tmp(1,2) / 256;
        Iclone(r,c,3) = tmp(1,3) / 256;
    end
end


a = getColorDistance(I , labels , 3 , 12);

%imshow(Iclone);
%figure; plot(testRes,'NodeLabel', testRes.Nodes.Name);
 


