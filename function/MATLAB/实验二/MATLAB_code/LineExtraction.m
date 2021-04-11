%% ����ȡ

function [Lines,LinesPoints] = LineExtraction( pt , boundary , TurningPointindx )
    % pt���� boundary�߽����� TurningPoint�յ����
    % [ value , �߽����� ] = boundary
    
    
    %%  20201215 test 
        % 20201218 finish
        % �߶μ������� ��Եı߽������
        % �յ������ͬ�� 
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
%     boundaryP = pt( boundary(:,2) , 1:3 );        %�߽��
%     TurningPoint = pt( TurningPointindx , 1:3 );  %�յ�
%     
%     length_boundaryP = length( boundaryP );       %�߽�����
%     length_TurningPoint = length( TurningPoint ); %�յ����
%     
%     boundaryP_TurnP_indx = zeros(length_TurningPoint,1);  %�յ��ڱ߽�����еļ�����
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
% %             Check_R = norm( boundaryP( boundaryP_TurnP_indx(i,1) , 1:3 ) - boundaryP( boundaryP_TurnP_indx(j,1) , 1:3 ) ); %�����뾶
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
%                 fprintf("������Ϊ�����ߵ㣡");
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


% 202011142201 �㶨 ��ȡ������





%% ����
function [Lines]=Recursive_Algorithm( PointCloud , Boundary_Data , TurnPoint_Data )

    % �ݹ���ȡ�߽��� 20201215
	boundaryP = PointCloud( Boundary_Data(:,2) , 1:3 );        %�߽��
    TurningPoint = PointCloud( TurnPoint_Data  , 1:3 );        %�յ�
    
    length_boundaryP = length( boundaryP );       %�߽�����
    length_TurningPoint = length( TurningPoint ); %�յ����
    
    boundaryP_TurnP_indx = zeros(length_TurningPoint,1);  %�յ��ڱ߽�����еļ�����
    Num_Recursive_Line = 0; %������
    
    for i = 1 : length_TurningPoint % �յ��ڱ߽��еļ���λ��

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
                
                fprintf("������Ϊ�����ߵ㣡");
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
        Check_R = norm( Point1 - Point2 ); %�����뾶
        Check_R_ = Check_R / 2;
        idx_R1 = rangesearch( kdtreeobj , Point1 , Check_R_);
        idx_R2 = rangesearch( kdtreeobj , Point2 , Check_R_); 

    % 	size_idx_R2 = size(idx_R2{1},2);
       %% ��һ����� ��ߵ㼯ֻ�� ������һ����
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

        %% �ڶ������ ��ߵ㼯 �����������
            % 1���������� ��   �����������ϵĵ㣬�Ǿͻ��ܷ�һ���е�����ٽ��еݹ�
            % 2���������� û�� �����������ϵĵ㣬�Ǿͽ��õ㱾��ѹջ�����߼���Recursive_Line��

        if(size(idx_R2{1},2) > 1)

           for i = 0 : (size(idx_R2{1},2)-1)

               if(norm(boundaryPs(idx_R2{1}(end - i),1:3) - Point1) < Check_R )
                    
                   if( isempty(find(Recursive_Line == idx_R2{1}(end - i))) )
                       Point2_indx = idx_R2{1}(end - i);  % ��������������µĵݹ��㷨��
%                        hold on
%                        pcshow(boundaryPs(Point2_indx,1:3),[0,0,1],'MarkerSize',20);
                       break;
                   end

               end

           end

           if( i ~= (size(idx_R2{1},2)-1) ) % ˵���п��Եݹ�ĵ� ���Խ��ŵݹ�          

                [Recursive_Line] = testfile( boundaryPs , kdtreeobj , Recursive_Line , Point2_indx );

           end


           if( i == (size(idx_R2{1},2)-1) ) % �������������� ��˵�� ����㼯��û�������������ϵĵ�

               Recursive_Line = [ Recursive_Line , idx_R2{1}(1) ]; %���԰ѵݹ��ѹջ Ȼ�󷵻�
               return ;

           end

        end
end 
    return ; 


end

function [Check_R , tag] = half_P(kdtreeobj , Point1 , Point2 )
    
    tag = true;
    Check_R = norm( Point1 - Point2 ); %�����뾶
    Check_R = Check_R / 1.81;
    idx_R1 = rangesearch( kdtreeobj , Point1 , Check_R);
    idx_R2 = rangesearch( kdtreeobj , Point2 , Check_R); 
    
    if( ( length(intersect( idx_R1{1} , idx_R2{1} )) ) < 1 )
        
        tag = false;
        
    end          
    
end

function [ Line_point ] = subLine(kdtreeobj , Point1 , Point2 )

    Check_R = norm( Point1 - Point2 ); %�����뾶
    
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
