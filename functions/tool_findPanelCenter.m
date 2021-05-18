function [x, y, Si] = tool_findPanelCenter(X,Y)
    % input:
    % X and Y is the locations of the control panel end (TE), [1, np] dim
    % output:
    % x and y is the location of the control panel center, [1, np] dim
    
    np = length(X) - 1;
    Si = zeros(1, np);
    x = zeros(1, np);
    y = zeros(1, np);   
    for i = 1:np
        x(1, i) = (X(1, i) + X(1, i+1))/2;
        y(1, i) = (Y(1, i) + Y(1, i+1))/2;
        Si(1, i) = sqrt((X(1, i+1) - X(1, i))^2 + (Y(1, i+1) - Y(1, i))^2);
    end
end