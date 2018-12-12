function inspectData(data,levelOfInspection)
%% input handling
if nargin == 1 || isempty(levelOfInspection)
    levelOfInspection = 4;
end
%% function definition:
names = {'Car model', ' Manufacturing Year ', ' Meter Reading ', ' Transmission ',' Registered City ', ' Color ',	' Assembly ', ' Engine Capacity ', ' Body Type '};
l = levelOfInspection;
%----only plot x against y--
if l >=1
    figure,hold on
    for i = 1:9
        
        subplot(3,3,i)
        mystr = strcat( names(i),'vs y');
        scatter(data(:,i),data(:,end));
        title(mystr);
    end
    hold off
end


%--also plot prices of cars categorically--
if l>=2
    totalCars = max(data(:,1));
    
    figure;
    hold on
    
    for carNumber = 1:totalCars
        
        car =  data(data(:,1)==carNumber,:);

        subplot(4,4,carNumber);
        scatter(1:length(car),car(:,end))
        mystr = strcat('Prices of car ',num2str(carNumber));
        xlabel('Car Number');ylabel('Price')
        title(mystr);
    
    end
    hold off
end

%--also histogram of prices category wise---
if l>=3
    ranges = [];
    figure;
    hold on
    for carNumber = 1:totalCars
        car =  data(data(:,1)==carNumber,:);
        
        ranges = [ranges; carNumber,prctile(car(:,10),15),prctile(car(:,10),85)];
        
        subplot(4,4,carNumber);
        hist(car(:,end),3)
        mystr = strcat('Prices of car ',num2str(carNumber));
        xlabel('price');ylabel('# of cars');
        title(mystr);
        
    end
    hold off
end

%-- also table of approximate ranges of prices category wise--
if l>=4
    T = table(ranges(:,1),ranges(:,2),ranges(:,3),'VariableNames',{'car','fifteenth','nintyfifth'});
    disp(T);
end

end