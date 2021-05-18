function [X, Y] = make_airfoil_example()
    x_foil = [1.000, 0.933, 0.750, 0.500, 0.250, 0.067, 0.000, 0.067, 0.250, 0.500, 0.750, 0.933, 1.000];
    y_foil = [0.0, -0.005, -0.017, -0.033, -0.042, -0.033, 0.00, 0.045, 0.076, 0.072, 0.044, 0.013, 0.0];
    n = length(x_foil);
    X = zeros(n, 1);
    Y = zeros(n, 1);
    for i = 1:n
        X(i) = x_foil(i);
        Y(i) = y_foil(i);
    end
end

