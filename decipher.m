function result=decipher(x,D,L,xx,xxx)%%x代表原始数据，5代表实际分组，D代表维度，L初始粒子群数量 讲xx,xxx当做参数传入 2014年6月12日22:41:03
%% 求绝对值
for i=1:L
    x(i,:)=int32(abs(x(i,:))); %%random 算出来的值只能是正数，如果计算出来时负数，就要求一下绝对值，因为绝对值只有在符号位上有改变，值得的大小二进制数没有改变 强制转换int型
end

%% 开始对随机数进行转换为二进制和格雷码
%更改第1列到第5列属性的格雷码
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

%% 返回格雷码格式的元胞数组
if(L==1)
   result=xxx(1,:);
else
    result=xxx;
end
clear i ii j D L binary gray_01 gray_06 gray_D x;
end


