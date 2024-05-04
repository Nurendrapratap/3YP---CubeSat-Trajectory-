function [temp,rho] = atmos(X,r,Zm,TK,rhokgm3)

% function takes as input current position X (wrt to planet's centre) and radius r of the planet; it
% outputs the temp and rho at that given height


% calculating height
height = norm(X) - r;

%loading up data from US1976
%load('US1976_matlabdata.mat');

k = length(Zm);
i = 0; % i is used to keep track where the height matches Zm and then values
% are outputted at that height


% run for loop until height matches
for n = 1:k
    i = i + 1;


    % if height matches, assign value to temperature and density; return
    if height == Zm(n)
        temp = TK(i);
        rho = rhokgm3(i);
        return;

    elseif height < Zm(n)  % linear extrapolation carried out between the values 
                        % for i and (i-1)
        break;

    end
end


% Linear Interpolation to find density and temperature at given altitude
Prho = polyfit([Zm(i-1) Zm(i)],[rhokgm3(i-1) rhokgm3(i)],1);
rho = polyval(Prho,height);

Ptemp = polyfit([Zm(i-1) Zm(i)],[TK(i-1) TK(i)],1);
temp = polyval(Ptemp,height);

