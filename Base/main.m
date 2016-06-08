clear
clc

arq = fopen('vetor_de_atributos-hsv.txt', 'a');

for flag = 1 : 3
    
    switch flag
        case 1
            cereal = 'amendoim';
        case 2
            cereal = 'feijao';
        case 3
            cereal = 'milho';
    end
    
    img_original = imread(strcat(cereal, '_original.png'));
    img_original = rgb2hsv(img_original);
    img_binarizada = imread(strcat(cereal, '.png'));
    
    [L, n] = bwlabel(img_binarizada);
    
    
    for i=1: n 
        
        img_aux = zeros(size(L));
        img_aux(find(L == i)) = 255;
        
        [A, B] = selecionaROI (img_aux, img_original);
        %imshow(A);
        R = B(:,:,1);
        G = B(:,:,2);
        B = B(:,:,3);
        
        R(find(A == 0)) = 0;
        
        glcmR = graycomatrix(R);
        atributosR = graycoprops(glcmR);
        smaR = atributosR.Energy;
        corrR = atributosR.Correlation;
        contR = atributosR.Contrast;
        homoR = atributosR.Homogeneity;
        dvR = std(std(glcmR));
        entR = entropy(glcmR);     
        mR = mean(mean(glcmR));
        
        
        G(find(A == 0)) = 0;
       
        glcmG = graycomatrix(G);
        atributosG = graycoprops(glcmG);
        smaG = atributosG.Energy;
        corrG = atributosG.Correlation;
        contG = atributosG.Contrast;
        homoG = atributosG.Homogeneity;
        dvG = std(std(glcmG));
        entG = entropy(glcmG);     
        mG = mean(mean(glcmG));
        
        B(find(A == 0)) = 0;
        
        glcmB = graycomatrix(B);
        atributosB = graycoprops(glcmB);
        smaB = atributosB.Energy;
        corrB = atributosB.Correlation;
        contB = atributosB.Contrast;
        homoB = atributosB.Homogeneity;
        dvB = std(std(glcmB));
        entB = entropy(glcmB);     
        mB = mean(mean(glcmB));
        
        tam = length(find( A == 255 ));
        
          
                
                %Atributos Banda R
                fprintf(arq, '%f, ', smaR);
                fprintf(arq, '%f, ', corrR);
                fprintf(arq, '%f, ', contR);
                fprintf(arq, '%f, ', homoR);
                fprintf(arq, '%f, ', dvR);
                fprintf(arq, '%f, ', entR);
                fprintf(arq, '%f, ', mR);
                
                %Atributos Banda G
                fprintf(arq, '%f, ', smaG);
                fprintf(arq, '%f, ', corrG);
                fprintf(arq, '%f, ', contG);
                fprintf(arq, '%f, ', homoG);
                fprintf(arq, '%f, ', dvG);
                fprintf(arq, '%f, ', entG);
                fprintf(arq, '%f, ', mG);
                
                 %Atributos Banda B
                fprintf(arq, '%f, ', smaB);
                fprintf(arq, '%f, ', corrB);
                fprintf(arq, '%f, ', contB);
                fprintf(arq, '%f, ', homoB);
                fprintf(arq, '%f, ', dvB);
                fprintf(arq, '%f, ', entB);
                fprintf(arq, '%f, ', mB);
               
       
                fprintf(arq, '%d, '  , tam);
                fprintf(arq, '%d'  , flag);
                fprintf(arq, '\n');

    end
        %imshow(img_original), figure, imshow(img_aux);
        %[A, B] = selecionaROI (img_aux, img_original);
         imshow(B)%, figure, imshow(A);
    
end


fclose(arq);