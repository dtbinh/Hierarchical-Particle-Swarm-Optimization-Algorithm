%% �жϷֶ�  �ȷ���19������  
function result=getrule(xxx,textdata,rule) %%����Ĳ����Ǹ����� 
for i=1:3%% ��߽�19��Ϊ18
    value=xxx{1,i};
    jj=1;
    if length(value)>5 %%�����˵����ǰ�ĸ�����ֻ����5λ
        break;
    else
        for ii=1:length(value)
            aa=value(ii);      
            if isequal(aa,'1')                
                rule{jj,i}=textdata{ii,i};
                jj=jj+1;
            else
            end   
        end
    end
end
rule(1,4)=xxx(1,4);%% ��xxx��19�з���rule��19��  

%% ���ػ�ȡ��һ������
result=rule;
clear aa i ii jj value;
end

