function [x_sep_point, y_sep_point, x_bar_all] = method_separationPointStratford(np, stag_point_index, Ut, X, Y, x)
    % find separation distance 
    x_bar_all = method_stratford(x, Ut);

    for i = 1:length(Ut)
        upper_sep_index = i;
        if x(i) >= x_bar_all
            break
        end
    end
    upper_index = stag_point_index(2) + upper_sep_index;
    x_sep_point = X(upper_index); %[x_sep_u, x_sep_l]
    y_sep_point = Y(upper_index); %[y_sep_u, y_sep_l]
    
%     disp('yayyy')
%     xbar_u = method_stratford(x(np+1:end), Ut(np+1:end));
%     xbar_l = method_stratford(fliplr(x(1:np)), fliplr(Ut(1:np)));
%     
%     % iterate to find distance travel to x_bar
%     for i = 1:length(U_cu)
%         upper_sep_index = i;
%         if x_u(i) >= xbar_u
%             break
%         end
%     end
%     
%     for i = 1:length(U_cu)
%         lower_sep_index = i;
%         if x_l(i) >= xbar_l
%             break
%         end
%     end
%     % summary
%     upper_index = stag_point_index(2) + upper_sep_index;
%     lower_index = stag_point_index(2) - lower_sep_index;
%     x_sep_point = [X(upper_index), X(lower_index)]; %[x_sep_u, x_sep_l]
%     y_sep_point = [Y(upper_index), Y(lower_index)]; %[y_sep_u, y_sep_l]
end