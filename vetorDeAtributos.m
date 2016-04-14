function vetorDeAtributos = vetorDeAtributos(imagem)
    [row_ori, column_ori, ~] = size(imagem);

    vetorDeAtributos = zeros((row_ori * column_ori), 1);
    
    imgs(:,:,1) = imagem;
    
    for j = 1 : size(imgs, 3);
        image = imgs(:,:,j);
        [row, column] = size(image);
        r_atributos = 1;

        for r = 1 : row
            for c = 1 : column
                vetorDeAtributos(r_atributos, j) = image(r,c);
                r_atributos = r_atributos + 1;
            end
        end
    end
end