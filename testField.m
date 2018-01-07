 
NAME = '000026.jpg';
LABEL     = "Labels/label_" + NAME + ".mat";
LABEL_NUM = "Labels/label_number_" + NAME + ".mat";
PATH_IMG = "Data/" + NAME;
load(LABEL);
load(LABEL_NUM);
I_ORG = imread(PATH_IMG{1});
I = im2double(I_ORG);
labels = labels + 1;
testRes = getLabelGraph(labels, numlabels);


    



% 
% Iclone = I;
% [rC,cC, ~] = size(I);
% 
% for r=1:rC
%     for c=1:cC
%         tmp = result{labels(r,c)+1};
%         Iclone(r,c,1) = tmp(1,1) / 256;
%         Iclone(r,c,2) = tmp(1,2) / 256;
%         Iclone(r,c,3) = tmp(1,3) / 256;
%     end
% end




iterationCount = ceil(numlabels - 3 );
[resultSet,scores] = mergeAll(I,labels,numlabels , iterationCount);



sorted = sort(scores{1,1},'descend');
for k = 1:3
    s = sorted(1,k);
    ind = find(scores{1,1} == s);
    visualizeSet(I_ORG , labels, scores{1,2}{1,ind});
end





%imshow(Iclone);
%figure; plot(testRes,'NodeLabel', testRes.Nodes.Name);
 


