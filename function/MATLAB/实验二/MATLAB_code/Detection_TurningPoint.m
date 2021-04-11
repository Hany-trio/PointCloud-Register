%%  20201113 完成拐点提取 但是象限判断处有bug，需要后期对算法再次更新
%   顺便排除一下非边界的点 换了一个数据

function [TurningPointindx , output_boundaryP] = Detection_TurningPoint(pt3,boundaryP,neighborPs_num,TurPthreshold,Partradius)
    
    %% neighborPs_num 邻近点探测个数
    %  TurPthreshold  拐点探测阈值
    %  Partradius     局部响应半径



    length_boundary_P = length(boundaryP); 
    BoundaryPoints = pt3(boundaryP(:,2),(1:3));
    indx = logical(zeros(length_boundary_P,1));
%     indx1 = logical(ones(length_boundary_P,1));  %排除非边界的点
    for  i = 1 : length_boundary_P
% %         i = 21;
%         i = indx2(j);     
        
        kdtreeobj = KDTreeSearcher(pt3 ,'distance','euclidean');
        
        % idx = rangesearch(kdtreeobj,Cp(i,(1:3)), 0.1);      %以半径为限制提取邻近点
        
        % 边界的探测点数 neighborPs_num
        
        [idx,~]=knnsearch( kdtreeobj , BoundaryPoints( i , :) , 'dist' , 'euclidean' , 'k' , neighborPs_num);%50 );  % 以点数限制提取邻近点

        LestPoints = pt3(idx,1:3); %邻近点
        [A,B,C] = PF(LestPoints);  %该平面方程为 Ax+By+Cz+1=0 计算平面参数
        
        R = TransformPlane(A,B,C);

        a = A;    %  该平面方程为 Ax+By+Cz+1=0
        b = B;
        c = C;
        d = 1;

        K = (a^2 + b^2 +c^2);
        x_ = ( ( b^2 + c^2 ) * LestPoints(:,1) - a * b * LestPoints(:,2) -  a * c * LestPoints(:,3) - a * d ) / K;   %将点投影到该平面
        y_ = ( - a * b * LestPoints(:,1) + ( a^2 + c^2 ) * LestPoints(:,2) - b * c * LestPoints(:,3) - b * d ) / K;
        z_ = ( - a * c * LestPoints(:,1) - b * c * LestPoints(:,2) + ( a^2 + b^2 ) * LestPoints(:,3) - c * d ) / K;
        TransformPoints = R * [x_,y_,z_]';
% 
%         pcshow([x_,y_,z_],[1,0,0],'MarkerSize',20);
%         hold on
%         pcshow([x_(1,1),y_(1,1),z_(1,1)],[1,0,1],'MarkerSize',30);
%                 
        x_ = double(TransformPoints(1,:));
        y_ = double(TransformPoints(2,:));
        z_ = double(TransformPoints(3,:));   
                    
%         close all
%         pcshow(TransformPoints',[1,0,0],'MarkerSize',30);
%         hold on
%         pcshow([x_(1,1),y_(1,1),z_(1,1)],[1,0,1],'MarkerSize',60);

        
        x_ = x_(1,:) - x_(1,1);  %构造向量
        y_ = y_(1,:) - y_(1,1);
        z_ = z_(1,:) - z_(1,1);     
        
        for j = 1 :length(x_)

            norm_X(j,1) = norm([x_(1,j),y_(1,j)]); %计算向量二范数 用于归一化

        end    
        
        norm_X = norm_X(3:end);
        
        x_ = x_(3:end) ./ norm_X';
        y_ = y_(3:end) ./ norm_X';
%         z_ = z_(2:end) ./ norm_X';
        

%         figure(2)
%         
%         plot(x_,y_,'go');
%         
%         figure(3)
%         pcshow(pt3,[0,0,0],'MarkerSize',1);
%         hold on
%         pcshow(BoundaryPoints( i , :),[1,0,0],'MarkerSize',20);
%         pcshow(LestPoints,[0,1,0],'MarkerSize',10);
        
        
%         pcshow([x_',y_'],[0,0,0]);      
        
        min_x = min(x_);max_x = max(x_);
        min_y = min(y_);max_y = max(y_);
        maxvalue_x = max_x - min_x;
        maxvalue_y = max_y - min_y;
        
        if ( (maxvalue_x+maxvalue_y) < TurPthreshold ) %2.8 )%(max_x < 1.7 && max_y < 1.7)

            indx(i,1)  = true;
%             showpoint(pt3,boundaryP(i,2),LestPoints);
%             showpoint2(x_2D_,y_2D_,x_)
            
        end
        
    end
    
    TurningPointindx = boundaryP(indx,2);
 
    
    %% 这里附加的条件是消除拐点间不要出现密集点集的情况
    length_TurningPoints = length(TurningPointindx);  % 这里附加的条件是消除拐点间不要出现密集点集的情况
    
    TurningPoints = pt3(TurningPointindx,1:3); 
    TurningPoints = [TurningPoints,ones(length_TurningPoints,1)];
    
    
    for i = 1 : length_TurningPoints - 1
        
        for j = i + 1 : length_TurningPoints
           
             if( norm(TurningPoints(i,1:3) - TurningPoints(j,1:3)) < Partradius ) % 0.003 )
                 
                 TurningPoints(j,4) = 0;
                 
             end
            
        end
        
    end
    
    
    TurningPointindx = TurningPointindx(find(TurningPoints(:,4)==1));
    
%     output_boundaryP = boundaryP( indx1(i) , 1:2 );   %边界点更新
    

%     pcshow(pt3,[0,0,0],'MarkerSize',1);
% 	hold on
%     pcshow(pt3(TurningPointindx,1:3),[0,1,0],'MarkerSize',30);
%     pcshow(pt3(boundaryP(:,2),1:3),[0,1,0],'MarkerSize',10);
    
end








function showpoint3(x_,y_,z_,indx)
    
    pcshow([x_(2,1),y_(2,1),z_(2,1)],[1,0,1],'MarkerSize',30);
    hold on
    pcshow([x_(3,1),y_(3,1),z_(3,1)],[1,0,0],'MarkerSize',30);
    pcshow([x_,y_,z_],[0,0,0])
    pcshow([x_(indx,1),y_(indx,1),z_(indx,1)],[0,0,1],'MarkerSize',20);
    hold off

end

function showpoint2(x_2D_,y_2D_,x_)
        
        figure(2);
        plot(x_2D_(2:length(x_),1),y_2D_(2:length(x_),1),'g*');
        hold on
        plot(0,0,'r*');
        hold off

end



function showpoint(pt3,indx,LestPoints)

    pcshow(pt3,[0,0,0],'MarkerSize',1);
    hold on
    pcshow(pt3(indx,1:3),[1,0,0],'MarkerSize',30);
    pcshow( LestPoints,[1,1,0],'MarkerSize',20);
    pcshow( LestPoints(2,:),[0,1,0],'MarkerSize',20);  %y
    pcshow( LestPoints(3,:),[0,1,0],'MarkerSize',40);  %x
    
end



   function [A,B,C] = PF( Points )
    
    %方程是 AX+BY+CZ+1 = 0;

    x = Points(:,1);y = Points(:,2);z = Points(:,3);

    temp_xx = x' * x;   %  sum( x .* x );
    temp_xy = x' * y;
    temp_yy = y' * y;
    temp_zx = z' * x;
    temp_zy = z' * y;
    temp_zz = z' * z;

    a = [temp_xx,temp_xy,temp_zx;
        temp_xy,temp_yy,temp_zy;
        temp_zx,temp_zy,temp_zz];
    
    b = [ -sum(x);-sum(y);-sum(z)];

    c = ((a)^-1) * b;
    
    A = c(1) ; B = c(2); C =c(3);


    end

