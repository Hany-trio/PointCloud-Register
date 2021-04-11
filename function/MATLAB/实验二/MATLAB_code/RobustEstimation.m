%% 稳健估计

%% 残差绝对和最小法
clc
clear
close all

x=[10.001,10.002,9.998,9.993,10.001,10.008,10.100,9.997];   


length_x = length(x);


fprintf("\n\n----------------------------------------------------残差绝对和最小法---------------------------------------\n")
fprintf("迭代次数\t    W1\t      W2\t    W3\t      W4\t    W5\t      W6\t     W7\t      W8\t        X/m\n")
fprintf("-----------------------------------------------------------------------------------------------------------\n\n")

 % 假设所有权值为1 平均值为
 
mean_x = sum(x) / length_x;

Bmean_x = inf;

k = (10^(-6));

i=1;   %记录迭代步数
while( abs(mean_x - Bmean_x) > 0.00003 )
    
    Bmean_x = mean_x;
    
    % 定权
    W = ones(1,8) ./ ( abs( (x - mean_x) ) + k );

    mean_x = sum( W .* x ) / sum( W );
    
    fprintf("\t%d     %10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%16.6f \n",i,W(1,:),mean_x );
    
    i = i+1;
    
end

fprintf("\n----------------------------------------------------end----------------------------------------------------\n\n\n")





%%  丹麦法

clear


x=[10.001,10.002,9.998,9.993,10.001,10.008,10.100,9.997];   

length_x=length(x);

fprintf("\n\n-------------------------------------------------------丹麦法--------------------------------------------------------\n")
fprintf("迭代次数\t    W1\t      W2\t    W3\t      W4\t    W5\t      W6\t         W7\t           W8\t        X/m\n")
fprintf("---------------------------------------------------------------------------------------------------------------------\n\n")

% 假设观测值权为1，加权平均值为
mean_x=sum(x)/length(x);

Bmean_x = inf;

P = ones( length_x , 1 ); %权初始值为1

i=1;

while ( abs( mean_x - Bmean_x ) > 0.0003 )
    
    Bmean_x = mean_x;

    RMS = sqrt ( ( (x - mean_x) * diag( P ) * (x - mean_x)' ) / ( length(x) ) );  %中误差

    v = abs( x - mean_x );

    c = 1.5 * RMS;   %系数c取值为中误差的1.5倍

    indx = ( v > c );

    RP = ones( 1 , length(x) );

    RP( 1 , indx ) = exp( 1 - ( v( 1,indx ) / c ) .^ 2 ); 

    P = RP ;  %权值更新
    
    mean_x = sum(P .* x) / sum(P);

    fprintf("\t%d    %10.2f%10.2f%10.2f%10.2f%10.2f%10.2f%19.9f%10.2f%16.6f \n",i,P(1,:),mean_x );
    i=i+1;
    
end

fprintf("\n-------------------------------------------------------end-----------------------------------------------------------\n")