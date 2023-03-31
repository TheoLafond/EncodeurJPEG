function matrice_C=transformee_cosinus(taille)
    matrice_C = zeros(taille,taille)
    for i = 1:taille //lignes
        for j= 1:taille //colonnes
            if i == 1 then
                matrice_C(i,j) = 1/sqrt(taille)
            else
                matrice_C(i,j) = sqrt(2/taille)*cos(((2*(j-1)+1)*(i-1)*%pi)/(2*taille))
            end
        end
    end
endfunction

function matrice_dct=DCT2(matrice_decoupe)
    matrice_decoupe = double(matrice_decoupe)
    //matrice_decoupe = matrice_decoupe-128
    matrice_dct = matrice_C*matrice_decoupe*matrice_C'
endfunction

function pixel=DCT3(matrice_requantifie)
    matrice_requantifie = double(matrice_requantifie)
    pixel = matrice_C'*matrice_requantifie*matrice_C
    //pixel = pixel + 128
endfunction
