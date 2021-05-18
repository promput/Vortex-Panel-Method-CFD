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

%% Project 3.2
% reminder we have z, theta_z, and dzdx
dzdx_integral_A0 = cumtrapz(x_hor, dzdx);
dzdx_integral_A0 = dzdx_integral_A0(end);
z_derivative_integral_A0 = cumtrapz(x_hor(1:end-1), math_derivative(x_hor, z));
z_derivative_integral_A0 = z_derivative_integral_A0(end);

dzdx_integral_A1 = cumtrapz(x_hor, dzdx .* cos(theta_z));
dzdx_integral_A1 = dzdx_integral_A1(end);
z_derivative_integral_A1 = cumtrapz(x_hor(1:end-1), math_derivative(x_hor, z) .* cos(theta_z(1:end-1)));
z_derivative_integral_A1 = z_derivative_integral_A1(end);

alphas = -18:0.1:18;
Cls = zeros(size(alphas));
Cds = zeros(size(alphas));
for i = 1:length(alphas)
    AoA = alphas(i)*pi/180;
    [A_normal, B_normal, A_tangential, B_tangential, d] = method_vortexPanelMethod(x, X, y, Y, theta, U, AoA, Si);
    [gammas, Ut, Cp] = method_solveKuttaCondition(A_normal, B_normal, A_tangential, B_tangential, d);
    
    %P = (Cp)*(0.5*rho*Uinf^2)+Pinf;
    %dP = (Cp)*(0.5*rho*Uinf^2);
    P = (Cp);
    dP = (Cp);
    nX = cos(theta+pi/2);
    nY = sin(theta+pi/2);
    fX = -transpose(P).*nX.*Si;
    fY = -transpose(P).*nY.*Si;
    FX = sum(fX);
    FY = sum(fY);
    ROT = [cos(AoA), sin(AoA); -sin(AoA), cos(AoA)];
    Cd_Cl = ROT*[FX; FY];
    Cds(i) = Cd_Cl(1);
    Cls(i) = Cd_Cl(2);
end
if (D1 == 0) && (D2 == 0)
    analytical = 2*pi*(alphas)*pi/180;
else
    analytical = 2*pi*(alphas + 4.15)*pi/180;
end
figure(4)
grid on
hold on
plot(alphas, Cls, '-', 'color', 'b', 'linewidth', lw);
plot(alphas, Cds, '-', 'color', 'r', 'linewidth', lw);
plot(alphas, analytical, '--', 'color', 'k', 'linewidth', lw);
xlabel('alpha [deg]', 'Fontsize', fs) %label the x-axis
ylabel('Coefficient Unit', 'Fontsize', fs) %label the y-axis
legend('numerical Cl', 'numerical Cd','analytical Cl','Fontsize', fs)






