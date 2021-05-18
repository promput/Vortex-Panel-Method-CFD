function [X, Y, theta_z, xu, yu, xl, yl, z, dzdx, x_hor] = airfoil_NAC4Digits(D1, D2, D3, D4, n, L)
    %creating chord linegrid
    dxdL = L/n; %length over half of the number of the boundary points
    x = 0:dxdL:L;
    x_hor = x;
    
    %finding thichness function
    D3D4 = D3*10 + D4;
    tm = D3D4/100;
    t = (tm/0.2) * ((0.2969 * (x.^(1/2))) - (0.1260 * x) - (0.3516 * (x.^2))...
        + (0.2843 * (x.^3)) - (0.1015 * (x.^4)));
    
    %finding Camber function and dzdx
    zm = D1/100;
    p = D2/10;
    iteration_length = length(x);
    z = zeros(1, iteration_length);
    dzdx = zeros(1, iteration_length);
    for i = 1:iteration_length
        x_cur = x(i);
        if x_cur <= p
            z(i) = zm * x_cur / (p^2) * (2*p - x_cur);
            dzdx(i) = (2*zm) / (p^2) * (p - x_cur);
        else
            z(i) = zm * (1 - x_cur) / ((1 - p)^2) * (1 + x_cur - 2*p);
            dzdx(i) = (2*zm) / ((1-p)^2) * (p - x_cur);
        end
    end
    %find theta, upper, and lower (x,y)
    theta_z = atan(dzdx);
    
    %ridding of nan
    theta_z(isnan(theta_z)) = 0;
    t(isnan(t)) = 0;
    z(isnan(z)) = 0;
    
    %locations of edge
    xu = x - t.*sin(theta_z);
    yu = z + t.*cos(theta_z);
    xl = x + t.*sin(theta_z);
    yl = z - t.*cos(theta_z);
    
    %counter clockwise convention
    X = [fliplr(xl) xu(:, 2:end)];
    Y = [fliplr(yl) yu(:, 2:end)];
    
end 