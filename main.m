clc
clear

% ----------------------- ENTRADAS ----------------------- %
% imagem = imread('milho.jpg');
% imagem = imread('feijao.jpg');
% imagem = imread('ervilha.jpg');

% imagem = imread('Imagens/Teste1.jpg');
% imagem = imread('Imagens/Teste2.jpg');
% imagem = imread('Imagens/Teste3.jpg');
% imagem = imread('Imagens/Teste4.jpg');

% imagem = imread('Imagens/Teste4.1.jpg');
% imagem = imread('Imagens/Teste4.2.jpg');
% imagem = imread('Imagens/Teste4.3.jpg');

% imagem = imread('Imagens2/Teste1.jpg');
imagem = imread('Imagens2/Teste2.jpg');
% imagem = imread('Imagens2/Teste3.jpg');
% imagem = imread('Imagens2/Teste4.jpg');
% imagem = imread('Imagens2/Teste5.jpg');
% imagem = imread('Imagens2/Teste6.jpg');
% imagem = imread('Imagens2/Teste7.jpg');

% imagem = imread('Imagens/Redimensionada1.png');
% imagem = imread('Imagens/IMG_20160412_162833766.jpg');
% -------------------------------------------------------- %

% Soma as bandas H e V do sistema de cor HSV %
img_preProcessada = preProcessamento(imagem);
% imshow(img_preProcessada)
% ------------------------------------------ %


% --- Segmenta a imagem utilizando o Kmeans --- %
img_segmentada = segmentacao(img_preProcessada);
imshow(img_segmentada)
% --------------------------------------------- %


% Cria um elemento estruturante no formato de disco e dilata a imagem %
img_MM = erode(img_segmentada, 10);
img_MM = dilata(img_MM, 6);
% ------------------------------------------------------------------- %


% Cor do fundo eh utilizada para retirar partes pretas e contar sementes %
cor_fundo = input('Fornecer a cor do fundo: ');
% ---------------------------------------------------------------------- %


% - Retira partes pretas da imagem - %
[img_final, cor_semente] = posProcessamento(img_MM, cor_fundo);
figure, imshow(img_final)
% ---------------------------------- %

% ----- Calcula a quantida de sementes na imagem ----- %
quantidadeSementes(img_final, cor_semente);
% ---------------------------------------------------- %