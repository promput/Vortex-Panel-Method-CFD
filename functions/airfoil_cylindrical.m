function [X, Y] = airfoil_cylindrical(np, r, thresh_theta)
    % input:
    % np is the number of control panels we want to install on a cylinder
    % r is the radius of the cylinder
    % theta given in deg
    % output:
    % x and y is the location of the control panel end (TE)
    thresh_rad = thresh_theta*pi/180;
    X = zeros(1, np + 1);
    Y = zeros(1, np + 1);
    for i = 1:np
        rotating_angle = 2 * pi * (i - 1) / np;
        X(i) = r*cos(thresh_rad - rotating_angle);
        Y(i) = r*sin(thresh_rad - rotating_angle);
    end
    X(np + 1) = X(1);
    Y(np + 1) = Y(1);
end
