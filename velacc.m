function [Xdot,Vdot] = velacc(X,V)
% function to calculate the velocity and acceleration based on the current position X and
% velocity V

GM = 398600.4418e9; % Product of Gravitational Constant and Mass of the Earth

Xdot = V; % Xdot is velocity and is equal to V


% Apply Newton's Law of Gravitation

a = norm(X); % distance from Earth Centre to object
Vdot = -((GM)/a^2)*(X/a); % Vdot is a vector of velocity


