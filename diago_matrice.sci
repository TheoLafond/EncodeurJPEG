function deroule = derouler(matrice8x8,liste_indices)
    deroule = list();
    for i = 1:64
        deroule($+1)=matrice8x8((liste_indices(i)(1),liste_indices(i)(2)));
    end
endfunction

function matrice8x8 = enrouler(liste,liste_indices)
    matrice8x8 = zeros(8,8);
    for i = 1:64
        if liste(i) ~= 0 then
            matrice8x8(liste_indices(i)(1),liste_indices(i)(2)) = liste(i);
        end
    end
endfunction
