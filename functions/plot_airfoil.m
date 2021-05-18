function plot_airfoil(fig_num, X, Y, x, y, lw, fs, axis_dim)
    figure(fig_num);
    hold on
    axis equal
    grid on
    plot(X(1, 1), Y(1, 1), 'o', 'color', 'k', 'linewidth', lw)
    for i = 1:length(X)-1
        plot([X(1, i), X(1, i+1)], [Y(1, i), Y(1, i+1)], '-', 'color', 'k');
        plot(x(1, i), y(1, i), 'x', 'color', '[0,0.5,0]', 'linewidth', lw)
        plot(X(1, i), Y(1, i), '.', 'color', 'k', 'linewidth', lw)
    end
    axis(axis_dim)
    xlabel('X [unit L]','Fontsize', fs)
    ylabel('Y [Unit L]','Fontsize', fs)
    legend('TE','boundary edge', 'boundary panel', 'control point', 'Fontsize', fs)
end