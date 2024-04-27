[M,I] = max(imag(wmat(:)));

ctol = 1e-1;

[I_row, I_col] = ind2sub(size(wmat),I);

for i = I_row:size(wmat,1)
    if imag(wmat(i, I_col))<imag(wmat(i+1, I_col))
        if abs(imag(wmat(i, I_col-1))-imag(wmat(i, I_col+1)))>ctol
        sing1 = i;
        break
    end
    end
end

tsing=tmesh(sing1,I_col)