function distance = getColorDistance(image, labels , label1 , label2)
    meanCluster = findMeanColor(image , labels , max(max(labels)) + 1);
    color1 = meanCluster{1,label1};
    color2 = meanCluster{1,label2};
    
    sum = 0;
    for i = 1:3
        sum = ((color1(1,i) - color2(1,i))^2) + sum;
    end
    
    distance = sqrt(sum);
end

