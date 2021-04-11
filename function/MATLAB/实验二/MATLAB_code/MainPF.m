%% main

clc
clear
close all


A=-1;B=1;C=1;    % 给出平面参数，计算三维点

Points( : , 1:2 ) = [unifrnd(1,2,300,1),unifrnd(1,2,300,1)];  % 生成300个点

Points(:,3) = A*Points(:,1)+B*Points(:,2)+C;  %平面方程为 A*x+B*y+C = z;

numPoint = length(Points); %点数量

% pcshow(Points,[0,0,0]); %显示点

fprintf("三维点生成完毕...\n");

hold on

%% 绘制平面

[x,y]=meshgrid(min(Points(:,1)):0.01:max(Points(:,1)),min(Points(:,2)):0.01:max(Points(:,2)));  

z=A*x+B*y+C;

mesh(x,y,z);
fprintf("绘制平面...\n");



%% 添加偶然误差


WhiteNoisePoints(:,1) = Points(:,1) + ( randn( numPoint,1 ) * 0.01);  %生成中误差为0.01的正态随机数
WhiteNoisePoints(:,2) = Points(:,2) + ( randn( numPoint,1 ) * 0.01);
WhiteNoisePoints(:,3) = Points(:,3) + ( randn( numPoint,1 ) * 0.01); 

pcshow(WhiteNoisePoints,[0,1,0],'MarkerSize',10);

[A,B,C]=PF(WhiteNoisePoints);      % 
 
fprintf("\n\n---------------------------------------------含偶然误差平面参数求解------------------------------------------\n")
fprintf("\t\tA\t              B\t              C\t                   \t\t▲A\t              ▲B\t          ▲C\t                   \n")
fprintf("-----------------------平面参数-------------------------    -------------------------真误差-------------------\n")
fprintf("\n  %12.6f\t   %12.6f\t   %12.6f\t\t          %12.6f\t   %12.6f\t   %12.6f\t      \n\n" , A , B , C,A+1,B-1,C-1 );
fprintf("---------------------------------------------------------end--------------------------------------------------\n\n")






%% 函数
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
    
    A = c(1)/-c(3) ; B = c(2)/-c(3); C =1 / -c(3);


end

