%% 边界提取算法
function [Cp_Boundary,PointsNormal] = BoundaryExtraction(Cp,Searchradius,Forcethreshold)
    
    % Cp_Boundary 返回两个value 1、该点合力大小比值 2、检索号


    length_Cp = length(Cp);
    Boundary_idx2 = zeros(length_Cp,2); 
    Boundary_idx = zeros(length_Cp,1);
    PointsNormal = zeros(length_Cp,3);  % 存储法线信息
    
    for i = 1 : length_Cp 
        
        kdtreeobj = KDTreeSearcher(Cp(:,(1:3)),'distance','euclidean');
%         idx = rangesearch(kdtreeobj,Cp(i,(1:3)), 0.005);
%         idx = rangesearch( kdtreeobj , Cp(i,(1:3)) , Searchradius );% 0.005);
        [idx,~]=knnsearch(kdtreeobj,Cp(i,(1:3)),'dist','euclidean','k' , 15);  % 邻近点
%         idx = [idx{1}]; 

        LestPoints = Cp( idx(1,:) , 1:3 ); 
        
%         close all
%         pcshow( Cp , [0,0,0] , 'MarkerSize' , 10 );
%         hold on
%         pcshow( LestPoints(2:end,:) , [0,1,0] , 'MarkerSize' , 10 );
%         pcshow( Cp(i,(1:3)) , [1,0,0] , 'MarkerSize' , 30 );
        
        [A,B,C] = PF( LestPoints ); %计算法线
        %方程是 AX+BY+CZ+1 = 0;
        PointsNormal(i,1:3) = [ A , B , C ];
        
        a = A;
        b = B;
        c = C;
        
        d = 1;
        
        % 得到法线之后 平面方程表示为 A(X-x)+B(Y-y)+C(Z-z) = 0;
        % 将上式转换为 ax+by+cz+d=0 有 AX+BY+CZ+（-Ax-By-Cz） = 0;
        
        % 将局部参考点集向其切平面投影，得到投影点集为X
        K = (a^2 + b^2 +c^2);
        x_ = ( ( b^2 + c^2 ) * LestPoints(:,1) - a * b * LestPoints(:,2) -  a * c * LestPoints(:,3) - a * d ) / K;
        y_ = ( - a * b * LestPoints(:,1) + ( a^2 + c^2 ) * LestPoints(:,2) - b * c * LestPoints(:,3) - b * d ) / K;
        z_ = ( - a * c * LestPoints(:,1) - b * c * LestPoints(:,2) + ( a^2 + b^2 ) * LestPoints(:,3) - c * d ) / K;
        
        
        x_ = x_(:,1) - x_(1,1);  %构造向量
        y_ = y_(:,1) - y_(1,1);
        z_ = z_(:,1) - z_(1,1);
        
        length_LestPoints = length(LestPoints);
        
        x_ = x_(2:length_LestPoints,1);
        y_ = y_(2:length_LestPoints,1);
        z_ = z_(2:length_LestPoints,1);
        
        
        %norm_X = norm( [ x_ , y_ , z_ ] ); %归一化
        norm_X = [];
        for j = 1 :length(x_)
            
            norm_X(j,1) = norm([x_(j,1),y_(j,1),z_(j,1)]);
            
        end
       
        
        x_ = x_ ./ norm_X;
        y_ = y_ ./ norm_X;
        z_ = z_ ./ norm_X;
        
        F = abs(sum( x_ )) + abs(sum( y_ )) + abs(sum( z_ ));      
        
        m = 0;
        for j = 1 :length(x_)
            
            m = m + norm([x_(j,1),y_(j,1),z_(j,1)]);
            
        end
        
        if( ( F / m ) > Forcethreshold) % 0.55)   %判断该点是否为边界点
            
            Boundary_idx(i,1) = 1;
            Boundary_idx2(i,1) = ( F / m );
            Boundary_idx2(i,2) = i;
            
        end            
        
        
    end
    
    
    Boundary_idx = logical(Boundary_idx);
    Cp_Boundary = Boundary_idx2( Boundary_idx,1:2);

    
%     pcshow(Cp,[0,0,0],'MarkerSize',1);
%     hold on
%     pcshow(Cp(Cp_Boundary(:,2),1:3),[1,0,0],'MarkerSize',20);

    %     pcshow(Cp( indx(length(indx)-8:length(indx),2),1:3),[1,0,0],'MarkerSize',40);
    
end



    function [Planecoefficients] = ComputerNormal(pt1)
    
    
    Planecoefficients=zeros(length(pt1),3);
    KHs=zeros(length(pt1),1);
    KGs=zeros(length(pt1),1);
    
        for i=1:length(pt1)

             kdtreeobj = KDTreeSearcher(pt1(:,(1:3)),'distance','euclidean');

            [idx,~]=knnsearch(pt1,pt1(i,(1:3)),'dist','euclidean','k',25);  %邻近点
            
            pt1_kd_nearpoint = pt1(idx,(1:3));
            
            [Planeparameters,~] = EV(pt1_kd_nearpoint);
            
            Planecoefficient=Planeparameters;Planecoefficient(1,3)=-1;Planecoefficient=Planecoefficient/norm(Planecoefficient);
            
            Planecoefficients(i,1:3) = Planecoefficient;
            
%             [KH,KG,~,~]=get_curcature(pt1(i,(1:3))',Planecoefficient',pt1_kd_nearpoint');
%             
%             KHs(i,1)=KH;
%             KGs(i,1)=KG;
            
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

    
    
function [normal_vector,EVs] = EV(knbpts)
    % knbpts：邻近点
    % normal_vector:单位法向量
    % EVs ：单位特征值
    P = knbpts(:,1:3);
    [m,~] = size(P);
    % 计算协方差矩阵
    P = P-ones(m,1)*(sum(P,1)/m);
    C = P.'*P./(m-1);  
    % 计算特征值与特征向量
    [V, D] = eig(C);

    % 最小特征值对应的特征向量为法向量
    s1 = D(1,1);
    s2 = D(2,2);
    s3 = D(3,3);
    if (s1 <= s2 && s1 <= s3)
        normal_vector(1,:) = V(:,1)/norm(V(:,1));
    elseif (s2 <= s1 && s2 <= s3)
        normal_vector(1,:) = V(:,2)/norm(V(:,2));
    elseif (s3 <= s1 && s3 <= s2)
        normal_vector(1,:) = V(:,3)/norm(V(:,3));
    end 

    % 单位特征值
    epsilon_to_add = 1e-8;
    % EVs(1) > EVs(2) > EVs(3)
    EVs(1,:) = [D(3,3) D(2,2) D(1,1)];
    if EVs(1,3) <= 0
        EVs(1,3) = epsilon_to_add;
        if EVs(1,2) <= 0
            EVs(1,2) = epsilon_to_add;
            if EVs(1,1) <= 0
                EVs(1,1) = epsilon_to_add;
            end
        end
    end
    sum_EVs = EVs(1) + EVs(2) + EVs(3);    
    EVs = EVs/sum_EVs;

end
