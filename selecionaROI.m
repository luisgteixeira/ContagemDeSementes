function [ imagem_cortada ] = selecionaROI( imagem )

    [l, c] = size(imagem);
    Cmin = c;
    Cmax = 1;
    Lmin = l;
    Lmax = 1;


    for i = 1 : l
        for j = 1 : c
            
            if imagem(i,j) == 255
                if Cmin > j
                    Cmin = j;
                end

                if Cmax < j
                    Cmax = j;
                end
            end
            
        end
    end


    for j = 1 : c
        for i = 1 : l

            if imagem(i,j) == 255
                if Lmin > i
                    Lmin = i;
                end

                if Lmax < i
                    Lmax = i;
                end
            end
            
        end
    end
    
    
    centro_linha = Lmin + ((Lmax - Lmin) / 2);
    centro_coluna = Cmin + ((Cmax - Cmin) / 2);
    
    excesso_linha = round(l * 0.05);
    excesso_coluna = round(c * 0.05);
    
    tam_linha = Lmax - Lmin + (2 * excesso_linha);
    tam_coluna = Cmax - Cmin + (2 * excesso_coluna);
    
    janela_corte = [centro_coluna-(tam_coluna/2) centro_linha-(tam_linha/2) tam_coluna tam_linha];
    
    imagem_cortada = imcrop(imagem, janela_corte);
    
end