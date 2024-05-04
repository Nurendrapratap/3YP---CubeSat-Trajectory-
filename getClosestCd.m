function Cd = getClosestCd(inputMa, inputRe)
    % Define the dataset
    data = [5, 100, 1.38; 5, 400, 1.49; 5, 700, 1.5; 5, 1000, 1.51; 5, 1300, 1.51; ...
            10, 100, 1.42; 10, 400, 1.48; 10, 700, 1.44; 10, 1000, 1.48; 10, 1300, 1.46; ...
            15, 100, 1.46; 15, 400, 1.43; 15, 700, 1.34; 15, 1000, 1.33; 15, 1300, 1.33; ...
            20, 100, 1.47; 20, 400, 1.41; 20, 700, 1.38; 20, 1000, 1.32; 20, 1300, 1.32];
    
    Ma_values = data(:, 1);
    

    % Find the index of the closest Ma and Re
    [~, idxMa] = min(abs(Ma_values - inputMa));
    closestMa = Ma_values(idxMa);

    % Filter the rows with the closest Ma
    filteredData = data(Ma_values == closestMa, :);

    % Now find the index of the closest Re in the filtered data
    [~, idxRe] = min(abs(filteredData(:, 2) - inputRe));
    
    % Return the corresponding Cd value
    Cd = filteredData(idxRe, 3);
end
