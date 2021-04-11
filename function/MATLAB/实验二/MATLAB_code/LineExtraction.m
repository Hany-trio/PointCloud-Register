%% 线提取

function [Lines,LinesPoints] = LineExtraction( pt , boundary , TurningPointindx )
    % pt点云 boundary边界点检索 TurningPoint拐点检索
    % [ value , 边界点检索 ] = boundary
    
    
    %%  20201215 test 
        % 20201218 finish
        % 线段检索号是 针对的边界检索号
        % 拐点检索号同上 
    [Lines] = Recursive_Algorithm( pt , boundary , TurningPointindx );
    
    for i = 1 : length(Lines)
        
        LinesPoints(i).Line = pt(Lines(i).Line,1:3) ;
%         LinesPoints.Lines(2).Line = pt3(Lines(2).Line,1:3) ;
%         LinesPoints.Lines(3).Line = pt3(Lines(3).Line,1:3) ;
%         LinesPoints.Lines(4).Line = pt3(Lines(4).Line,1:3) ;
        
    end
    
    for i = 1 : length(Lines)
        
        LinesPoints(i).TrPoint = pt(Lines(i).TurningPoint,1:3) ;
%         LinesPoints.Lines(2).Line = pt3(Lines(2).Line,1:3) ;
%         LinesPoints.Lines(3).Line = pt3(Lines(3).Line,1:3) ;
%         LinesPoints.Lines(4).Line = pt3(Lines(4).Line,1:3) ;
        
    end
    
%     %%
%     boundaryP = pt( boundary(:,2) , 1:3 );        %边界点
%     TurningPoint = pt( TurningPointindx , 1:3 );  %拐点
%     
%     length_boundaryP = length( boundaryP );       %边界点个数
%     length_TurningPoint = length( TurningPoint ); %拐点个数
%     
%     boundaryP_TurnP_indx = zeros(length_TurningPoint,1);  %拐点在边界点云中的检索号
%     
%     for i = 1 : length_TurningPoint 
% 
%         boundaryP_TurnP_indx(i,1) = find(boundary(:,2) == TurningPointindx( i ,1 ));
%     
%     end
%     
%     k = 1;
%     for i = 1 : length_TurningPoint - 1    
% 
%         kdtreeobj = KDTreeSearcher( boundaryP ,'distance' , 'euclidean' ); %KDTREE
% 
%         for j = i+1 : length_TurningPoint
% 
%                 
% %             Check_R = norm( boundaryP( boundaryP_TurnP_indx(i,1) , 1:3 ) - boundaryP( boundaryP_TurnP_indx(j,1) , 1:3 ) ); %搜索半径
% %             Check_R = Check_R / 1.9;
% %             idx_R1 = rangesearch(kdtreeobj,boundaryP( boundaryP_TurnP_indx(i,1) , 1:3 ), Check_R);
% %             idx_R2 = rangesearch(kdtreeobj,boundaryP( boundaryP_TurnP_indx(j,1) , 1:3 ), Check_R);   
% %     %             showPoint( pt ,boundary , idx_R1 );
% %             close all
% %             half_Point = intersect( idx_R1{1} , idx_R2{1} );
%             
% 
%             close all
%             [ half_1 , ~ ] = half_P( kdtreeobj , boundaryP( boundaryP_TurnP_indx(i,1) , 1:3 ) , boundaryP( boundaryP_TurnP_indx( j , 1 ) , 1:3 ));   
%             
%             if (isempty( half_1 ) )
%                 
%                 fprintf("该两点为非连线点！");
%                 continue;
%                 
%             end
%             
%             [ half_2 , ~ ] = half_P( kdtreeobj , boundaryP( boundaryP_TurnP_indx(i,1) , 1:3 ) , boundaryP( half_1(1,1) , 1:3 ));
%             [ half_3 , ~ ] = half_P( kdtreeobj , boundaryP( boundaryP_TurnP_indx(j,1) , 1:3 ) , boundaryP( half_1(1,1) , 1:3 ));
%             
%             
%             
%             Line_point1 = subLine(kdtreeobj , boundaryP( half_2(1,1) , 1:3 ) , boundaryP( boundaryP_TurnP_indx(i,1) , 1:3 ) );
%             Line_point2 = subLine(kdtreeobj , boundaryP( half_3(1,1) , 1:3 ) , boundaryP( boundaryP_TurnP_indx(j,1) , 1:3 ) );
%             Line_point3 = subLine(kdtreeobj , boundaryP( half_2(1,1) , 1:3 ) , boundaryP( half_1(1,1) , 1:3 ) );
%             Line_point4 = subLine(kdtreeobj , boundaryP( half_3(1,1) , 1:3 ) , boundaryP( half_1(1,1) , 1:3 ) );
%             
%             Line = Line_point1;
%             Line = union( Line  , Line_point2 );
%             Line = union( Line  , Line_point3 );
%             Line = union( Line  , Line_point4 );
%             
% %             showPoint1( boundaryP , Line );
% %             pcshow(boundaryP( boundaryP_TurnP_indx(i,1) , 1:3 ),[0,1,0],'MarkerSize',20);
% %             pcshow(boundaryP( boundaryP_TurnP_indx(j,1) , 1:3 ),[0,1,0],'MarkerSize',20);
% 
% % 
% %             Lines {k}  = boundary(Line,2) ;
%             
%             Lines(k).Line = boundary(Line,2); 
%             Lines(k).p1 = boundary( boundaryP_TurnP_indx(i,1) , 2 );
%             Lines(k).p2 = boundary( boundaryP_TurnP_indx(j,1) , 2 );
%             
%             k = k + 1;
%             
%         end
%         
%     end
%     
%    

    
end


% 202011142201 搞定 提取线特征





%% 函数
function [Lines]=Recursive_Algorithm( PointCloud , Boundary_Data , TurnPoint_Data )

    % 递归提取边界线 20201215
	boundaryP = PointCloud( Boundary_Data(:,2) , 1:3 );        %边界点
    TurningPoint = PointCloud( TurnPoint_Data  , 1:3 );        %拐点
    
    length_boundaryP = length( boundaryP );       %边界点个数
    length_TurningPoint = length( TurningPoint ); %拐点个数
    
    boundaryP_TurnP_indx = zeros(length_TurningPoint,1);  %拐点在边界点云中的检索号
    Num_Recursive_Line = 0; %线数量
    
    for i = 1 : length_TurningPoint % 拐点在边界中的检索位置

        boundaryP_TurnP_indx(i,1) = find( Boundary_Data(:,2) == TurnPoint_Data( i ,1 ));
    
    end
    
    k = 1;
    
	for i = 1 : length_TurningPoint - 1    

        kdtreeobj = KDTreeSearcher( boundaryP ,'distance' , 'euclidean' ); %KDTREE
%         Recursive_Line = boundaryP_TurnP_indx(i,1);
        
        for j = i+1 : length_TurningPoint   
            
            Recursive_Line = boundaryP_TurnP_indx(i,1);
          
            [  ~ ,tag] = half_P( kdtreeobj , boundaryP( boundaryP_TurnP_indx(i,1) , 1:3 ) , boundaryP( boundaryP_TurnP_indx( j , 1 ) , 1:3 ));  
            
            if ( tag == false )
                
                fprintf("该两点为非连线点！");
                continue;
                
            else
                
                Recursive_Line = testfile( boundaryP , kdtreeobj , Recursive_Line , boundaryP_TurnP_indx( j , 1 ));
                Num_Recursive_Line = Num_Recursive_Line + 1;
                
            end
            
         Lines(Num_Recursive_Line).TurningPoint = [Boundary_Data(boundaryP_TurnP_indx(i,1),2),Boundary_Data(boundaryP_TurnP_indx( j , 1 ),2)];
         Lines(Num_Recursive_Line).Line = Boundary_Data(Recursive_Line,2);
         
         Recursive_Line = [];       
            
        end
        
	end
    
    

end


function [Recursive_Line] = testfile( boundaryPs , kdtreeobj , Recursive_Line , Point2_indx_ )
    
while(isempty(find( Recursive_Line == Point2_indx_ )))
    
        Point1 = boundaryPs(Recursive_Line(end),1:3);
        Point2 = boundaryPs(Point2_indx_ ,1:3);
        Check_R = norm( Point1 - Point2 ); %搜索半径
        Check_R_ = Check_R / 2;
        idx_R1 = rangesearch( kdtreeobj , Point1 , Check_R_);
        idx_R2 = rangesearch( kdtreeobj , Point2 , Check_R_); 

    % 	size_idx_R2 = size(idx_R2{1},2);
       %% 第一种情况 左边点集只有 它本身一个点
        if(size(idx_R2{1},2) == 1)

            if(size(idx_R1{1},2) == 1)

                Recursive_Line = [ Recursive_Line , idx_R2{1} ];

            else
                
                for i = 1 : size(idx_R1{1},2)

                    if(norm(boundaryPs(idx_R1{1}(i),1:3) - Point2) < Check_R )

                        Recursive_Line = [ Recursive_Line , idx_R1{1}(i) ];

                    end

                end
                
                Recursive_Line = [ Recursive_Line , idx_R2{1} ];
                               
            end

        end

        %% 第二种情况 左边点集 它还有其余点
            % 1、少量点中 有   在两点连线上的点，那就还能分一个中点出来再进行递归
            % 2、少量点中 没有 在两点连线上的点，那就将该点本身压栈到连线集合Recursive_Line中

        if(size(idx_R2{1},2) > 1)

           for i = 0 : (size(idx_R2{1},2)-1)

               if(norm(boundaryPs(idx_R2{1}(end - i),1:3) - Point1) < Check_R )
                    
                   if( isempty(find(Recursive_Line == idx_R2{1}(end - i))) )
                       Point2_indx = idx_R2{1}(end - i);  % 这个检索将用于新的递归算法；
%                        hold on
%                        pcshow(boundaryPs(Point2_indx,1:3),[0,0,1],'MarkerSize',20);
                       break;
                   end

               end

           end

           if( i ~= (size(idx_R2{1},2)-1) ) % 说明有可以递归的点 所以接着递归          

                [Recursive_Line] = testfile( boundaryPs , kdtreeobj , Recursive_Line , Point2_indx );

           end


           if( i == (size(idx_R2{1},2)-1) ) % 如果这个条件成立 那说明 这个点集中没有在两点连线上的点

               Recursive_Line = [ Recursive_Line , idx_R2{1}(1) ]; %所以把递归点压栈 然后返回
               return ;

           end

        end
end 
    return ; 


end

function [Check_R , tag] = half_P(kdtreeobj , Point1 , Point2 )
    
    tag = true;
    Check_R = norm( Point1 - Point2 ); %搜索半径
    Check_R = Check_R / 1.81;
    idx_R1 = rangesearch( kdtreeobj , Point1 , Check_R);
    idx_R2 = rangesearch( kdtreeobj , Point2 , Check_R); 
    
    if( ( length(intersect( idx_R1{1} , idx_R2{1} )) ) < 1 )
        
        tag = false;
        
    end          
    
end

function [ Line_point ] = subLine(kdtreeobj , Point1 , Point2 )

    Check_R = norm( Point1 - Point2 ); %搜索半径
    
    idx_R1 = rangesearch( kdtreeobj , Point1 , Check_R);
    idx_R2 = rangesearch( kdtreeobj , Point2 , Check_R);    
    
    Line_point = intersect( idx_R1{1} , idx_R2{1} );
    
    
end




function showPoint1( boundaryP , indx  )
    
    pcshow(boundaryP,[0,0,0],'MarkerSize',1);
    hold on
    pcshow(boundaryP(indx,1:3),[1,0,0],'MarkerSize',10);
    
end




function showPoint( pt , boundaryindx , indx )
    

    pcshow(pt,[0,0,0],'MarkerSize',1);
    hold on
    pcshow( pt( boundaryindx(indx{1},2) ,1:3 ),[1,1,0],'MarkerSize',20);
    pcshow( pt( boundaryindx(:,2),1:3) ,[1,0,0],'MarkerSize',10);   
    
    
end
