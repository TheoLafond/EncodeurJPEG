function retour = cut8x8(img)
    dimensions = (size(img))
    liste = list()
    y = dimensions(1) - modulo(dimensions(1),8)
    x = dimensions(2) - modulo(dimensions(2),8)
    for row = 1:8:y
        for col = 1:8:x
            liste($+1) = img(row:row+7,col:col+7)
        end
    end
    retour = list([y/8,x/8], liste)
endfunction


function img = join8x8(jpeg)
    dimensions = jpeg(1)
    img = []
    //disp(size(jpeg(2)))
    for row = 1:dimensions(1)
        tmp = []
        for col = 1:dimensions(2)
//            disp(dimensions(2)*(row-1)+col)
            tmp = [tmp, jpeg(2)(dimensions(2)*(row-1)+col)/*(row:row+1, col:col+1)*/]
            // extension de tmp de 1 colonne
        end
        img = [img; tmp]
        // extension de img de 1 ligne
    end
endfunction
