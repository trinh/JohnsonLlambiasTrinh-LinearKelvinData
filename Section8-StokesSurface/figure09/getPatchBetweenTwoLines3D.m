function [V, F] = getPatchBetweenTwoLines3D(W1, W2, n)
    % Generate patch data between two lines in 3D
    
    if size(W1, 1) ~= n || size(W2, 1) ~= n
        keyboard
    end
    
    % Vertices are just 
    V = [W1; W2];
    
    % There are n - 1 faces with 4 vertices each
    F = zeros(n-1, 4);
    for j = 1:n-1
        F(j,1:4) = [j, j+1, n+j+1, n+j];
    end