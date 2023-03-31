function matriceFrequentielle=cosinusation(horizontal, vertical)
//fonction qui retourne un vecteur de la base de la TCD
    matHor = zeros(8,8)
    matVert = zeros(8,8)
    for i=1:8
        for j = 1:8
            matHor(i,j) = cos((2*(i-1)+1)*horizontal*%pi/16)
        end
    end
    for i=1:8
        for j = 1:8
            matVert(i,j) = cos((2*(j-1)+1)*vertical*%pi/16)
        end
    end
    matriceFrequentielle = ((matHor*matVert)+8)/16
    imshow(matriceFrequentielle)
endfunction
