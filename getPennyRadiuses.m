function pennyRadiuses = getPennyRadiuses(image)
% pennyRadiuses get the radius of pennies in an image.
%   input: images with only pennys
%   output: radius and centers of pennys

  imgGray = rgb2gray(image);
  imgGrayMed = medfilt2(imgGray, [20 20]);
  imageBlackWhite = im2bw(imgGrayMed, graythresh(imgGrayMed));

  window=60;
  se = strel('disk', window);
  imageBlackWhiteCO = imerode(imageBlackWhite, se);

  [L, num] = bwlabel(imageBlackWhiteCO, 4);
  count = zeros(num,1);
  for i=1:num
    count(i) = sum(L(:) == i);
  end
  r = floor(sqrt(count/pi));
  r_max = max(r) + window;
  if ~isempty(r_max)
    [centers, pennyRadiuses] = imfindcircles(imageBlackWhite, [round(r_max*0.9), round(r_max*1.1)], ...
    'Sensitivity', 0.9, 'EdgeThreshold', 0.02);
  else
    pennyRadiuses=[];
  end
end
