function maskedImage = maskBackground(image)
% maskBackground: mask the background out.
%   input: image, RGB image matrix, double.
%   output: maskedImage, image with only coins, the background is black.
  maskedImage = image;
  image = rgb2hsv(image);
  % GMM parameters 
  load GMMModel
  model10phsv = model{1};
  modelhsv5 = model{2};
  % caculated probability density function value for each pixel in the image
  % penny
  zp = calculatePDF(image, model10phsv);
  % all other sliver coins
  z = calculatePDF(image, modelhsv5);
  % generate mask
  mask = z|zp;
  se = strel('disk', 32);
  mask = imclose(mask, se);
  mask = imfill(mask, 'holes');
  % mask= medfilt2(mask, [20 20]);
  maskedImage(:,:,1) = maskedImage(:,:,1).*mask;
  maskedImage(:,:,2) = maskedImage(:,:,2).*mask;
  maskedImage(:,:,3) = maskedImage(:,:,3).*mask;
end