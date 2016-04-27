function [ imagem_resultante ] = preProcessamento( imagem )
%   Soma as bandas H e V do sistema de cor HSV

    imagem_resultante = rgb2hsv(imagem);
    imagem_resultante = imadd(imagem_resultante(:,:,1), imagem_resultante(:,:,3));

end

