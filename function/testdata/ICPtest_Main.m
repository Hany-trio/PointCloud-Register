%% ICP测试
clc
clear
close all

% 测试数据 plane pc2 的 line3 与 pc1 的 line1 对应

pc1 = load('Cloudrabbit_BoundaryCharacteristic1.mat');
pc2 = load('Cloudrabbit_BoundaryCharacteristic2.mat');

% pc1 = load('Cloud_BoundaryCharacteristic1.mat');
% pc2 = load('Cloud_BoundaryCharacteristic2.mat');

% pc1 = load('Cloudvase_BoundaryCharacteristic1.mat');
% pc2 = load('Cloudvase_BoundaryCharacteristic2.mat');
pc3 = load('Cloudvase_BoundaryCharacteristic3.mat');
pc1 = pc1.Cloud_BoundaryCharacteristic;
pc2 = pc2.Cloud_BoundaryCharacteristic;
pc3 = pc3.Cloud_BoundaryCharacteristic;

T1 = [0.968458831310, -0.011062988080, 0.248927801847, -0.078558669612;
         0.129724740982, 0.875332295895, -0.465794831514, 0.044954695255;
        -0.212741464376, 0.483395218849, 0.849158465862, -0.025749759749;
         0.000000000000, 0.000000000000, 0.000000000000, 1.000000000000 ];
T2 = [  0.952760636806, -0.230023920536, -0.198333472013,  0.212705522776;
        0.200779810548, -0.012966368347,  0.979550600052, -0.360413640738;
       -0.227891728282, -0.973098576069,  0.033830314875,  0.333040863276;
        0.000000000000,  0.000000000000,  0.000000000000,  1.000000000000];
T3 = [  1, 0, 0,  0;
        0, 1, 0,  0.02;
        0, 0, 1,  0;
        0.000000000000,  0.000000000000,  0.000000000000,  1.000000000000];
    
%     
%     Line_1 = load('Line_1.mat');
%     Line_2 = load('Line_2.mat');
    
%     Line_1.Line_1.Normal
%     
%     
%     pc1.Lines(3).Line = Line_1.Line_1.Line;
%     pc1.Lines(3).Normal = Line_1.Line_1.Normal;
%     
%     pc2.Lines(4).Line = Line_2.Line_1.Line;
%     pc2.Lines(4).Normal = Line_2.Line_1.Normal;
    
        
    PC_Mult_PCdataset_Lineshow(pc1,3)
    PC_Mult_PCdataset_Lineshow(pc2,4)
    
%     

    
    
Tran_pc2 = TransForm_Dataset( pc2 , T1 );
% Tran_pc3 = TransForm_Dataset( pc3 , T2 );
% FTran_pc3 = TransForm_Dataset( pc3 , T3 );
% figure(1)
% PC_one_pcdatashow(Tran_pc)

% close all
% 

% pc = Spliced(pc2,pc3,1,3);
% 
% PC_Mult_pcdatasetshow(pc)

% PC_Mult_PCdataset_Lineshow(pc1,3)
% PC_Mult_PCdataset_Lineshow(Tran_pc2,4)
% PC_Mult_PCdataset_Lineshow(FTran_pc3,3)

% pcshow(pc2.CloudPoint,[1,0,0],'MarkerSize',3);
% pcshow(FTran_pc3.CloudPoint,[0,0,1],'MarkerSize',3);
% 

% close all

[T_] = Splicing(pc1,Tran_pc2,3,4,'ICP');



close all

DTran_pc2 = TransForm_Dataset( Tran_pc2 , T_ );
PC_Mult_PCdataset_Lineshow(pc1,3);
PC_Mult_PCdataset_Lineshow(DTran_pc2,4);

close all

PC_Mult_PCdataset_Lineshow(pc3,4);
PC_Mult_PCdataset_Lineshow(DTran_pc3,4);

1
close all

[T] = Splicing(pc2,Tran_pc3,1,3);

DTran_pc3 = TransForm_Dataset( Tran_pc3 , T );

% close all
% PC_Mult_PCdataset_Lineshow(pc2,1)
% PC_Mult_PCdataset_Lineshow(DTran_pc3,3)
% 
% close all

pc = Spliced(pc2,DTran_pc3,1,3);

% PC_Mult_pcdatasetshow(pc)

% [T_] = Splicing(pc,Tran_pc1,4,1);
% [T_] = Splicing(DTran_pc3,Tran_pc1,4,1);
[T_] = Splicing(Tran_pc1,DTran_pc3,1,4);

DTran_pc1 = TransForm_Dataset( Tran_pc1 , T_^-1 );


% DTran_pc1 = TransForm_Dataset( Tran_pc1 , T_ );
TTran_pc1 = TransForm_Dataset( Tran_pc1 , T1^-1 );

% PC_Mult_pcdatasetshow(DTran_pc1)
% PC_Mult_pcdatasetshow(pc)

close all

% PC_Mult_PCdataset_Lineshow(pc,4);
% PC_Mult_PCdataset_Lineshow(DTran_pc3,3);
% PC_Mult_PCdataset_Lineshow(pc2,1);
PC_Mult_PCdataset_Lineshow(TTran_pc1,1);
PC_Mult_PCdataset_Lineshow(DTran_pc1,1);

% vase pc1 1 与 pc3 的 4
% vase pc2 1 与 pc3 的 3

% 

% PC_Mult_pcdatasetshow(pc1);
% PC_Mult_pcdatasetshow(pc2);
% PC_Mult_pcdatasetshow(pc3);




1


function normal = Reguation(normal)

      LengthNormal = length(normal);
      
      for i = 1 : LengthNormal
          
           norms = norm(normal(i,:));
           
           normal( i ,: ) = normal(i,:) ./ norms;  
          
            
          
      end
      
       
       
       

end








