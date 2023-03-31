function nombre = countZerro(matrice8x8)
    nombre = 0
    for i = 1:8
        for j = 1:8
            if matrice8x8(i,j) == 0
                then
                nombre = nombre + 1
            end
        end                
    end
endfunction
