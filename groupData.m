function cars = groupData(data,columnNumber)


totalCars = max(data(:,1));
for carNumber  = 1:totalCars
    cars{carNumber} = data(data(:,columnNumber)==carNumber,:);
end

end