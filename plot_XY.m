function plot_XY(num_fig, x, y, xlab, ylab, leg, lw, fs, style, c)
    figure(num_fig)
    grid on
    hold on
    xlabel(xlab, 'Fontsize', fs) %label the x-axis
    ylabel(ylab, 'Fontsize', fs) %label the y-axis
    for i = 1:length(x)
        [x2, y2] = math_ascendingSort(x{i}, y{i});
        x2 = x{i};
        y2 = y{i};
        %disp(size(x2))
        %disp(size(y2))
        plot(x2, y2, style, 'color', c{i}, 'linewidth', lw);
    end
    legend(leg, 'Fontsize', fs);
end