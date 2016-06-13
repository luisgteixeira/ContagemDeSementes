clear
clc

original = imread('Imagens4/teste_2_original.png');
binarizada = imread('Imagens4/teste_2_binaria.png');

img_final = zeros(size(original));

[img_label, n] = bwlabel(binarizada);
    
vetor_atributos = dlmread('Base2/vetor_de_atributos.txt');

classes = vetor_atributos(:,end);
vetor_atributos(:,end) = []; % Retira coluna com as classes

amendoim = 0;
azeitona = 0;
milho = 0;
alho = 0;
ata = 0;
casca_amendoim = 0;

for i = 1 : n

    vetor = zeros(1,size(vetor_atributos,2));

    img_aux = zeros(size(img_label));
    img_aux(find(img_label == i)) = 255;

    [binaria_cortada, original_cortada] = selecionaROI (img_aux, original);
    
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

    vetor(1) = sum_R/ind_R;


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

    vetor(2) = sum_G/ind_G;

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

    vetor(3) = sum_B/ind_B;
    
    distancias = zeros(2,size(vetor_atributos,1)); % 1 - Distância | 2 - Classe
    
    for j = 1 : size(vetor_atributos,1)
        distancias(1,j) = norm(vetor - vetor_atributos(j,:));
        distancias(2,j) = classes(j);
    end
    
    % 5% do tamanho do vetor de atributos
    limiar = (5 * size(vetor_atributos,1)) / 100;
    limiar = round(limiar);
    
    % Indices das menores distancias
    [~,ind] = sort(distancias(1,:));
    ind = ind(1:limiar);
    
    % 5% menores distancias
    % Classe dominante
    classe = mode(distancias(2,ind));
    
    switch classe
        case 1
            img_aux = img_final(:,:,1);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,1) = img_aux;
            
            amendoim = amendoim + 1;
            
        case 2
            img_aux = img_final(:,:,2);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,2) = img_aux;
            
            azeitona = azeitona + 1;
            
        case 3
            img_aux = img_final(:,:,3);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,3) = img_aux;
            
            milho = milho + 1;
            
        case 4
            img_aux = img_final(:,:,1);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,1) = img_aux;
            
            img_aux = img_final(:,:,2);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,2) = img_aux;
            
            alho = alho + 1;
            
        case 5
            img_aux = img_final(:,:,1);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,1) = img_aux;
            
            img_aux = img_final(:,:,3);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,3) = img_aux;
            
            ata = ata + 1;
            
        case 6
            
            img_aux = img_final(:,:,2);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,2) = img_aux;
            
            img_aux = img_final(:,:,3);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,3) = img_aux;
            
            casca_amendoim = casca_amendoim + 1;
    end

end

imshow(img_final);

disp(strcat('Amendoim=', num2str(amendoim)));
disp(strcat('Azeitona=', num2str(azeitona)));
disp(strcat('Milho=', num2str(milho)));
disp(strcat('Alho=', num2str(alho)));
disp(strcat('Ata=', num2str(ata)));
disp(strcat('Casca de amendoim=', num2str(casca_amendoim)));