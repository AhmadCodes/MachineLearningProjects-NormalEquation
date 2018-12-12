function [data] = read_excel(filePath, skiprows, to_numeric)

fprintf('Reading Data... Please wait. . . ')

%% Input handling
if nargin == 1 || isempty(skiprows)
    skiprows = 0;
end
if nargin <= 2 || isempty(to_numeric)
    to_numeric = 1;
end

%% Import Data

[~, ~, data] = xlsread(filePath);

data = data((skiprows+1):end, :); %skip the number of rows specified

if to_numeric == 1 %convert data into numeric
    
    sizeOfData = size(data);
    numOfRows = sizeOfData(1);
    numOfCols = sizeOfData(2);
    
    for row = 1:numOfRows
        for col = 1:numOfCols
            if ~isnumeric(cell2mat(data(row,col)))
                data(row,col) = strrep(data(row,col), ' ', ''); %remove spaces
                data(row,col) = num2cell(str2double(cell2mat(data(row,col))));
            end
        end
    end
    data = cell2mat(data);
    
end

fprintf('Done reading data!\n');
end
