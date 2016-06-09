clear
clc

original = imread('Imagens3/exemplo_original.png');
original = rgb2hsv(original);
binarizada = imread('Imagens3/exemplo.png');

% original = imread('Base/amendoim_original.png');
% binarizada = imread('Base/amendoim.png');

img_final = zeros(size(original));

[img_label, n] = bwlabel(binarizada);
    
% vetor_atributos = dlmread('Base/vetor_de_atributos.txt');
vetor_atributos = dlmread('Base/vetor_de_atributos-hsv.txt');

classes = vetor_atributos(:,end);
vetor_atributos(:,end) = []; % Retira coluna com as classes

for i = 1 : n

    vetor = zeros(1,22);

    img_aux = zeros(size(img_label));
    img_aux(find(img_label == i)) = 255;

    [binaria_cortada, original_cortada] = selecionaROI (img_aux, original);
    
    R = original_cortada(:,:,1);
    G = original_cortada(:,:,2);
    B = original_cortada(:,:,3);

    R(find(binaria_cortada == 0)) = 0;

    glcmR = graycomatrix(R);
    atributosR = graycoprops(glcmR);
    vetor(1) = atributosR.Energy;
    vetor(2) = atributosR.Correlation;
    vetor(3) = atributosR.Contrast;
    vetor(4) = atributosR.Homogeneity;
    vetor(5) = std(std(glcmR));
    vetor(6) = entropy(glcmR);     
    vetor(7) = mean(mean(glcmR));


    G(find(binaria_cortada == 0)) = 0;

    glcmG = graycomatrix(G);
    atributosG = graycoprops(glcmG);
    vetor(8) = atributosG.Energy;
    vetor(9) = atributosG.Correlation;
    vetor(10) = atributosG.Contrast;
    vetor(11) = atributosG.Homogeneity;
    vetor(12) = std(std(glcmG));
    vetor(13) = entropy(glcmG);     
    vetor(14) = mean(mean(glcmG));

    B(find(binaria_cortada == 0)) = 0;

    glcmB = graycomatrix(B);
    atributosB = graycoprops(glcmB);
    vetor(15) = atributosB.Energy;
    vetor(16) = atributosB.Correlation;
    vetor(17) = atributosB.Contrast;
    vetor(18) = atributosB.Homogeneity;
    vetor(19) = std(std(glcmB));
    vetor(20) = entropy(glcmB);     
    vetor(21) = mean(mean(glcmB));

    vetor(22) = length(find( binaria_cortada == 255 ));
    
    distancias = zeros(2,size(vetor_atributos,1)); % 1 - Distância | 2 - Classe
    
    for j = 1 : size(vetor_atributos,1)
        distancias(1,j) = norm(vetor - vetor_atributos(j,:));
        distancias(2,j) = classes(j);
    end
    
    % 20% do tamanho do vetor de atributos
    limiar = (25 * size(vetor_atributos,1)) / 100;
    limiar = round(limiar);
    
    % Indices das menores distancias
    [~,ind] = sort(distancias(1,:));
    ind = ind(1:limiar);
    
    % 20% menores distancias
    % Classe dominante
    classe = round(sum(distancias(2,ind))/limiar);
    
    switch classe
        case 1
            img_aux = img_final(:,:,1);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,1) = img_aux;
            
        case 2
            img_aux = img_final(:,:,2);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,2) = img_aux;
            
        case 3
            img_aux = img_final(:,:,3);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,3) = img_aux;
            
        case 4
            img_aux = img_final(:,:,1);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,1) = img_aux;
            
            img_aux = img_final(:,:,2);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,2) = img_aux;
            
        case 5
            img_aux = img_final(:,:,1);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,1) = img_aux;
            
            img_aux = img_final(:,:,3);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,3) = img_aux;
            
        case 6
            
            img_aux = img_final(:,:,2);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,2) = img_aux;
            
            img_aux = img_final(:,:,3);
            img_aux( find(img_label == i) ) = 255;
            img_final(:,:,3) = img_aux;
    end

end

imshow(img_final)