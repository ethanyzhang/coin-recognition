function [imgPenny, imgOther] = separatePenny(image)
% separatePenny mask penny out
%   input: image, image matrix, double   
%   output: imgPenny, image with only penny
%           imgOther, image with other coins

  hsv_image = rgb2hsv(image) ;
  % generate mask
  BW_HSV = im2bw(hsv_image, 0.36);
  pennyMask = imfill(BW_HSV, 'holes');
  pennyMask = medfilt2(pennyMask, [10 10]);
  % rgb image with only penny on it
  imgPenny = image;
  imgPenny(:,:,1) = double(imgPenny(:,:,1)).*pennyMask;
  imgPenny(:,:,2) = double(imgPenny(:,:,2)).*pennyMask;
  imgPenny(:,:,3) = double(imgPenny(:,:,3)).*pennyMask;
  % rgb image with only other silver coins on it
  imgOther = image - imgPenny;
end

