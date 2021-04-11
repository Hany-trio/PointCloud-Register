%% main

clc
clear
close all


A=-1;B=1;C=1;    % ����ƽ�������������ά��

Points( : , 1:2 ) = [unifrnd(1,2,300,1),unifrnd(1,2,300,1)];  % ����300����

Points(:,3) = A*Points(:,1)+B*Points(:,2)+C;  %ƽ�淽��Ϊ A*x+B*y+C = z;

numPoint = length(Points); %������

% pcshow(Points,[0,0,0]); %��ʾ��

fprintf("��ά���������...\n");

hold on

%% ����ƽ��

[x,y]=meshgrid(min(Points(:,1)):0.01:max(Points(:,1)),min(Points(:,2)):0.01:max(Points(:,2)));  

z=A*x+B*y+C;

mesh(x,y,z);
fprintf("����ƽ��...\n");



%% ���żȻ���


WhiteNoisePoints(:,1) = Points(:,1) + ( randn( numPoint,1 ) * 0.01);  %���������Ϊ0.01����̬�����
WhiteNoisePoints(:,2) = Points(:,2) + ( randn( numPoint,1 ) * 0.01);
WhiteNoisePoints(:,3) = Points(:,3) + ( randn( numPoint,1 ) * 0.01); 

pcshow(WhiteNoisePoints,[0,1,0],'MarkerSize',10);

[A,B,C]=PF(WhiteNoisePoints);      % 
 
fprintf("\n\n---------------------------------------------��żȻ���ƽ��������------------------------------------------\n")
fprintf("\t\tA\t              B\t              C\t                   \t\t��A\t              ��B\t          ��C\t                   \n")
fprintf("-----------------------ƽ�����-------------------------    -------------------------�����-------------------\n")
fprintf("\n  %12.6f\t   %12.6f\t   %12.6f\t\t          %12.6f\t   %12.6f\t   %12.6f\t      \n\n" , A , B , C,A+1,B-1,C-1 );
fprintf("---------------------------------------------------------end--------------------------------------------------\n\n")






%% ����
function [A,B,C] = PF( Points )
    
    %������ AX+BY+CZ+1 = 0;

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

