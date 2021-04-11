function [R] = TransformPlane(A,B,C)
    
    % 平面方程Ax+By+Cz+1=0;
    % 设定一个平面
%     A= 2; B= 3; C= 1;
    %在该平面上找一个圆心
    x1 = 5 ; y1 = 0.4;
    z1 = (-1-A*x1-B*y1)/C;
    x2 = 1 ; y2 = 1;
    z2 = ( -1 - A*x2 - B*y2 ) / C ;
%     x3 = -1 ; y3 = -1;
%     z3 = ( -1 - A*x3 - B*y3 ) / C ;
    % x2 = 3 ; y2 = 2;
    % z2 = ( -1 - A*x2 - B*y2 ) / C ;
%     plotplane(A,B,C)
%     hold on
%     quiver3(x1,y1,z1,A,B,C);

    v1 = [x1-x2,y1-y2,z1-z2];
    v3 = cross([A,B,C],v1);

    v1 = v1/norm(v1);
    v3 = v3/norm(v3);

    v2 = [-v1(1),-v1(2),-v1(3)];
    v4 = [-v3(1),-v3(2),-v3(3)];

    point1 = [x1,y1,z1] + v1;
    point2 = [x1,y1,z1] + v2;
    point3 = [x1,y1,z1] + v3;
    point4 = [x1,y1,z1] + v4;


%     pcshow(point1,[0,1,0],'MarkerSize',100);
%     hold on
%     pcshow(point2,[0,1,0],'MarkerSize',100);
%     pcshow(point3,[0,1,0],'MarkerSize',100);
%     pcshow(point4,[0,1,0],'MarkerSize',100);
%     pcshow([x1,y1,z1],[1,0,0],'MarkerSize',100);

    points2 = [0,0,0;
        1,0,0;
        -1,0,0;
        0,1,0;
        0,-1,0];
    points3 = [[x1,y1,z1];point1;point2;point3;point4];

%     pcshow(points2,[0,0,1],'MarkerSize',100);

%     x = 2 : 0.2 : 7 ;
%     y =-4 : 0.2 : 4 ;
% 
%     [meshx,meshy] = meshgrid(x,y);
%     z = ( -1 - A .* meshx - B.*meshy ) / C;
%     % plot3(meshx,meshy,z,'g.');
% 
%     x = reshape(meshx , 1 , 41*26 );
%     y = reshape(meshy , 1 , 41*26 );
%     z = reshape(z , 1 , 41*26 );
%     points1 = [x;y;z];
    % point2 = [x;y;zeros(1,41*26)];
%     pcshow(points1',[0,0,0]);
    % pcshow(point2');
    R = rigid_transform(points3,points2);



%     point3 = R * points3';
%     pcshow(point3',[1,0,0],'MarkerSize',100);
%     points1 = R * points1;
%     pcshow(points1',[0,0,0]);

%     hold off

    % % 平面方程Ax+By+Cz+1=0;
    % % 设定一个平面
    % A= 2; B= 3; C= 1;
    % %在该平面上找一个圆心
    % x1 = 5 ; y1 = 0.4;
    % z1 = (-1-A*x1-B*y1)/C;
    % x2 = 1 ; y2 = 1;
    % z2 = ( -1 - A*x2 - B*y2 ) / C ;

end

function plotplane(A,B,C)

    x = -2 : 0.1 : 2 ;
    y =-2 : 0.1 : 2 ;

    [meshx,meshy] = meshgrid(x,y);
    z = ( -1 - A .* meshx - B.*meshy ) / C;
    mesh(meshx,meshy,z);


end

function [R] = rigid_transform(p1,p2)

    center_p1 = mean(p1);
    center_p2 = mean(p2);
    
    
    pp1 = p1 - center_p1;
    pp2 = p2 - center_p2;
    
    h = pp1'*pp2;
    [u,~,v] = svd(h);
    R  = v'*u';


end
