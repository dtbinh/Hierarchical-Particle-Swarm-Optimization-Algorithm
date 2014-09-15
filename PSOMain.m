%% �������
tic;
clear all;
close all;
clc;
time=toc;
fprintf('�������-time=%d\n',time); 

%% ��ʼ������(һ���Բ���)
tic;
c1=2;
c2=2;
% w=0.7298;
mean_max=0.8;
mean_min=0.5;
sigma=0.2;
D=4;%�����ռ�ά������Ϊ7�����Ժ�1�����ࣩ
N=100;%��ʼ������Ⱥ���ɸĲ�����
M=100;%�����������ɸĲ�����
A=zeros(2,2);
x=zeros(N,D);%����8�����Ե�����
x_up=zeros(N,D-1);%����7�����Ե����飬��Ҫ�������й�ʽ�ĸ���
y=zeros(N,D-1);%��������ϴε�����
p=zeros(1,N);%������Ÿ�������
pg_up=zeros(1,D-1);%�������ȫ�����ŵ�λ�ã����ڹ�ʽ�ĸ���
rule=cell(1,4);%��Ź���
time=toc;
fprintf('��ʼ������-time=%d\n',time); 

%% ��ʼ������ �� ��ȡԭʼ����(һ���Բ���)
tic;
ReadRulefile('class_third.xls');%��ȡ̨�����ݷֶε�Excel��Ĭ�Ϸ���textdata����
[num]=xlsread('Weakintensity_third.xls');%��ȡexcel���е���ֵ����
time=toc;
fprintf('��ʼ������Ͷ�ȡԭʼ����-time=%d\n',time); 

%% ��ʼ��Ⱥ��λ�ú��ٶ�(һ���Բ���)
tic;
for i=1:2
   x(:,i)=randi([1,2^5-1],N,1); %����1-2^5֮���N��1�е���������
end
for i=3:3
    x(:,i)=randi([1,2^5-1],N,1); %����1-2^2֮���N��1�е���������
end
% for i=4:D-1    
%     x(:,i)=randi([1,2^5-1],N,1);%����1-2^5֮���N��1�е���������
% end
x(:,D)=randi([0,1],N,1);%����0����1��N��1������ֵ
v_up=zeros(N,D-1);%�趨��ʼ�ٶ�
time=toc;
fprintf('��ʼ��Ⱥ��λ�ú��ٶ�-time=%d\n',time); 

%% �������(���³���ᾭ���õ�)
tic;
xx=cell(N,D);%����Ķ�����Ԫ������
xxx=cell(N,D);%����ĸ�����Ԫ������
xxx=decipher(x,D,N,xx,xxx);
time=toc;
fprintf('�������-time=%d\n',time); 
%% x��������
tic;
for i=1:D-1
    x_up(:,i)=x(:,i);
%     v_up(:,i)=x_up(:,i);
end 
time=toc;
fprintf('x��������-time=%d\n',time);
%% �ȼ���������ӵ���Ӧ�ȣ�����ʼ��Pi��Pg
tic;
for i=1:N
    a1_test=getrule(xxx(i,:),textdata,rule);%textdata��ReadRulefile('class.xls');��õ�����
    p(i)=fitness(num,a1_test);
    y(i,:)=x_up(i,:);
end
%ȫ�ֱ���
pg=x(1,:);
pg_goal=p(1);

time=toc;
fprintf('��ʼ��Pi��Pg-time=%d\n',time); 

%% �ҵ�ȫ������
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
fprintf('�ҵ�ȫ������-time=%d\n',time); 

%% ��ʼ����
diary('D:\result.txt');    
diary on;
disp('----------��ʼ����----------')
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
    disp('-----����λ��-----��')
    disp(int32(abs(pg)));
    disp('-----A���鷵��ֵ-----��')
    disp(A);
    plot(t,pg_goal,'b+','LineWidth',5)
    hold on
end
diary off;



        




        
     
   


     

    
 







