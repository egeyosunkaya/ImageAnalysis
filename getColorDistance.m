function colortextureDistance= getColorDistance(image, labels,colorHists, orientations, label1 , label2)   
    

    distanceColor = norm(colorHists{1,label1} - colorHists{1,label2},1);
    

    edges = -25:5:25;
    
    
    oHist1 = orientations(label1,:,:);
    oHist2 = orientations(label2,:,:);
    


   
    
    hist1 = zeros(24,10);
    hist2 = zeros(24,10);
    
    
    for i = 1:8
        for j = 1:3
            for k = 1:10
                hist1((i-1) * 3 + j ,k) = oHist1{1,j,i}(1,k);
                hist2((i-1) * 3 + j ,k) = oHist2{1,j,i}(1,k);
            end
        end
    end

  
    
    distanceTexture = norm((hist1 - hist2),1);
    colortextureDistance = distanceColor + distanceTexture;
end

