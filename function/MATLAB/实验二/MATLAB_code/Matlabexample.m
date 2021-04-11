%% example 1 运算符
clc
clear
close all

% + -
1+1
1+2
1-3

% * / \ 乘 左右除

3*4
3/2
2\3

% ^ 乘方
2^2
8^2



%% example 2 判断符
clc
clear
close all

% ~= 不等于
1 ~= 1

% &与|操作符
1 & 0
1 & 1
1 | 1
1 | 0
0 | 0

% ~取反
~(4>2)

% ISEMPTY 是否为空
A=[];
isempty(A)

% ISNAN 是否数值
isnan('K')

% ISINF 是否无穷大
isinf(1/0)

%% example 3 逻辑运算
clc
clear 
close all

%% example 数组创建
clc
clear
close all

%直接构造
A=[1,2,3,4] %行向量
B=[1;2;3;4] %列向量

C=[1,2,3;4,5,6] %2*3矩阵

%步长生成 (开始：步长：结束)
D=1:0.5:3

%等间距生成 起始数值 结束数值 生成数 
E=linspace(1:4:5)

% 内置函数生成
F=zeros(2,3)
H=onse(2,3)
G=rand(2,3)   % rand:均匀分布,randn:高斯分布;
K=eye(4)

% 元素读取方式
C=[1,2,3;4,5,6]

C(1,2) %取单元素
C(:,1) %取第一列
C(1,:) %取第一行
C(1,2:3) %取第一行的 2-3元素


%% example 4 数组运算
clc
clear
close all


A = [1,3];
B = [2,0];
C=[1,3;4,7];
D=[3,1;6,2];

% + - * 
A+B
A-B
A*B

% .*
A.*B
C.*D

% ./
A./B
C./D

% '转置
A'
D'

% 行列式
det(A)

%diag 
diag(A)

% [v,d]=eig 求解特征向量和特征值
[v,d]=eig(C);
v
d

%trace 求迹
trace(C)

%% example 流程控制
% for 循环
for i=1:5
    i
end
for i=1:2:5
    i
end

% while
i=1;
while (i>4)
    i
    i=i+1;
end
%% example 3 格式输入
clc
clear
close all




%% example 4 文本读入
clc
clear
close all

%% example 5 绘制二维图表
clc
clear
close all

%% example 6 图像操作
clc
clear
close all

%% example 7 绘制三维图


%% example  ？？
clc
clear
close all

fs=44100;
t=0: 1/fs: 0.25;
do = sin(2*pi*261.63*t);
re = sin(2*pi*293.66*t);
mi = sin(2*pi*329.63*t);
fa = sin(2*pi*349.23*t);
sol = sin(2*pi*392*t);
la = sin(2*pi*440*t);
xi = sin(2*pi*493.88*t);                    %（下文介绍440是怎么来的）
sound(la, fs)

%do re mi fa sol la xi，它们的p值分别为 60 62 64 65 67 69 71
littestar=[do,do,sol,sol,la,la,fa,fa,mi,mi,re,re,do];
n=0.4;
sound(do, fs);
pause(n);
sound(do, fs);
pause(n);
sound(sol, fs);
pause(n);
sound(sol, fs);
pause(n);
sound(la, fs);
pause(n);
sound(la, fs);
pause(n);
sound(sol, fs);
pause(n*2);
sound(fa, fs);
pause(n);
sound(fa, fs);
pause(n);
sound(mi, fs);
pause(n);
sound(mi, fs);
pause(n);
sound(re, fs);
pause(n);
sound(re, fs);
pause(n);
sound(do, fs);



%% 
