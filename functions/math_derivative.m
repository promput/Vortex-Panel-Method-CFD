function [dfdx] = math_derivative(x, f)
    % input
    % x: 
    %   x component of each point
    %   [1xN] diouble: where N is the number of points collected
    % fx: 
    %   y component of each point
    %   [1xN] diouble: where N is the number of points collected
    % output
    % dfdx:
    %   derivative of each point along x
    %   [1xN] diouble: where N is the number of points collected
    dfx = diff(f);
    dx = diff(x);
    dfdx = dfx./dx;
end