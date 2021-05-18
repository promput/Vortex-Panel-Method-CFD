%% House Keeping
% clear commands
clc;
clear all;
close all;

% graphing tools
fs = 15;
lw = 1;
sbuf = 0.25;
axis_dim = [-(0.05 + sbuf), (1.05 + sbuf), -(0.15 + sbuf), (0.15 + sbuf)];
graphing_params = [axis_dim, fs, lw];
colors = {'[0 0.4470 0.7410]', '[0.8500 0.3250 0.0980]', '[0.9290 0.6940 0.1250]', '[0.4940 0.1840 0.5560]', '[0 0.5 0]', '[0.6350 0.0780 0.1840]'};

%% Problem Statement
% input needed
np = 64;
c = 1;
U = 1;
alpha = 0;
[D1, D2, D3, D4] = deal(0,0,1,2);

%% Make Airfoil
[X, Y, theta_z, xu, yu, xl, yl, z, dzdx, x_hor] = airfoil_NAC4Digits(D1, D2, D3, D4, np, c);
[x, y, Si] = tool_findPanelCenter(X,Y);
theta = tool_findPanelTheta(X,Y);
Theta = 2*pi:-1/np*2*pi:1/np*2*pi;

%% Project 3.3
AoAs = -18:0.1:18;
x_AoA = zeros(length(AoAs), 1);
sep_points_thwaites = zeros(length(AoAs), 1);
sep_points_stratford = zeros(length(AoAs), 1);
figure(4);
hold on
axis equal
grid on
x_sep = [];
y_sep = [];
for i = 1:length(AoAs)
    AoA = AoAs(i);
    [A_normal, B_normal, A_tangential, B_tangential, d] = method_vortexPanelMethod(x, X, y, Y, theta, U, AoA*(pi/180), Si);
    [gammas, Ut, Cp] = method_solveKuttaCondition(A_normal, B_normal, A_tangential, B_tangential, d);
    [stag_point_index, stag_edges] = method_stagnationPoint(Ut, X, Y);
    [x_sep_point, y_sep_point] = method_separationPointThwaites(Si, stag_point_index, Ut, X, Y);
    sep_points_thwaites(i) = x_sep_point(1) / c;
    x_AoA(i) = AoA;
    %[x_sep_point, y_sep_point, x_bar_all] = method_separationPointStratford(np, stag_point_index, Ut, X, Y, x);
    %sep_points_stratford(i) = x_bar_all / c;
    x_sep = [x_sep x_sep_point(1)];
    y_sep = [y_sep y_sep_point(1)];
    plot(x_sep_point(1), y_sep_point(1), '.', 'color', '[0 '+ string((AoA + 18)/40) +' 0]', 'MarkerSize',10)
end
leg = {'thwaites', 'stall threshold line'};
plot_XY(3, {x_AoA}, {sep_points_thwaites}, 'alpha [deg]', 'seperation points [x/c]', leg, lw, fs, '-o', {colors{1}});
yline(0.2, 'color', 'r')
legend(leg)
%plot_XY(3, {x_AoA}, {sep_points_stratford}, 'alpha', 'x/c', leg, lw*3, fs, '-', {colors{2}});
figure(4)
size_sep = grouptransform(x_sep,y_sep,@numel);
for i = 1:length(X)-1
    plot([X(1, i), X(1, i+1)], [Y(1, i), Y(1, i+1)], '-', 'color', 'k');
end
xlabel('X [unit L]','Fontsize', fs)
ylabel('Y [Unit L]','Fontsize', fs)
legend('Stagnation Point', 'Fontsize', fs)






