function liste_tuples_values = compresse_Zeros(liste)
    liste_tuples = list()
    liste_values = list()
    Zeros = 0;
    for i = 1:64
        if liste(i) ~= 0 then
            value = liste(i);
            nb_bits = round(log(abs(value))/log(2)) + 1;
            liste_tuples($+1) = list(Zeros,nb_bits);
            liste_values($+1) = value;
            Zeros = 0;
        else
            Zeros = Zeros + 1;
        end
    end
    
    /*if Zeros ~= 0 then 
        liste_tuples($+1) = list(list(0,0));       
    end*/
    
    liste_tuples_values = list(liste_tuples,liste_values);
endfunction

function liste = decompresse_Zeros(liste_tuples_values)
    liste = list()
    liste_tuples = liste_tuples_values(1);
    liste_values = liste_tuples_values(2);
    for i = 1:size(liste_tuples)
        Zeros = liste_tuples(i)(1);
        for j = 1:Zeros
            liste($+1) = 0;
        end
        liste($+1) = liste_values(i);
    end
    
    for i = 1:(64-size(liste))
        liste($+1) = 0
    end
endfunction
