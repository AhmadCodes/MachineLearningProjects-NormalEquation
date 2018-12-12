function [data_out,maxiter, miniter] = minimizeOutliers(data)
miniter = 0;
maxiter = 0;
columns = size(data,2);

for column = 1:columns
    X = data(:,column);
    
    minn  = prctile(X,2);
    maxx = prctile(X,98);
    fctr = (max(X)-min(X))/length(X);
    while max(X) > maxx
        X(find(X > maxx )) = X(find(X > maxx ))-(fctr);
        maxiter = maxiter +1;
    end
    while min(X) < minn 
        X(find(X < minn )) = X(find(X < minn ))+fctr;
        miniter = miniter+1;
    end
    data(:,column) = X;
    
end
data_out = data;
end
