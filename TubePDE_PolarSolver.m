% TubePDE_PolarSolver.m
% This script solves the nutrient PDE in a tube geometry

% Parameters
L = 10; % Length of the tube
R = 1;  % Radius of the semicircular part
D = 0.1; % Diffusion coefficient
T = 5; % Total time
Nx = 100; % Number of spatial points in x
Nr = 50;  % Number of spatial points in r
Nt = 1000; % Number of time steps

% Spatial discretization for rectangular part
x = linspace(0, L, Nx);
dx = x(2) - x(1);

% Spatial discretization for semicircular part
r = linspace(0, R, Nr);
dr = r(2) - r(1);

% Initialize concentration matrix
C = zeros(Nr, Nx, Nt);

% Initial condition (example: C = 0 at t=0)
C(:,:,1) = 0;

% Time-stepping loop
for n = 1:Nt-1
    for i = 2:Nx-1
        for j = 2:Nr-1
            % Apply finite difference scheme
            C(j,i,n+1) = C(j,i,n) + D * dt * ...
                ((C(j,i+1,n) - 2*C(j,i,n) + C(j,i-1,n)) / dx^2 + ...
                 (C(j+1,i,n) - 2*C(j,i,n) + C(j-1,i,n)) / dr^2);
        end
    end
end

% Visualization
mesh(x, r, C(:,:,end));
xlabel('Length of Tube (x)');
ylabel('Radius (r)');
zlabel('Concentration (C)');
title('Nutrient Concentration in Tube Geometry');
