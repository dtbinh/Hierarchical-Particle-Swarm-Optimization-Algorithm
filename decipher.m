function result=decipher(x,D,L,xx,xxx)%%x����ԭʼ���ݣ�5����ʵ�ʷ��飬D����ά�ȣ�L��ʼ����Ⱥ���� ��xx,xxx������������ 2014��6��12��22:41:03
%% �����ֵ
for i=1:L
    x(i,:)=int32(abs(x(i,:))); %%random �������ֵֻ��������������������ʱ��������Ҫ��һ�¾���ֵ����Ϊ����ֵֻ���ڷ���λ���иı䣬ֵ�õĴ�С��������û�иı� ǿ��ת��int��
end

%% ��ʼ�����������ת��Ϊ�����ƺ͸�����
%���ĵ�1�е���5�����Եĸ�����
for j=1:2
    for i=1:L
        binary=dec2bin(x(i,j),5);  
        xx{i,j}=binary;
        gray_01(1)=binary(1);
            for ii=2:length(binary)
                gray_01(ii)=xor(binary(ii)-'0',binary(ii-1)-'0')+'0';
            end
        xxx{i,j}=gray_01; 
    end   
end

% for j=3:3
%     for i=1:L 
%          binary=dec2bin(x(i,j),2);  
%          xx{i,j}=binary;
%          gray_06(1)=binary(1);
%              for ii=2:length(binary)
%                 gray_06(ii)=xor(binary(ii)-'0',binary(ii-1)-'0')+'0';
%              end
%          xxx{i,j}=gray_06;
%     end  
% end

for i=1:L 
    binary=dec2bin(x(i,D),1);  
    xx{i,D}=binary;
    xxx{i,D}=binary;
end
                       
for j=3:3
    for i=1:L
        binary=dec2bin(x(i,j),5);  
        xx{i,j}=binary;
        gray_D(1)=binary(1);
        for ii=2:length(binary)
            gray_D(ii)=xor(binary(ii)-'0',binary(ii-1)-'0')+'0';
        end
        xxx{i,j}=gray_D;
    end
end

%% ���ظ������ʽ��Ԫ������
if(L==1)
   result=xxx(1,:);
else
    result=xxx;
end
clear i ii j D L binary gray_01 gray_06 gray_D x;
end


