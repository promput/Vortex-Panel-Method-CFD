function [x_sep_point, y_sep_point] = method_separationPointThwaites(Si, stag_point_index, Ut, X, Y)
    % x set up
    S_u = Si(stag_point_index(2):end);
    S_l = fliplr(Si(1:stag_point_index(2)-1));

    % V set up
    x_u = 0;
    prev_S_u = 0;
    for i =  1:length(S_u)
        x_u = [x_u (x_u(i) + prev_S_u/2 + S_u(i)/2)];
        prev_S_u = S_u(i);
    end
    U_cu = [0 Ut(stag_point_index(2):end).'];
    
    x_l = 0;
    prev_S_l = 0;
    for i = 1:length(S_l)
        x_l = [x_l (x_l(i) + prev_S_l/2 + S_l(i)/2)];
        prev_S_l = S_l(i);
    end
    U_cl = [0 fliplr(abs(Ut(1:stag_point_index(2)-1))).'];
    
    % find separation distance 
    xbar_u = method_thwaites(x_u, U_cu);
    xbar_l = method_thwaites(x_l, U_cl);
    
    % iterate to find distance travel to x_bar
    for i = 1:length(U_cu)
        upper_sep_index = i;
        if x_u(i) >= xbar_u
            break
        end
    end
    
    for i = 1:length(U_cu)
        lower_sep_index = i;
        if x_l(i) >= xbar_l
            break
        end
    end
    % summary
    upper_index = stag_point_index(2) + upper_sep_index;
    lower_index = stag_point_index(2) - lower_sep_index;
    x_sep_point = [X(upper_index), X(lower_index)]; %[x_sep_u, x_sep_l]
    y_sep_point = [Y(upper_index), Y(lower_index)]; %[y_sep_u, y_sep_l]
end