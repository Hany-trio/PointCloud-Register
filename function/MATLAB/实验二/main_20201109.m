%%  main 20201109 实验二 使用边界提取算法提取边界拐点

clc
clear
close all

cloud3=pcread('rabbit_Segment_20201217_testdata1.pcd');
pt3=cloud3.Location;
% pcshow(pt3,[0,0,0],'MarkerSize',1);
% hold on

%% 边界提取
Boundary = BoundaryExtraction(pt3);

%% 边界噪点剔除
 
% Boundary = Boundary_NoiseElimination(pt3,Boundary);
figure(1)
pcshow(pt3(Boundary(:,2),1:3),[0,1,0],'MarkerSize',10);
hold on 
pcshow(pt3,[0,0,0],'MarkerSize',5);

%% 拐点提取
TurningPoint = Detection_TurningPoint( pt3 , Boundary );
hold on
pcshow(pt3(TurningPoint,1:3),[1,0,0],'MarkerSize',200);

%% 线提取
[Lines,LinesPoints] = LineExtraction( pt3 , Boundary , TurningPoint ) ;

figure(2)

pcshow(pt3,[0,0,0],'MarkerSize',1);
hold on
pcshow(pt3(Lines(1).Line,:),[1,0,0],'MarkerSize',20);
pcshow(pt3(Lines(2).Line,:),[1,1,0],'MarkerSize',20);
pcshow(pt3(Lines(3).Line,:),[1,0,1],'MarkerSize',20);
pcshow(pt3(Lines(4).Line,:),[0,1,1],'MarkerSize',20);


%% 提取边界法线信息

Lines = NormalExtraction( pt3 , Lines );


Cloud_BoundaryCharacteristic.CloudPoint = pt3;
Cloud_BoundaryCharacteristic.CloudBoundary = pt3(Boundary(:,2),1:3) ;
Cloud_BoundaryCharacteristic.TurningPoint = pt3(TurningPoint,1:3) ;
Lines(1).Line = pt3(Lines(1).Line,1:3) ;
Lines(2).Line = pt3(Lines(2).Line,1:3) ;
Lines(3).Line = pt3(Lines(3).Line,1:3) ;
Lines(4).Line = pt3(Lines(4).Line,1:3) ;
Cloud_BoundaryCharacteristic.Lines = Lines ;

PC_Mult_PCdataset_Lineshow(Cloud_BoundaryCharacteristic,4)

save('Cloudrabbit_BoundaryCharacteristic2.mat','Cloud_BoundaryCharacteristic');

% cloud2 = pt3(Lines(1).Line,1:3);
% cloud2_Normal = Lines(1).Normal;

% figure(3)
% pcshow(pt3,[0,0,0],'MarkerSize',1);
% hold on
% pcshow(cloud2,[1,0,0],'MarkerSize',10);
% quiver3(cloud2(:,1),cloud2(:,2),cloud2(:,3),cloud2_Normal(:,1),cloud2_Normal(:,2),cloud2_Normal(:,3));
% % quiver3(cloud2(:,1),cloud2(:,2),cloud2(:,3),cloud2_Normal(:,1),cloud2_Normal(:,2),cloud2_Normal(:,3));
% % quiver3(cloud2(:,1),cloud2(:,2),cloud2(:,3),cloud2_Normal(:,1),cloud2_Normal(:,2),cloud2_Normal(:,3));
% % quiver3(cloud2(:,1),cloud2(:,2),cloud2(:,3),cloud2_Normal(:,1),cloud2_Normal(:,2),cloud2_Normal(:,3));

% hold off
1
% figure(2)
% pcshow(Subboundary1,[1,0,0],'MarkerSize',100);
% hold on
% pcshow(Subboundary2(1:3,:)',[1,0,0],'MarkerSize',100);
% pcshow(pt3(Lines(1).Line,1:3),[1,0,0],'MarkerSize',100);
% hold on
% pcshow(pt3(Lines(2).Line,1:3),[0,1,0],'MarkerSize',100);
% pcshow(pt3(Lines(3).Line,1:3),[0,0,1],'MarkerSize',100);
% pcshow(pt3(Lines(4).Line,1:3),[1,1,0],'MarkerSize',500);
% hold off








