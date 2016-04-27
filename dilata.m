function [ imagem_resultante ] = dilata( imagem, tam )
%	Cria um elemento estruturante no formato de disco e dilata a imagem

    elem_estruturante = strel('disk', tam);
    imagem_resultante = imdilate(imagem, elem_estruturante);

end