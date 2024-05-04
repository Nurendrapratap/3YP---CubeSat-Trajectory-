
clear all


X =[6378100+400000; 0; 0];
V =[0; 7660; 0];

h = 10;
steps = 150000000;
m= 4.2;
Area = 0.02546;

[trajvel,traj, A, P,t] = orbit(X,V,h,steps,m,Area);