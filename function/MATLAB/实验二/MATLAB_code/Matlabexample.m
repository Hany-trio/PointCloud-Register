%% example 1 �����
clc
clear
close all

% + -
1+1
1+2
1-3

% * / \ �� ���ҳ�

3*4
3/2
2\3

% ^ �˷�
2^2
8^2



%% example 2 �жϷ�
clc
clear
close all

% ~= ������
1 ~= 1

% &��|������
1 & 0
1 & 1
1 | 1
1 | 0
0 | 0

% ~ȡ��
~(4>2)

% ISEMPTY �Ƿ�Ϊ��
A=[];
isempty(A)

% ISNAN �Ƿ���ֵ
isnan('K')

% ISINF �Ƿ������
isinf(1/0)

%% example 3 �߼�����
clc
clear 
close all

%% example ���鴴��
clc
clear
close all

%ֱ�ӹ���
A=[1,2,3,4] %������
B=[1;2;3;4] %������

C=[1,2,3;4,5,6] %2*3����

%�������� (��ʼ������������)
D=1:0.5:3

%�ȼ������ ��ʼ��ֵ ������ֵ ������ 
E=linspace(1:4:5)

% ���ú�������
F=zeros(2,3)
H=onse(2,3)
G=rand(2,3)   % rand:���ȷֲ�,randn:��˹�ֲ�;
K=eye(4)

% Ԫ�ض�ȡ��ʽ
C=[1,2,3;4,5,6]

C(1,2) %ȡ��Ԫ��
C(:,1) %ȡ��һ��
C(1,:) %ȡ��һ��
C(1,2:3) %ȡ��һ�е� 2-3Ԫ��


%% example 4 ��������
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

% 'ת��
A'
D'

% ����ʽ
det(A)

%diag 
diag(A)

% [v,d]=eig �����������������ֵ
[v,d]=eig(C);
v
d

%trace ��
trace(C)

%% example ���̿���
% for ѭ��
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
%% example 3 ��ʽ����
clc
clear
close all




%% example 4 �ı�����
clc
clear
close all

%% example 5 ���ƶ�άͼ��
clc
clear
close all

%% example 6 ͼ�����
clc
clear
close all

%% example 7 ������άͼ


%% example  ����
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
xi = sin(2*pi*493.88*t);                    %�����Ľ���440����ô���ģ�
sound(la, fs)

%do re mi fa sol la xi�����ǵ�pֵ�ֱ�Ϊ 60 62 64 65 67 69 71
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
