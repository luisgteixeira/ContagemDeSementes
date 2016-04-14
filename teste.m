clc
clear

% imagem = imread('milho.jpg');
% imagem = imread('feijao.jpg');
imagem = imread('ervilha.jpg');

% Imagem em escala de cinza
img = rgb2gray(imagem);

% img = medfilt2(img, [9 9]);
% img = histeq(img);
% img = 1 * power(double(img), 0.6);

% Filtro da media
h = fspecial('average', [7 7]);
img = imfilter(img, h);

imshow(img)
BW = edge(img,'canny');
figure, imshow(BW)