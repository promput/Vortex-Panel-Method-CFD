function [xbar] = method_thwaites(x, U)
    % abstraction barrier
    f = U;

    % integral term;
    f_5 = f .^ 5;
    int_f = cumtrapz(x, f_5);
    
    % derivative term
    dfdx = math_derivative(x, f);
  
    % K term
    K = (0.45 .* f(1:end-1).^(-6)) .* (dfdx) .* int_f(1:end-1);
    threshold = -0.09;
    %threshold = 0.075;
    
    % finding threshold
    ind_c = find(K<=threshold,1);
    ind_b = ind_c - 1;
    px = [x(ind_c),x(ind_b)];
    py = [K(ind_c),K(ind_b)];
    coefficients = polyfit(px, py, 1);
    a = coefficients (1);
    b = coefficients (2);
    xbar = (threshold - b)/a; 
end