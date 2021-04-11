%% 把边界点云的 法线信息提取出来
    %20201218 
function [ Lines ] = NormalExtraction(app, pt , Lines , CNoramlneigPsnum)
    
     NumSubLine = size( Lines , 2 );
        
     kdtreeobj = KDTreeSearcher( pt ,'distance' , 'euclidean' ); %KDTREE
     
     
     for i = 1 :  NumSubLine
         
        NumLinePs = length(Lines(i).Line);
        SubLine_Normal = zeros( NumLinePs , 3 );
        
        for j = 1 : NumLinePs 
         
            %idx = rangesearch(kdtreeobj,pt(Lines(i).Line(j,1),1:3), 0.005);  %这个0.1参数需要根据不同的数据进行调整
            
            [idx,~] = knnsearch( kdtreeobj ,pt(Lines(i).Line(j,1),1:3), 'dist' , 'euclidean' , 'k' , CNoramlneigPsnum);
            [A,B,C] = PF( pt(idx,1:3) );
            A = A / norm([A,B,C]);
            B = B / norm([A,B,C]);
            C = C / norm([A,B,C]);
            SubLine_Normal(j,1:3) = [A,B,C];
            
        end
        
        app.SubBoundaryInformation.Points(i).Normal = SubLine_Normal;
         
     end
     
    
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