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
imagem = imread('Imagens/Teste4.3.jpg');

% imagem = imread('Imagens2/Teste1.jpg');
% imagem = imread('Imagens2/Teste2.jpg');
% imagem = imread('Imagens2/Teste3.jpg');
% imagem = imread('Imagens2/Teste4.jpg');
% imagem = imread('Imagens2/Teste5.jpg');

% imagem = imread('Imagens/Redimensionada1.png');
% imagem = imread('Imagens/IMG_20160412_162833766.jpg');
% -------------------------------------------------------- %

% Pega banda S do sistema de cor HSV %
img = rgb2hsv(imagem);
img = img(:,:,2);
% ---------------------------------- %

% Coloca a matriz inteira em uma única coluna e agrupa com Kmeans % 
img = vetorDeAtributos(img);
classes = kmeans(img, 2);
% --------------------------------------------------------------- %

% Monta a imagem apos o agrupamento %
img = zeros(size(imagem));
img = montaImagem(img, classes, size(imagem,2));
imshow(imagem)
figure, imshow(img)
% --------------------------------- %

% Cria um elemento estruturante no formato de disco e dilata a imagem %
se = strel('disk', 15);
img = imdilate(img, se);
figure, imshow(img)
% ------------------------------------------------------------------- %

% % Calcula a quantida de sementes na imagem %
% [~,n] = bwlabel(img(:,:,x),8);
% % ---------------------------------------- %