function plot_sepStagPoint(fig_num, X, Y, stag_edges, x_sep_point, y_sep_point, lw, fs, axis_dim)
    figure(fig_num);
    hold on
    axis equal
    grid on
    plot(stag_edges(1, 1), stag_edges(1, 2), 'o', 'color', 'r');
    plot(x_sep_point(1), y_sep_point(1), 'o', 'color', 'b')
    for i = 1:length(X)-1
        plot(X(1, i), Y(1, i), '.', 'color', 'k', 'linewidth', lw)
        plot([X(1, i), X(1, i+1)], [Y(1, i), Y(1, i+1)], '-', 'color', 'k');
    end
    plot(stag_edges(2, 1), stag_edges(2, 2), 'o', 'color', 'r');
    plot(x_sep_point(2), y_sep_point(2), 'o', 'color', 'b')
    axis(axis_dim)
    xlabel('X [unit L]','Fontsize', fs)
    ylabel('Y [Unit L]','Fontsize', fs)
    legend('Stagnation Point', 'Separation Point', 'TE','boundary edge', 'boundary panel', 'Fontsize', fs)
end

