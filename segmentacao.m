function [ imagem_resultante ] = segmentacao( imagem )
%	Segmenta a imagem utilizando o Kmeans

    % Coloca a matriz inteira em uma única coluna e agrupa com Kmeans % 
    vetAtributos = vetorDeAtributos(imagem);
    classes = kmeans(vetAtributos, 2);
    % --------------------------------------------------------------- %
    
    % Monta a imagem apos o agrupamento %
    imagem_resultante = zeros(size(imagem));
    imagem_resultante = montaImagem(imagem_resultante, classes, size(imagem,2));
    imagem_resultante(:,:,3) = zeros(size(imagem,1),size(imagem,2));
    % --------------------------------- %

end

