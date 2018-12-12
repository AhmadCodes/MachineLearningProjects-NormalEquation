
%% Initialization
clear all ; close all; clc;
global theta
%% =================== Importing and Cleaning Data ===================

%--------Reading Data---------
filePath = 'Data set.xlsx';
toNumeric = 1;
data = read_excel(filePath, toNumeric);

%--------Data Inspection------
inspectData(data); % plots each feature vs price, prices of each car, etc.

%---------Clean Data----------
data = dataCleaning(data); %reduce apparent outliers in features

% ---Post Cleaning Inspection---
inspectData(data,1); % plots each feature vs price, prices of each car, etc.


%--------Grouping Data--------
columnNumber = 1; %group data by first column(Car).
cars = groupData(data,columnNumber);



%% =================== Training Data ===================


totalCategories = length(cars);

for category = 1:totalCategories
    
    %-- read data of each car categorically--
    allData = cars{category}; % read data from the grouped category
    allData(:,10) = minimizeOutliers(allData(:,10)); %get price between 5th-95th %tile
    cars{category} = allData; % store data back in the cell location
    
    % ---divide data into training and testing data sets---
    n = length(allData);
    [trainInd,valInd,testInd] = dividerand(n,0.7,0.2,0.1);
    trainData = allData(trainInd,:);
    trainingData{category} = allData(trainInd,:); % store training data
    testData{category} = allData([testInd,valInd],:); %store testing data
    
    %-- define X and y
    X = trainData(:,2:end-1);
    y = trainData(:,end);
    
    %---add intercept term Xo = 1---
    m = length(y);
    X = [ ones(m,1),X];
    
    %---find optimal thetas by normal equation---
    t = (pinv(X'*X))*X'*y;
    
    %--store data categorically--
    theta{category} = t;
    
    
end
%%
% ====== Costs given by test data =======

for category = 1:totalCategories
    
    %--read data categorically--
    t = theta{category};
    testingData = testData{category};
    Xtest= testingData(:,2:end-1);
    ytest= testingData(:,end);
    
    %---add intercept term Xo =1---
    m = length(Xtest);
    Xtest = [ones(m,1), Xtest ];
    
    %--calculate and store error categorically--
    m = length(y); % number of examples
    J(category) = ((t'*Xtest')' - ytest)'*((t'*Xtest')' - ytest)/(2*m);
    
    
end

fprintf('\nmean of all MSE''s = %.4f\n',mean(J));
