function quantized = quantize(mat,qTable)
    mat2=mat./qTable
    quantized = round(mat2)
endfunction

function mat = deQuantize(quantized,qTable)
    mat = quantized .* qTable
endfunction
