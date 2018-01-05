
close all;
I = im2double(imread('Data/000710.jpg'));
[labels,numlabels] = getSPLabels(I,100,2,10);
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

imshowpair(I, Iclone, 'montage')