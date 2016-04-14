function imagem = montaImagem(imagem, vetorDeClasses, colunaOriginal)

        linhaVetor = size(vetorDeClasses, 1);

        row_agrup = 1;
        column_agrup = 1;

        for j = 1 : linhaVetor
            if vetorDeClasses(j,1) == 1
                imagem(row_agrup, column_agrup, 1) = 255;
            elseif vetorDeClasses(j,1) == 2
                imagem(row_agrup, column_agrup, 2) = 255;
            elseif vetorDeClasses(j,1) == 3
                imagem(row_agrup, column_agrup, 3) = 255;
            elseif vetorDeClasses(j,1) == 4
                imagem(row_agrup, column_agrup, 2) = 255;
                imagem(row_agrup, column_agrup, 3) = 255;
            end

            if mod(j,colunaOriginal) ~= 0 % j nao e divisivel por colunaOriginal
                column_agrup = column_agrup + 1;
            else
                column_agrup = 1;
                row_agrup = row_agrup + 1;
            end
        end

end

