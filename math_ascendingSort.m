function [nX, nY] = math_ascendingSort(X, Y)
    [nX, sortIndex] = sort(X);
    nY = Y(sortIndex);
end

