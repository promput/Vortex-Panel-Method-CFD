function [gammas, Ut, Cp] = method_solveKuttaCondition(A_normal, B_normal, A_tangential, B_tangential, d)
    % add kutta condition
    A_kutta = zeros(1, d);
    A_kutta(1, 1) = 1;
    A_kutta(1, d) = 1;
    B_kutta = zeros(1, 1);
    A_tot = vertcat(A_normal, A_kutta);
    B_tot = vertcat(B_normal, B_kutta);
    %disp(B_tot);

    % solve the linear equations for gammas
    gammas = A_tot\B_tot;
    %dummy = gammas(1);
    %gammas(1) = gammas(end);
    %gammas(end) = dummy;

    % find tangental velocity (Gammas) from sets of linear equations
    Ut = B_tangential + (A_tangential * gammas);
    
    %find
    Cp = 1 - Ut.^2;
end