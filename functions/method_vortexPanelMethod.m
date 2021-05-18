function [A_normal, B_normal, A_tangential, B_tangential, d] = method_vortexPanelMethod(x, X, y, Y, theta, U, alpha, Si)
    % The purpose of finding A and B is so that we could use .\ method to
    % solve Ax = B
    % A has [#control_point x #control_point] dim
    % B has [#control_point x 1] dim
    % n is an integer determining second dimension of A
    
    % initialing dimension
    d = length(X);
    m = d - 1;
    
    % pre-allocate space for A and B matrix in normal direction
    A_normal = zeros(m, d);
    B_normal = zeros(m, 1);
    A_tangential = zeros(m, d);
    B_tangential = zeros(m, 1);
    
    %calculating vanishing velocity components at each control point 
    for i = 1:m
        for j = 1:m
            S_j = Si(j);
            A = -((x(1, i) - X(1, j)) * cos(theta(1, j))) - ((y(1, i) - Y(1, j))  * sin(theta(1, j)));
            B = ((x(1, i) - X(1, j)) ^ 2) + ((y(1, i) - Y(1, j)) ^ 2);
            C = sin(theta(1, i) - theta(1, j));
            D = cos(theta(1, i) - theta(1, j));
            E = ((x(1, i) - X(1, j)) * sin(theta(1, j))) - ((y(1, i) - Y(1, j)) * cos(theta(1, j)));
            F = log(1 + ((S_j ^ 2) + (2 * A * S_j)) / B);
            G = atan2((E * S_j), (B + (A * S_j)));
            P = ((x(1, i) - X(1, j)) * sin(theta(1, i) - (2 * theta(1, j)))) ...
                + ((y(1, i) - Y(1, j)) * cos(theta(1, i) - (2 * theta(1, j))));
            Q = ((x(1, i) - X(1, j)) * cos(theta(1, i) - (2 * theta(1, j)))) ...
                - ((y(1, i) - Y(1, j)) * sin(theta(1, i) - (2 * theta(1, j))));
            C_t2ij = C + (0.5 * P * F) / S_j + (A * D - C * E) * G / S_j;
            C_t1ij = (0.5 * C * F) - (D * G) - C_t2ij;
            C_n2ij = D + (0.5 * Q * F / S_j) - ((((A * C) + (D * E)) * G) / S_j);
            C_n1ij = (0.5 * D * F) + (C * G) - C_n2ij;
            if i == j
                C_t2ij = pi / 2;
                C_t1ij = pi / 2;
                %C_n2ij = 1.0;
                %C_n1ij = -1.0;
            end
            A_normal(i, j) = A_normal(i, j) + C_n1ij;
            A_normal(i, j + 1) = A_normal(i, j + 1) + C_n2ij;
            A_tangential(i, j) = A_tangential(i, j) + C_t1ij;
            A_tangential(i, j + 1) = A_tangential(i, j + 1) + C_t2ij;
        end
        B_normal(i, 1) = (U * sin(theta(i) - alpha)); % need to add the 2 * pi term
        B_tangential(i, 1) = cos(theta(1, i) - alpha); % need to add the 2 * pi term
    end
end