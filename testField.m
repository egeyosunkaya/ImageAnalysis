
NAME = '000215.jpg';
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




iterationCount = numlabels - 5;
resultSet = mergeAll(I,labels,numlabels , iterationCount);

reslabels = labels;
for i = 1:length(resultSet)
    for j = 2:length(resultSet{1,i})
        reslabels(reslabels == resultSet{1,i}(1,j)) = resultSet{1,i}(1,1);
        
    end
    
end



figure;
imshowpair(I_ORG, label2rgb(reslabels), 'montage')



%imshow(Iclone);
%figure; plot(testRes,'NodeLabel', testRes.Nodes.Name);
 


