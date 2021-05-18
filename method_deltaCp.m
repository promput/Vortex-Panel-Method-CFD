function [deltaCp, x_cord, Cp_upper, Cp_lower] = method_deltaCp(x, Cp, np, AoA)
    x_cord = x(np+1:end);
    Cp_upper = flip(Cp(1:np));
    Cp_lower = Cp(np+1:end);
    deltaCp = Cp_upper - Cp_lower;
end

