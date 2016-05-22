clc
clear

for flag = 1 : 3
    
    switch flag
        case 1
            cereal = 'amendoim';
        case 2
            cereal = 'feijao';
        case 3
            cereal = 'milho';
    end
    
    imagem = imread(strcat(cereal, '_original.png'));
    img_binarizada = imread(strcat(cereal, '.png'));

    [labels,n] = bwlabel(img_binarizada,8);

    media = zeros(n, 3);

    for k = 1 : n
        somatorio_1 = [0];
        somatorio_2 = [0];
        somatorio_3 = [0];
        qntd = 0;

        for i = 1 : size(imagem, 1)
            for j = 1 : size(imagem, 2)
                if labels(i,j) == k
                    somatorio_1(end+1) = imagem(i,j,1);
                    somatorio_2(end+1) = imagem(i,j,2);
                    somatorio_3(end+1) = imagem(i,j,3);

    %                 media(k,1) = media(k,1) + imagem(i,j,1);
    %                 media(k,2) = media(k,2) + imagem(i,j,2);
    %                 media(k,3) = media(k,3) + imagem(i,j,3);

                    qntd = qntd + 1;

                end

            end
        end

        media(k,1) = round(sum(somatorio_1) / qntd);
        media(k,2) = round(sum(somatorio_2) / qntd);
        media(k,3) = round(sum(somatorio_3) / qntd);
    end

    arq = fopen(strcat(cereal, '-info.txt'), 'w');
    fprintf(arq, '%d ', min(media(:,1)));
    fprintf(arq, '%d ', min(media(:,2)));
    fprintf(arq, '%d', min(media(:,3)));
    fprintf(arq, '\n');

    fprintf(arq, '%d ', max(media(:,1)));
    fprintf(arq, '%d ', max(media(:,2)));
    fprintf(arq, '%d', max(media(:,3)));

end