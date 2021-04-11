function PC_Mult_pcdatasetshow(pc1)
  
    pt1 = pc1.CloudPoint;
%     BoundaryPoints1 = pc1.CloudBoundary;
%     TurningPoints1 = pc1.TurningPoint;
    
%     figure(1)
%     pcshow( pt1 , [0,0,0] , 'MarkerSize' , 1 );
%     hold on
%     pcshow( BoundaryPoints1 , [0,1,0] , 'MarkerSize' , 10 );
%     pcshow( TurningPoints1 , [1,0,0] , 'MarkerSize' , 20 );
%     hold off
% 
%     figure(2)
%     pcshow( pt1 , [0,0,0] , 'MarkerSize' , 1 );
%     hold on
%     pcshow( pc1.Lines(1).Line , [1,0,0,] , 'MarkerSize' , 10);
%     pcshow( pc1.Lines(2).Line , [0,1,0,] , 'MarkerSize' , 10);
%     pcshow( pc1.Lines(3).Line , [1,0,1,] , 'MarkerSize' , 10);
%     pcshow( pc1.Lines(4).Line , [0,0,1,] , 'MarkerSize' , 10);
%     hold off
%     
    LinePoint1 = pc1.Lines(1).Line ; Line_Normal1 = pc1.Lines(1).Normal ;
    LinePoint2 = pc1.Lines(2).Line ; Line_Normal2 = pc1.Lines(2).Normal ;
    LinePoint3 = pc1.Lines(3).Line ; Line_Normal3 = pc1.Lines(3).Normal ;
    LinePoint4 = pc1.Lines(4).Line ; Line_Normal4 = pc1.Lines(4).Normal ;
    
    pcshow( pt1 , [0,0,0] , 'MarkerSize' , 1 );
    hold on
    pcshow( pc1.Lines(1).Line , [1,0,0,] , 'MarkerSize' , 10);
    pcshow( pc1.Lines(2).Line , [0,1,0,] , 'MarkerSize' , 10);
    pcshow( pc1.Lines(3).Line , [1,0,1,] , 'MarkerSize' , 10);
    pcshow( pc1.Lines(4).Line , [0,0,1,] , 'MarkerSize' , 10);
    quiver3(LinePoint1(:,1),LinePoint1(:,2),LinePoint1(:,3),Line_Normal1(:,1),Line_Normal1(:,2),Line_Normal1(:,3));
    quiver3(LinePoint2(:,1),LinePoint2(:,2),LinePoint2(:,3),Line_Normal2(:,1),Line_Normal2(:,2),Line_Normal2(:,3));
    quiver3(LinePoint3(:,1),LinePoint3(:,2),LinePoint3(:,3),Line_Normal3(:,1),Line_Normal3(:,2),Line_Normal3(:,3));
    quiver3(LinePoint4(:,1),LinePoint4(:,2),LinePoint4(:,3),Line_Normal4(:,1),Line_Normal4(:,2),Line_Normal4(:,3));

end

