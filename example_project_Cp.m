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
colors = {'[0 0.4470 0.7410]', '[0.9290 0.6940 0.1250]', '[0 0.5 0]', '[0.6350 0.0780 0.1840]'};
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

plot_airfoil(1, X, Y, x, y, lw, fs, axis_dim);

%% Project 3.1
AoAs = [16];

leg = {'alpha = 16'};
for i = 1:length(AoAs)
   AoA = AoAs(i);
   [A_normal, B_normal, A_tangential, B_tangential, d] = method_vortexPanelMethod(x, X, y, Y, theta, U, AoA*(pi/180), Si);
   [gammas, Ut, Cp] = method_solveKuttaCondition(A_normal, B_normal, A_tangential, B_tangential, d);
   Cp_reorder = [Cp(np+1:end) ; Cp(1:np)];
   x_reorder = [x(np+1:end)  x(1:np)];
   x_Cp_stack = [x_reorder; transpose(Cp_reorder)];
   [deltaCp, x_cord, Cp_upper, Cp_lower] = method_deltaCp(x_reorder, Cp_reorder, np, AoA);
   plot_XY(4, {x_reorder}, {Cp_reorder}, 'x/c', 'Cp', leg, lw, fs, '-', {colors{i}});
end
axis ij

% for i = 1:length(AoAs)
%     AoA = AoAs(i);
%     [A_normal, B_normal, A_tangential, B_tangential, d] = method_vortexPanelMethod(x, X, y, Y, theta, U, AoA*(pi/180), Si);    [gammas, Ut, Cp] = method_solveKuttaCondition(A_normal, B_normal, A_tangential, B_tangential, d);
%     [deltaCp, lower_Cp, upper_Cp, lower_x_c, upper_x_c] = method_deltaCp(x, c, Cp, np);
%     plot_XY(3, {lower_x_c}, {lower_Cp}, 'x/c', 'delta Cp', leg, lw*3, fs, '-', {colors{i}});
% end
% for i = 1:length(AoAs)
%     AoA = AoAs(i);
%     [A_normal, B_normal, A_tangential, B_tangential, d] = method_vortexPanelMethod(x, X, y, Y, theta, U, AoA*(pi/180), Si);
%     [gammas, Ut, Cp] = method_solveKuttaCondition(A_normal, B_normal, A_tangential, B_tangential, d);
%     [deltaCp, lower_Cp, upper_Cp, lower_x_c, upper_x_c] = method_deltaCp(x, c, Cp, np);
%     plot_XY(3, {upper_x_c}, {upper_Cp}, 'x/c', 'delta Cp', leg, lw/30, fs/30, '-', {colors{i}});
% end















