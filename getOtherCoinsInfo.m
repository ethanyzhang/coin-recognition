function [ otherRadiuses, otherCenters ] = getOtherCoinsInfo( image )
% getOtherCoinsInfo return the radiuses and centers of coins in the image

  imgGray = rgb2gray(image);
  imgGrayMed = medfilt2(imgGray, [20 20]);
  imageBlackWhite = im2bw(imgGrayMed,0.30);

  window = 60;
  se = strel('disk', window);
  imageBlackWhiteCO = imerode(imageBlackWhite, se);

  [L, num] = bwlabel(imageBlackWhiteCO, 4);
  count = zeros(num, 1);
  for i=1:num
    count(i) = sum(L(:) == i);
  end
  r = floor(sqrt(count/pi));
  r_max = max(r) + window;
  if ~isempty(r_max)
    [otherCenters, otherRadiuses] = imfindcircles(imgGrayMed, [round(r_max*0.7), round(r_max*1.3)], ...
    'Sensitivity', 0.9, 'EdgeThreshold', 0.02);
  else
    otherRadiuses=[];
    otherCenters=[];
  end 
end

