function [stag_point_index, stag_edges] = method_stagnationPoint(Ut, X, Y)
    Ut_new = [Ut(length(Ut)); Ut];
    stag_point_index = [];
    edges = [];
    e = 1;
    for i = 1:length(Ut)
        if (Ut_new(i+1) * Ut_new(i)) < 0
            stag_point_index = [stag_point_index i];
            edges(e, 1) = X(1, i);
            edges(e, 2) = Y(1, i);
            e = e + 1;
        end
    end
    stag_edges = edges;
end