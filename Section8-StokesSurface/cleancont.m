% CLEANCONT cleans up a contour given by a 2 x N matrix of x and y values;
% it removes all entries for which the y value exceeds L 
function clean = cleancont(C,L)
    for i = size(C,2):-1:1
        if C(2,i)>L
            C(:,i) = [];
        end
    end
    clean = C;
end

