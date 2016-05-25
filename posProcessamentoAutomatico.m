function [ imagem ] = posProcessamentoAutomatico( imagem )
% Elimina elementos da imagem de forma automática, estipulando
% um tamanho mínimo para os elementos

    satisfatorio = false;
    tam_max = 0.001 * ( size(imagem,1) * size(imagem,2) );
    
    loops = 0;

    while ~satisfatorio
        
        [ bw, ~, ~ ] = menorRegiao(imagem);
        
        menor_tam = sum(sum(bw));
        
        if menor_tam <= tam_max
            imagem = erode(imagem, 1);
            loops = loops + 1;
        else
            satisfatorio = true;
        end
        
    end
    
    imagem = dilata(imagem, round(loops/2));

end

