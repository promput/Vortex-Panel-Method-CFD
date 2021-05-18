%% House Keeping
% clear commands
clc;
clear all;
close all;

% graphing tools
fs = 15;
lw = 1;
axis_dim = [-(2), (2), -(2), (2)];
graphing_params = [axis_dim, fs, lw];

%% Problem Statement
% input needed
np = 128;
r = 1;
U = 1;
alpha = 330;

%% Make Airfoil
[X, Y] = airfoil_cylindrical(np, r, 0);
[x, y, Si] = tool_findPanelCenter(X,Y);
theta = tool_findPanelTheta(X,Y);
Theta = 2*pi:-1/np*2*pi:1/np*2*pi;

plot_airfoil(1, X, Y, x, y, lw, fs, axis_dim);

%% Project 2
[A_normal, B_normal, A_tangential, B_tangential, d] = method_vortexPanelMethod(x, X, y, Y, theta, U, alpha*pi/180, Si);
[gammas, Ut, Cp] = method_solveKuttaCondition(A_normal, B_normal, A_tangential, B_tangential, d);
[stag_point_index, stag_edges] = method_stagnationPoint(Ut, X, Y);
[x_sep_point, y_sep_point] = method_separationPointThwaites(Si, stag_point_index, Ut, X, Y);
disp(size(Cp))
plot_XY(2, {Theta, Theta}, {Cp, method_findCpAnalytical(Theta + 0.45, U, alpha, r)}, 'Cp', 'theta', {'numerical', 'analytical'}, lw, fs, '-o', {'b', 'r'});plot_sepStagPoint(3, X, Y, stag_edges, x_sep_point, y_sep_point, lw, fs, axis_dim)
