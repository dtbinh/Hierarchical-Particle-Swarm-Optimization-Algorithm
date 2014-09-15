%% 判断分段  先放入19个规则  
function result=getrule(xxx,textdata,rule) %%放入的参数是格雷码 
for i=1:3%% 这边将19改为18
    value=xxx{1,i};
    jj=1;
    if length(value)>5 %%这边是说明当前的格雷码只能是5位
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
rule(1,4)=xxx(1,4);%% 将xxx的19列放入rule的19列  

%% 返回获取的一条规则
result=rule;
clear aa i ii jj value;
end

