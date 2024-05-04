function [X,V] = solver(h,X,V)
% function to find the new position X based on the current position X and
% Velocity V. h is step size.

% Runge Kutta Solver
[kx1, kv1] = velacc(X,V);
[kx2, kv2] = velacc(X+h*kx1/2, V+h*kv1/2);
[kx3, kv3] = velacc(X+h*kx2/2, V+h*kv2/2);
[kx4, kv4] = velacc(X+h*kx3, V+h*kv3);

% calculating the new position and velocity
X = X + (h/6)*(kx1 + 2*kx2 + 2*kx3 + kx4);
V = V + (h/6)*(kv1 + 2*kv2 + 2*kv3 + kv4);



