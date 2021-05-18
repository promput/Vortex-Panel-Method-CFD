function [theta] = tool_findPanelTheta(X,Y)
    % input:
    % X and Y is the locations of the control panel end (TE), [1, np] dim
    % output:
    % x and y is the location of the control panel center, [1, np] dim
    
    np = length(X) - 1;
    theta = zeros(1, np);   
    for i = 1:np
        theta(1, i) = atan2((Y(1, i+1) - Y(1, i)), (X(1, i+1) - X(1, i)));
    end
end
