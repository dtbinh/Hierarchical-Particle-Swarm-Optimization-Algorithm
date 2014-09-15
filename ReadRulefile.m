function ReadRulefile(filename)
%% 读取复杂Excel表的使用方法
sheetName='Sheet1';
[numbers, strings] = xlsread(filename, sheetName);
if ~isempty(numbers)
    newData1.data =  numbers;
end
if ~isempty(strings)
    newData1.textdata =  strings;
end

% Create new variables in the base workspace from those fields.
vars = fieldnames(newData1);
for i = 1:length(vars)
    assignin('base', vars{i}, newData1.(vars{i}));
end

end

