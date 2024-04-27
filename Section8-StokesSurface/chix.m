function CHIX = chix(CHI,hh)
CHIX = cell(size(CHI));
for k = 1:length(CHI)
     CHIX{k} = NaN*CHI{k};
    for i = 1:size(CHI{1},1)
        for j = 1:size(CHI{1},2)
            if j == 1
                CHIX{k}(i,j) = (CHI{k}(i,j+1) - CHI{k}(i,j))/(hh);
            elseif j == size(CHI{1},2)
                CHIX{k}(i,j) = (CHI{k}(i,j) - CHI{k}(i,j-1))/(hh);
            else
            CHIX{k}(i,j) = (CHI{k}(i,j+1) - CHI{k}(i,j-1))/(2*hh);
            end
        end
    end
end
end