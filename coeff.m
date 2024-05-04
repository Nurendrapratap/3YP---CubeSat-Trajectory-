function Cd = coeff(X,V,r,Zm,TK,rhokgm3)
% function takes as input position X, velocity V and radius of Earth r;
% it then outputs the drag coefficient Cd for those particular condition


% calculating speed
speed = norm(V);

%% temperature and density
[T,rho] = atmos(X,r,Zm,TK,rhokgm3);


%% calculating viscosity
% Constants    
mu0 = 1.37e-5; % Reference viscosity in kg/(m*s)     
T0 = 200; % Reference temperature in Kelvin     
S = 111; % Sutherland's constant in Kelvin 

% Sutherland's equation:     
mu = mu0 * ((T0 + S) / (T + S)) * (T / T0)^(3/2);


%% Calculating Reynold's Number
L = 0.168; % characteristics length
Re = rho * speed * L/mu;


%% Calculating Mach Number
gamma = 1.4; % specific heat ratio - assumed constant for perfect gas
R = 287.0025;

a = sqrt(gamma*R*T); % speed of sound
Mach = speed/a;


%% Calculating Cd values using getClosestCd

Cd = getClosestCd(Mach,Re);




