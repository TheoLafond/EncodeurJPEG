exec("decoupage8x8.sci");
exec("DCT2_algo_mult.sci");
//exec(""); // DCT à l'envers
exec("quantization.sci");
exec("count.sci"); // Compteur de zéros
exec("diago_matrice.sci"); // encodage début
exec("tuples.sci"); // encodage fin

function OutPut = BWConverter(bmp, quantiTable)
    // Variables utiles :
    global matrice_C
    matrice_C=transformee_cosinus(8)
    liste_indices = list(list(1,1),list(1,2),list(2,1),list(3,1),list(2,2),list(1,3),list(1,4),list(2,3),list(3,2),list(4,1),list(5,1),list(4,2),list(3,3),list(2,4),list(1,5),list(1,6),list(2,5),list(3,4),list(4,3),list(5,2),list(6,1),list(7,1),list(6,2),list(5,3),list(4,4),list(3,5),list(2,6),list(1,7),list(1,8),list(2,7),list(3,6),list(4,5),list(5,4),list(6,3),list(7,2),list(8,1),list(8,2),list(7,3),list(6,4),list(5,5),list(4,6),list(3,7),list(2,8),list(3,8),list(4,7),list(5,6),list(6,5),list(7,4),list(8,3),list(8,4),list(7,5),list(6,6),list(5,7),list(4,8),list(5,8),list(6,7),list(7,6),list(8,5),list(8,6),list(7,7),list(6,8),list(7,8),list(8,7),list(8,8));
    
      // BMP --> JPEG --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    
    //b = rgb2grey(bmp);
    b = bmp; // Si déjà en nuance de gris
    
    // Découpage
    c = cut8x8(b);
    dimensions = c(1)
    in = c(2)
    
    // Boucle principale
    compressedOut = list()
    for i = 1:dimensions(1)*dimensions(2)
        square = in(i)
        
        // DCT2 // On ne normalise 
        squareDCT = DCT2(square);
        
        // Quantisation
        squareFinal = quantize(squareDCT, quantiTable);
        
        // Compression
        squareCompressed = compresse_Zeros(derouler(squareFinal, liste_indices))
        
        compressedOut($+1) = squareCompressed
    end
    
    // Sortie finale
    cppegVersion = list(dimensions, compressedOut)
    
    // !!!
    /*
    unix("del LenaIsCompressed.cppeg");
    write("LenaIsCompressed.cppeg", cppegOut)
    */
    
      // JPEG --> BMP --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    
    // cppegVersion = JPEG
    dimensions2 = cppegVersion(1)
    content = cppegVersion(2)
    
    // Décodage (Huffman)
    //y = list(dimensions2, decodeHuffman(content)) // !!!
    //y = derouler(content, liste_indices) // !!!
    cells = content
    
    // Boucle principale
    allCells = list()
    //disp("Début boucle")
    for i = 1:dimensions2(2)
        ligneCell = list()
        for j = 1:dimensions2(1)
            compressedCell = cells(dimensions2(1)*(i-1)+j)
            
            // Décompression
            cellule = enrouler(decompresse_Zeros(compressedCell), liste_indices)
            
            // DéQuantisation
            unquantizedCell = deQuantize(cellule, quantiTable)
            
            // AntiDCT
            unDCTcell = DCT3(unquantizedCell)
            
            // AntiNormalisation
            //cellFinal = antiNormal(unDCTcell) // On ne normalise pas
            
            allCells($+1) = unDCTcell
            //ligneCell($+1) = unDCTcell
        end
        //allCells($+1) = ligneCell
        //allCells($+1) = cellFinal // Si on normalise
    end
    //disp(size(allCells))
    // Jointure des tuiles
    joinedCells = join8x8(list(dimensions2, allCells))
    
    // Conversion vers couleurs
    bmcpp = joinedCells // Si on la veut en nuance de gris
    
    //disp(bmcpp)
    //imwrite(bmcpp, "LenaIsBackBiblio.bmcpp") // je sais pas si ça marche
    //write("LenaIsBack.bmcpp", bmcpp)
    
    OutPut = list(cppegVersion, bmcpp)
    
endfunction
