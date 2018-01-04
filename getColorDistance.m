function colortextureDistance= getColorDistance(image, labels , label1 , label2)
    [row1,col1] = find(labels == label1);
    [row2,col2] = find(labels == label2);
    edges = 0:1/20:1;
    
   
    rc1 = cat(2, row1,col1);

    rc2 = cat(2, row2,col2);
    
    
    ir1 = zeros(size(rc1,1) ,1);
    ig1 = zeros(size(rc1,1) ,1);
    ib1 = zeros(size(rc1,1), 1);
    
    ir2 = zeros(size(rc2,1) , 1);
    ig2 = zeros(size(rc2,1) , 1);
    ib2 = zeros(size(rc2,1) , 1);
    
    
    for i = 1:size(rc1,1)
        ir1(i,1) = image(rc1(i,1),rc1(i,2) ,1);
        ig1(i,1) = image(rc1(i,1),rc1(i,2) ,2);
        ib1(i,1) = image(rc1(i,1),rc1(i,2) ,3);
    end
    
    for j = 1:size(rc2,1)
        ir2(j,1) = image(rc2(j,1),rc2(j,2) ,1);
        ig2(j,1) = image(rc2(j,1),rc2(j,2) ,2);
        ib2(j,1) = image(rc2(j,1),rc2(j,2) ,3);
    end
    
    
    
    
    r1 = histcounts(ir1,edges);
    r1= r1 / sum(r1);
    g1 = histcounts(ig1,edges);
    g1= g1 / sum(g1);
    b1 = histcounts(ib1,edges);
    b1= b1 / sum(b1);
    r2 = histcounts(ir2,edges);
    r2 = r2 / sum(r2);
    g2 = histcounts(ig2,edges);
    g2 = g2 / sum(g2);
    b2 = histcounts(ib2,edges);
    b2 = b2 / sum(b2);
    
    rgb1 = cat(1, r1 , g1 , b1);
    rgb2 = cat(1, r2 , g2 , b2);

    distanceColor = norm(rgb1 - rgb2,1);
    
    %WTF?
    sigma = 0.5;
    
    Wx = floor((5/2)*sigma); 
    if Wx < 1
      Wx = 1;
    end
    x = -Wx:Wx;

    % Evaluate 1D Gaussian filter (and its derivative).
    g = exp(-(x.^2)/(2*sigma^2));
    gp = -(x/sigma).*exp(-(x.^2)/(2*sigma^2));
    
    irfx = convolve2(convolve2(image(:,:,1),-gp,'same'),g','same');
    irfy = convolve2(convolve2(image(:,:,1),g,'same'),-gp','same');
    
    igfx = convolve2(convolve2(image(:,:,2),-gp,'same'),g','same');
    igfy = convolve2(convolve2(image(:,:,2),g,'same'),-gp','same');
    
    ibfx = convolve2(convolve2(image(:,:,3),-gp,'same'),g','same');
    ibfy = convolve2(convolve2(image(:,:,3),g,'same'),-gp','same');
    
    
    orientations = cell(3,8);
    i = 1;
    for angle = 0:45:315
        orientations{1,i} = cos(angle*(pi/180))*irfx+sin(angle*(pi/180))*irfy;
        orientations{2,i} = cos(angle*(pi/180))*igfx+sin(angle*(pi/180))*igfy;
        orientations{3,i} = cos(angle*(pi/180))*ibfx+sin(angle*(pi/180))*ibfy;
        i = i + 1;
    end
    
    
    oHist1 = cell(3,8);
    oHist2 = cell(3,8);
    
    for o = 1:8
        matr = orientations{1,o};
        matg = orientations{2,o};
        matb = orientations{3,o};
        for i = 1:size(rc1,1)
            oHist1{1,o}(1,i) = matr(rc1(i,1),rc1(i,2));
            oHist1{2,o}(1,i) = matg(rc1(i,1),rc1(i,2));
            oHist1{3,o}(1,i) = matb(rc1(i,1),rc1(i,2));
        end
    end
    
    for o = 1:8
        matr = orientations{1,o};
        matg = orientations{2,o};
        matb = orientations{3,o};
        for i = 1:size(rc2,1)
            oHist2{1,o}(1,i) = matr(rc2(i,1),rc2(i,2));
            oHist2{2,o}(1,i) = matg(rc2(i,1),rc2(i,2));
            oHist2{3,o}(1,i) = matb(rc2(i,1),rc2(i,2));
        end
    end
    
    
    edges = -25:5:25;
    
    for o = 1:8
        for color = 1:3
            oHist1{color, o} = histcounts(oHist1{color,o},edges);
            oHist1{color,o} = oHist1{color, o} / sum(oHist1{color, o});
            oHist2{color, o} = histcounts(oHist2{color,o},edges);
            oHist2{color,o} = oHist2{color, o} / sum(oHist2{color, o});
        end
    end

   
    
    hist1 = zeros(24,10);
    hist2 = zeros(24,10);
    
    
    for i = 1:8
        for j = 1:3
            for k = 1:10
                hist1(i * j,k) = oHist1{j,i}(1,k);
                hist2(i * j,k) = oHist2{j,i}(1,k);
            end
        end
    end
    
    
    
    
   

    
    
    
    
    
    
    distanceTexture = norm((hist1 - hist2),1);
    colortextureDistance = distanceColor + distanceTexture;
end

