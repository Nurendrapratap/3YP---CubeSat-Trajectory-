function [trajvel, traj, A, P,time] = orbit(X,V,h,steps,m,Area)
% output the traj, distance A from the centre of the Earth and orbital
% period P
% X, V and h are the current position, velocity and step size,
% rho is the density of the air,
%Cd is the drag coefficient,
% m is the mass of the CubeSat,
% Area is projected area of CubeSat


%% loading US_1976
Zm = cell2mat(struct2cell(load('US1976_matlabdata','Zm')));
rhokgm3 = cell2mat(struct2cell(load('US1976_matlabdata','rhokgm3')));
TK = cell2mat(struct2cell(load('US1976_matlabdata','TK')));



%A = zeros(steps,1);

X_initial = X;
t1 = 0; % t1 is used to find orbital period. It saves the previous time at 
% which the orbital period was saved
n = 1; % keeping count of number of time period saved
P=0;

% defining the radius of the earth so that simulation can be stopped if the
% Earth surface is reached
r = 6378100;

% j keeps track of the number of steps required for the cubesat to reach
% Earth's surface
j=0;

for t = 1:steps
   
    j = j+1;
    Xp(t) = X(1);
    Yp(t) = X(2);
    Zp(t) = X(3);
    Xv(t) = V(1);
    Yv(t) = V(2);
    Zv(t) = V(3);
    [X,V] = solver(h,X,V);

    %% plotting orbit
     %plot3(Xp,Yp,Zp);
    % pause(0.0000000005)

    %% calculating distance from centre of Earth
    A(t) = sqrt(X(1)^2 + X(2)^2 + X(3)^2);
    disp(t);
    disp(A(t))

    %% check if planet surface is reached
    if norm(X)<=r
    %      % stop the for loop simulation if the CubeSat is on the surface of the
    %      % planet
            fprintf("CubeSat is on the surface of the Earth.");
            break;
    end

    
    %% Calculating Cd values
    Cd = coeff(X,V,r,Zm,TK,rhokgm3);


    %% Calculating the change in velocity due to friction
    [~,rho] = atmos(X,r,Zm,TK,rhokgm3);
    V = frictvel(V,h,rho,Cd,m,Area);

  
    %% Finding orbital period
    % Finding radial direction of orbiting object
    B = [X(1); X(2); X(3)];
    B = B/norm(B);
    
    % finding initial radial direction of orbiting object
    X_initial = X_initial/norm(X_initial);

    % Comparing the directions and saving it if they match
    
    
    if norm(B - X_initial) < (norm(V)/norm(X))*(h)/2

        P(n) = (t-t1)*h;
        n = n+1;
        
        t1 = t; % t1 allows to find difference between previous time 
        % the current time when period is calculated       
    end


end

% t is defined so as plots are possible
t = 1:j;

% time is the time required to reach the surface of the planet.
time = j*h;

% the trajectory of the satellite
traj = [Xp;Yp;Zp];
trajvel = [Xv;Yv;Zv];

% Plotting variation of height from the centre of the planet to the cubesat
% with steps
plot(t,A);


