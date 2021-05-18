function [Cp] = method_findCpAnalytical(theta, U, alpha, r)
    alpha = alpha*pi/180;
    T = 4 * pi * r * U * sin(alpha);
    Cp = 1 - (2*sin(theta) + T/(2*pi*r*U)).^2;
end

