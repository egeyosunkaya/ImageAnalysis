
NAME = '000012.jpg';
LABEL     = "Labels/label_" + NAME + ".mat";
LABEL_NUM = "Labels/label_number_" + NAME + ".mat";
PATH_IMG = "Data/" + NAME;
load(LABEL);
load(LABEL_NUM);
I_ORG = imread(PATH_IMG{1});
I = im2double(I_ORG);
testRes = getLabelGraph(labels, numlabels);

%GET GRADIENT OF IMAGE FOR COLOR-TEXTURE DISTANCE
sigma = 0.5;

Wx = floor((5/2)*sigma); 
if Wx < 1
  Wx = 1;
end
x = -Wx:Wx;

% Evaluate 1D Gaussian filter (and its derivative).
g = exp(-(x.^2)/(2*sigma^2));
gp = -(x/sigma).*exp(-(x.^2)/(2*sigma^2));

gradient = cell(2,3);

gradient{1,1} = convolve2(convolve2(I(:,:,1),-gp,'same'),g','same');
gradient{2,1} = convolve2(convolve2(I(:,:,1),g,'same'),-gp','same');
    
gradient{1,2}= convolve2(convolve2(I(:,:,2),-gp,'same'),g','same');
gradient{2,2} = convolve2(convolve2(I(:,:,2),g,'same'),-gp','same');

gradient{1,3} = convolve2(convolve2(I(:,:,3),-gp,'same'),g','same');
gradient{2,3} = convolve2(convolve2(I(:,:,3),g,'same'),-gp','same');

irfx = gradient{1,1};
    irfy = gradient{2,1};
    
    igfx = gradient{1,2};
    igfy = gradient{2,2};
    
    ibfx = gradient{1,3};
    ibfy = gradient{2,3};
    
    %%%%%%%%

    orientations = cell(3,8);
    i = 1;
    for angle = 0:45:315
        orientations{1,i} = cos(angle*(pi/180))*irfx+sin(angle*(pi/180))*irfy;
        orientations{2,i} = cos(angle*(pi/180))*igfx+sin(angle*(pi/180))*igfy;
        orientations{3,i} = cos(angle*(pi/180))*ibfx+sin(angle*(pi/180))*ibfy;
        i = i + 1;
    end
    
    edges = -25:5:25;
    oHists = cell(numlabels,3,8);

    
    for l = 1:numlabels
        for o = 1:8
            for color = 1:3
                oHists{l,color, o} = histcounts(orientations{1,o}(labels == l),edges);
                oHists{l,color,o} = oHists{l,color, o} / sum(oHists{l,color, o});
            end
        end
    end
    
    
    %GET COLOR HISTOGRAMS
    
    colorHists = cell(1,numlabels);
    
for l = 0:numlabels-1  
    
    [row1,col1] = find(labels == l);
    edges = 0:1/20:1;
    
   
    rc1 = cat(2, row1,col1);

    
    
    ir1 = zeros(size(rc1,1) ,1);
    ig1 = zeros(size(rc1,1) ,1);
    ib1 = zeros(size(rc1,1), 1);
   
    
    
    for i = 1:size(rc1,1)
        ir1(i,1) = I(rc1(i,1),rc1(i,2) ,1);
        ig1(i,1) = I(rc1(i,1),rc1(i,2) ,2);
        ib1(i,1) = I(rc1(i,1),rc1(i,2) ,3);
    end
     
    
    r1 = histcounts(ir1,edges);
    r1= r1 / sum(r1);
    g1 = histcounts(ig1,edges);
    g1= g1 / sum(g1);
    b1 = histcounts(ib1,edges);
    b1= b1 / sum(b1);
    
    colorHists{1,l+1} = cat(1, r1 , g1 , b1);
    
    
end   
    

% realDistances = getGraphDistance(testRes,numlabels);
realDistances = getGraphDistanceSingle(testRes,1,2);

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

%resultShouldBeZero = calculateEdgeCost(I_ORG, labels, 1, 3);
%resultShouldNOTBeZero = calculateEdgeCost(I_ORG, labels, 1, 2);


%Initialization for sets
sets = cell(1,numlabels);
numSets = numlabels;
for i = 0:numlabels-1
    sets{1,i+1} = i;
end


minDist = Inf;
set1Index = -1;
set2Index = -1;
%Constants from the paper
highCompLevel = 0.1;
boundary = 6;
%Graph 
graph = testRes;
labels = labels + 1;


%Just define de sets here it can either be multiple superpixel labels or
%just 1 label

set1 = 1;
set2 = 488;

%d = complexityAdaptiveDistance(I , labels , graph ,gradient, numlabels, set1 , set2, highCompLevel, boundary);
% 
% 
% 
% FOR ACTUAL CODE DONT DELETE PLS


asdasd = mergePixels(I , labels , graph , colorHists, oHists , sets);



%imshow(Iclone);
%figure; plot(testRes,'NodeLabel', testRes.Nodes.Name);
 


