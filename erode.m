function [ imagem_resultante ] = erode( imagem, tam )
%	Cria um elemento estruturante no formato de disco e erode a imagem

    elem_estruturante = strel('disk', tam);
    imagem_resultante = imerode(imagem, elem_estruturante);

end