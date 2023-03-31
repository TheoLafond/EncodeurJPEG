function taille = count_bits(cppeg)
    nb_bits=32
    nb_zerros = 0
    for k = 1:size(cppeg(2))
        place = 64
        liste_tuples = cppeg(2)(k)(1)
        for j = 1:size(liste_tuples)
            place = place - 1 - liste_tuples(j)(1);
            nb_zerros = nb_zerros + liste_tuples(j)(1);
            nb_bits = nb_bits + 8 + liste_tuples(j)(2);
        end
        nb_bits = nb_bits + 8
        nb_zerros = nb_zerros + place
    end
    taille = [nb_bits,nb_zerros]
endfunction
