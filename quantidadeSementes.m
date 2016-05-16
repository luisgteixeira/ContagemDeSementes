function [ qntdSementes ] = quantidadeSementes( imagem, cor_semente )
%	Calcula a quantida de sementes na imagem

    [~,qntdSementes] = bwlabel(imagem(:,:,cor_semente),8);
%     fprintf('Contem %d sementes!\n', qntdSementes);

end

