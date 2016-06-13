clear
clc

arq = fopen('vetor_de_atributos.txt', 'a');

for flag = 1 : 6
    
    switch flag
        case 1
            cereal = 'amendoim';
        case 2
            cereal = 'azeitona';
        case 3
            cereal = 'milho';
        case 4
            cereal = 'alho';
        case 5
            cereal = 'ata';
        case 6
            cereal = 'casca_amendoim';
    end
    
    img_original = imread(strcat(cereal, '_original.png'));
    img_binarizada = imread(strcat(cereal, '.png'));
    
    [img_label, n] = bwlabel(img_binarizada);
    
    
    for i = 1:n 
        
        img_aux = zeros(size(img_label));
        img_aux(find(img_label == i)) = 255;
        
        [binaria_cortada, original_cortada] = selecionaROI (img_aux, img_original);
        
        R = original_cortada(:,:,1);
        G = original_cortada(:,:,2);
        B = original_cortada(:,:,3);
        
        R(find(binaria_cortada == 0)) = 0;
        
        sum_R = 0;
        sum_R = uint32(sum_R);
        ind_R = 0;
        for l = 1 : size(R,1)
            for c = 1 : size(R,2)
            
                if R(l,c) ~= 0
                    sum_R = sum_R + uint32(R(l,c));
                    ind_R = ind_R + 1;
                end
                
            end
            
        end
        
        fprintf(arq, '%f, ', sum_R/ind_R);
        
        
        G(find(binaria_cortada == 0)) = 0;
        
        sum_G = 0;
        sum_G = uint32(sum_G);
        ind_G = 0;
        for l = 1 : size(G,1)
            for c = 1 : size(G,2)
            
                if G(l,c) ~= 0
                    sum_G = sum_G + uint32(G(l,c));
                    ind_G = ind_G + 1;
                end
                
            end
            
        end
        
        fprintf(arq, '%f, ', sum_G/ind_G);
        
        B(find(binaria_cortada == 0)) = 0;
        
        sum_B = 0;
        sum_B = uint32(sum_B);
        ind_B = 0;
        for l = 1 : size(B,1)
            for c = 1 : size(B,2)
            
                if B(l,c) ~= 0
                    sum_B = sum_B + uint32(B(l,c));
                    ind_B = ind_B + 1;
                end
                
            end
            
        end
        
        fprintf(arq, '%f, ', sum_B/ind_B);
        
        fprintf(arq, '%d'  , flag);
        fprintf(arq, '\n');

    end
    
end

fclose(arq);