%% 清理界面
tic;
clear all;
close all;
clc;
time=toc;
fprintf('清理界面-time=%d\n',time); 

%% 初始化参数(一次性操作)
tic;
c1=2;
c2=2;
% w=0.7298;
mean_max=0.8;
mean_min=0.5;
sigma=0.2;
D=4;%搜索空间维数（共为7个属性和1个分类）
N=100;%初始粒子种群（可改参数）
M=100;%迭代次数（可改参数）
A=zeros(2,2);
x=zeros(N,D);%带有8个属性的数组
x_up=zeros(N,D-1);%带有7个属性的数组，主要用来进行公式的更新
y=zeros(N,D-1);%用来存放上次的数据
p=zeros(1,N);%用来存放个体最优
pg_up=zeros(1,D-1);%用来存放全局最优的位置，用于公式的更新
rule=cell(1,4);%存放规则
time=toc;
fprintf('初始化参数-time=%d\n',time); 

%% 初始化规则 和 读取原始数据(一次性操作)
tic;
ReadRulefile('class_third.xls');%读取台风数据分段的Excel表，默认返回textdata数组
[num]=xlsread('Weakintensity_third.xls');%读取excel表中的数值数据
time=toc;
fprintf('初始化规则和读取原始数据-time=%d\n',time); 

%% 初始化群体位置和速度(一次性操作)
tic;
for i=1:2
   x(:,i)=randi([1,2^5-1],N,1); %产生1-2^5之间的N行1列的整型数据
end
for i=3:3
    x(:,i)=randi([1,2^5-1],N,1); %产生1-2^2之间的N行1列的整型数据
end
% for i=4:D-1    
%     x(:,i)=randi([1,2^5-1],N,1);%产生1-2^5之间的N行1列的整型数据
% end
x(:,D)=randi([0,1],N,1);%产生0或者1的N行1列整型值
v_up=zeros(N,D-1);%设定初始速度
time=toc;
fprintf('初始化群体位置和速度-time=%d\n',time); 

%% 解码过程(以下程序会经常用到)
tic;
xx=cell(N,D);%定义的二进制元胞数组
xxx=cell(N,D);%定义的格雷码元胞数组
xxx=decipher(x,D,N,xx,xxx);
time=toc;
fprintf('解码过程-time=%d\n',time); 
%% x更新数据
tic;
for i=1:D-1
    x_up(:,i)=x(:,i);
%     v_up(:,i)=x_up(:,i);
end 
time=toc;
fprintf('x更新数据-time=%d\n',time);
%% 先计算各个粒子的适应度，并初始化Pi和Pg
tic;
for i=1:N
    a1_test=getrule(xxx(i,:),textdata,rule);%textdata是ReadRulefile('class.xls');获得的数组
    p(i)=fitness(num,a1_test);
    y(i,:)=x_up(i,:);
end
%全局变量
pg=x(1,:);
pg_goal=p(1);

time=toc;
fprintf('初始化Pi和Pg-time=%d\n',time); 

%% 找到全局最优
tic;
for i=2:N
    if p(i)>pg_goal
        pg_goal=p(i);
        pg=x(i,:);
    end
end

for i=1:D-1
    pg_up(:,i)=pg(:,i);
end
time=toc;
fprintf('找到全局最优-time=%d\n',time); 

%% 开始迭代
diary('D:\result.txt');    
diary on;
disp('----------开始迭代----------')
for t=1:M
    tic;
    for i=1:N
        miu=mean_min+(mean_max-mean_min)*rand();
        w=miu+sigma*randn();
        v_up(i,:)=w*v_up(i,:)+c1*rand*(y(i,:)-x_up(i,:))+c2*rand*(pg_up-x_up(i,:));
        x_up(i,:)=x_up(i,:)+v_up(i,:);
        x(i,:)=[x_up(i,:),x(i,4)];
        a2_test=decipher(x(i,:),D,1,xx,xxx);
        a3_test=fitness(num,getrule(a2_test,textdata,rule));
        if a3_test>p(i)
            p(i)=a3_test;
            y(i,:)=x_up(i,:);
        end
        if p(i)>pg_goal
            pg_up=y(i,:);
            pg=[y(i,:),x(i,4)];
            pg_decipher=decipher(pg,D,1,xx,xxx);
            [~,A]=fitness(num,getrule(pg_decipher,textdata,rule));
            pg_goal=p(i);
        end
    end
    time=toc;
    fprintf('gen=%d\tmax=%d\ttime=%d\n',t,pg_goal,time); 
    disp('-----最优位置-----：')
    disp(int32(abs(pg)));
    disp('-----A数组返回值-----：')
    disp(A);
    plot(t,pg_goal,'b+','LineWidth',5)
    hold on
end
diary off;



        




        
     
   


     

    
 







