function imgGrayEven = eliminateLight(image)
% eliminateLight eliminate the influence of uneven light
%   input: image, RGB image, double.
%   output: imgGrayEven, gray image with even light
  imagHSV = rgb2hsv(image);
  H = fspecial('gaussian', [100 100], 10);
  v_gaussian = imfilter(imagHSV(:,:,3), H, 'replicate');
  sz = size(imagHSV(:,:,3));
  v_m = mean(mean(imagHSV(:,:,3)));
  v_mean = ones(sz(1),sz(2)).*v_m;
  imagHSV(:,:,3) = imagHSV(:,:,3) - v_gaussian + v_mean;
  imgGrayEven = hsv2rgb(imagHSV);
  imgGrayEven = rgb2gray(imgGrayEven);
end