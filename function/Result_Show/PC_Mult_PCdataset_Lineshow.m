function PC_Mult_PCdataset_Lineshow(pc1,A)

    % A 为显示的边的索引

    lengthA = length( A );  
    pt1 = pc1.CloudPoint;
    
    pcshow( pt1 , [0,0,0] , 'MarkerSize' , 1 );
    hold on

    for i = 1 : lengthA        
        
        indx = A(i); 
        
        LinePoint1 = pc1.Lines(indx).Line ; Line_Normal1 = pc1.Lines(indx).Normal ;
        pcshow( pc1.Lines(indx).Line , [0,1,0,] , 'MarkerSize' , 20);
%         quiver3(LinePoint1(:,1),LinePoint1(:,2),LinePoint1(:,3),Line_Normal1(:,1),Line_Normal1(:,2),Line_Normal1(:,3));
        
    end
    

end
