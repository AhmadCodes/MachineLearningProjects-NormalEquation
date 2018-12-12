function data = dataCleaning(data)
% custom made function for my own application, should not be applied
% general uses, delete call from mainFile for general use.


fprintf('\nCleaning Data\nPlease Wait . . \n')

%---clean column 3 of data--
while max(data(:,3)) > 1992200
    data(find(data == max(data(:,3)))) = data(find(data == max(data(:,3))))/10;
end
%---clean column 8 of data--
while max(data(:,8)) > 4000
    data(find(data == max(data(:,8)))) = data(find(data == max(data(:,8))))/10;
end

end