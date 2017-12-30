
img = imread('bee.jpg');
[labels, numlabels] = getSPLabels(img,500,1,10);%numlabels is the same as number of superpixels
figure;
imagesc(label2rgb(labels));