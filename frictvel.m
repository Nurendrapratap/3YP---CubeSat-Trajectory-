function [Xdot] = frictvel(V,h,rho,Cd,m,A)
% function to calculate V velocity based on position X, velocity V, step
% size h, density of air rho, drag coefficient Cd, mass m of CubeSat, area
% A of CubeSat

% Drag force definition
Fd = zeros(3,1);
Fd(1) = -0.5*Cd*rho*A*V(1)*abs(V(1));
Fd(2) = -0.5*Cd*rho*A*V(2)*abs(V(2));
Fd(3) = -0.5*Cd*rho*A*V(3)*abs(V(3));

% Calculating change in velocity in each direction
dV = Fd*h/m;

% Computing new velocity
Xdot = zeros(3,1);


% Check if dV is greater than V; if it is, then V should be zero. Friction
% cannot increase velocity in the other direction. This is an issue because
% of the size of the steps.
if abs(dV(1)) <= abs(V(1)) 
    Xdot(1) = V(1)+dV(1);
else
    Xdot(1) = 0;
end

if abs(dV(2)) <= abs(V(2)) 
    Xdot(2) = V(2)+dV(2);
else
    Xdot(2) = 0;
end

if abs(dV(3)) <= abs(V(3)) 
    Xdot(3) = V(3)+dV(3);
else
    Xdot(3) = 0;
end



