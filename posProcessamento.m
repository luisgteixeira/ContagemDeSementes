function [ imagem, cor_semente ] = posProcessamento( imagem, cor_fundo )
%	Retira partes pretas da imagem

    img_aux = imagem(:,:,cor_fundo);    % Banda de cor que contem o fundo
    img_aux(img_aux == 0) = 255;    % Partes pretas sao preenchidas

    % Seleciona banda de cor que contem as sementes
    if cor_fundo == 1
        cor_semente = 2;
    else
        cor_semente = 1;
    end

    % Imagem do fundo e subtraida a imagem das sementes, para as sementes
    % nao ficarem da cor amarela
    imagem(:,:,cor_fundo) = imsubtract(img_aux, imagem(:,:,cor_semente));

end

