function [numberleft,numberright,number] =rulebreak(rule)%%»ñÈ¡µÄrule
    stringleft=zeros(5,1);
    stringright=zeros(5,1);
    numberleft=zeros(5,3);
    numberright=zeros(5,3);
    number=zeros(1,3);
    desr=rule;
    for n=1:3 
        i=0;
        for m=1:length(desr)
            try                
                strrep(desr(m,n),'[','');
                [mm1,mm2]=strtok(desr(m,n),',');
                mm2=strrep(mm2,',','');
                stringleft(m,1)=str2double(mm1);
                stringright(m,1)=str2double(mm2);
                i=i+1;
            catch
                numberleft(:,n)=stringleft;
                numberright(:,n)=stringright;
                number(1,n)=i;
                break
            end
        end
    end
end

