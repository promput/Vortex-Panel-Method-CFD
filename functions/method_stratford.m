function [xb] = method_stratford(x, Ut)
    %start
    [val, idx] = max(Ut);
    xm = x(idx);
    Um = val;
    
    Cp_bar = 1 - (Ut.^2)./(Um^2);
    
    % just like thwaites
    dCPdx = math_derivative(x, Cp_bar);
    
    % integral term
    xm_bar = cumtrapz(x, (Ut/Um).^ 5);
    xm_bar = xm_bar(end);
    
    % x_bar
    x_bar = x - (xm - xm_bar);
    % K term
    K = (x_bar(1:end-1).^2) .* Cp_bar(1:end-1) .* (dCPdx.^2);
    threshold = 0.0104;
    
    % finding threshold
    ind_c = find(K<=threshold,1);
    ind_b = ind_c - 1;
    %disp(ind_c)
    %disp(ind_b)
    px = [x(ind_c),x(ind_b)];
    py = [K(ind_c),K(ind_b)];
    coefficients = polyfit(px, py, 1);
    a = coefficients (1);
    b = coefficients (2);
    xb = (threshold - b)/a;
end

