clc
clear
close all


A = -1;B = 1;C = 1;    % 给出平面参数，计算三维点

Points(:,1:2) = [unifrnd(1,2,300,1),unifrnd(1,2,300,1)];  % 生成300个点

Points(:,3) = A * Points(:,1) + B * Points(:,2) + C;  %平面方程为 A*x+B*y+C = z;

numPoint=length(Points); %点数量

pcshow(Points,[1,0,0],'MarkerSize',10); %显示点
% plot3(Points(:,1),Points(:,2),Points(:,3),'o');

fprintf("三维点生成完毕...\n");

hold on

%% 绘制平面

[x,y]=meshgrid(min(Points(:,1)):0.01:max(Points(:,1)),min(Points(:,2)):0.01:max(Points(:,2)));  

z=A*x+B*y+C;

mesh(x,y,z);
fprintf("绘制平面...\n");

%% 添加偶然误差


WhiteNoisePoints(:,1) = Points(:,1) + ( randn(numPoint,1) * 0.01 );  %生成中误差为0.01的正态随机数
WhiteNoisePoints(:,2) = Points(:,2) + ( randn(numPoint,1) * 0.01 );
WhiteNoisePoints(:,3) = Points(:,3) + ( randn(numPoint,1) * 0.01 ); 

% pcshow(WhiteNoisePoints,[0,1,0],'MarkerSize',10);

[A,B,C]=PF(WhiteNoisePoints);      % 
 
fprintf("\n\n---------------------------------------------含偶然误差平面参数求解------------------------------------------\n")
fprintf("\t\tA\t              B\t              C\t                   \t\t▲A\t              ▲B\t          ▲C\t                   \n")
fprintf("-----------------------平面参数-------------------------    -------------------------真误差-------------------\n")
fprintf("\n  %12.6f\t   %12.6f\t   %12.6f\t\t          %12.6f\t   %12.6f\t   %12.6f\t      \n\n" , A , B , C,A+1,B-1,C-1 );
fprintf("---------------------------------------------------------end--------------------------------------------------\n\n")


%% 添加粗差

NumColoredNoisePoints = 10;   %添加10个粗差点

idx = round(rand(NumColoredNoisePoints,1)*299+1);   %生成随机检索号

ColoredNoisePoints = WhiteNoisePoints;

ColoredNoisePoints(idx,1) = WhiteNoisePoints( idx , 1) + ( randn(NumColoredNoisePoints,1) * 0.5);  %生成标准差为0.5的正态随机数
ColoredNoisePoints(idx,2) = WhiteNoisePoints( idx , 2) + ( randn(NumColoredNoisePoints,1) * 0.5);
ColoredNoisePoints(idx,3) = WhiteNoisePoints( idx , 3) + ( randn(NumColoredNoisePoints,1) * 0.5);

pcshow(ColoredNoisePoints,[1,0,0],'MarkerSize',10);

[A,B,C] = PF( ColoredNoisePoints );

fprintf("\n\n------------------------------------------------含粗差平面参数求解--------------------------------------------\n")
fprintf("\t\tA\t              B\t              C\t                   \t\t▲A\t              ▲B\t          ▲C\t                   \n")
fprintf("-----------------------平面参数-------------------------    -------------------------真误差-------------------\n")
fprintf("\n  %12.6f\t   %12.6f\t   %12.6f\t\t          %12.6f\t   %12.6f\t   %12.6f\t      \n\n" , A , B , C,A+1,B-1,C-1 );
fprintf("-------------------------------------------------------end----------------------------------------------------\n\n")




%%  丹麦法稳健估计

close all

P = eye(numPoint);   %初始权值 n*n单位矩阵

[A,B,C] = Weight_PF( ColoredNoisePoints , P );
fprintf("\n\n-------------------------------丹麦法鲁棒估计--------------------------------\n")
fprintf("迭代次数\t          A\t              B\t              C\t           中误差\t         \n")
fprintf("-----------------------------------------------------------------------------\n")

plotPlane(A,B,C,ColoredNoisePoints);
hold on
pcshow(ColoredNoisePoints,[0,1,0],'MarkerSize',3);
%EMS=inf;
i=1;

while( i < 9 )
    
    RPAR = [A,B,C];
    
    w = ( abs(  ( A * ColoredNoisePoints(:,1) + B * ColoredNoisePoints(:,2) - ColoredNoisePoints(:,3) + C ) / sqrt( A^2 + B^2 + 1)   ) * 100 );
    
    RMS = sqrt ( ( w' * P * w ) / ( length(w) ) );  %中误差
    
    c = 1.5 * RMS;
    
    index = ( w > c);
    
%     pcshow(ColoredNoisePoints(index,1:3),[1,0,0],'MarkerSize',10);
    
    RP = ones(length(w),1);

    RP(index,1) = exp( 1.0- ( w ( index,1 ) / c ) .^ 2 ); 
    
    P = diag(RP);
    
    [A,B,C]=Weight_PF(ColoredNoisePoints,P);
    
    fprintf("\t%d\t\t  %12.6f\t   %12.6f\t   %12.6f\t   %12.6f\t     \n", i , A , B , C , RMS);
    
    i=i+1;

    
end

fprintf("------------------------------------end---------------------------------------\n")


fprintf("\n\n------------------------------------------------含粗差平面鲁棒估计--------------------------------------------\n")
fprintf("\t\tA\t              B\t              C\t                   \t\t▲A\t              ▲B\t          ▲C\t                   \n")
fprintf("-----------------------平面参数-------------------------    -------------------------真误差-------------------\n")
fprintf("\n  %12.6f\t   %12.6f\t   %12.6f\t\t          %12.6f\t   %12.6f\t   %12.6f\t      \n\n" , A , B , C,A+1,B-1,C-1 );
fprintf("-------------------------------------------------------end----------------------------------------------------\n\n")





%% 函数
function [A,B,C]=PF(Points)
    
    %这个方程是 AX+BY+CZ+1 = 0;

    x = Points(:,1);y = Points(:,2);z = Points(:,3);

    temp_xx = x' * x;
    temp_xy = x' * y;
    temp_yy = y' * y;
    temp_zx = z' * x;
    temp_zy = z' * y;
    temp_zz = z' * z;

    a = [temp_xx,temp_xy,temp_zx;
        temp_xy,temp_yy,temp_zy;
        temp_zx,temp_zy,temp_zz];
    
    b = [ sum(x);sum(y);sum(z)];

    c = -((a)^-1) * b;
    
    A = c(1)/-c(3) ; B = c(2)/-c(3); C =1 / -c(3);


end



function [A,B,C]=Weight_PF(Points,P)

    %这个方程是 AX+BY+CZ+1 = 0;

    x = Points(:,1);y = Points(:,2);z = Points(:,3);

    n = size(Points,1);

    temp_xx = x' * P * x;
    temp_xy = x' * P * y;
    temp_yy = y' * P * y;
    temp_zx = z' * P * x;
    temp_zy = z' * P * y;
    temp_zz = z' * P * z;

    a = [temp_xx,temp_xy,temp_zx;
        temp_xy,temp_yy,temp_zy;
        temp_zx,temp_zy,temp_zz];
    
    b = [ sum( x' * P);sum(y' * P);sum(z' * P)];

    c = -((a)^-1) * b;
    
    A = c(1)/-c(3) ; B = c(2)/-c(3); C =1 / -c(3);


end


function plotPlane(A,B,C,Points)

    [x,y]=meshgrid(min(Points(:,1)):0.01:max(Points(:,1)),min(Points(:,2)):0.01:max(Points(:,2)));  
    
    z=A*x+B*y+C;

    mesh(x,y,z);

end






