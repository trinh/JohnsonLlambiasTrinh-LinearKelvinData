function clean = cleancont(C,L);

for i = size(C,2):-1:1
    if C(2,i)>L
        C(:,i) = [];
    end 
end
clean = C;
end

