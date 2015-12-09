function coinImages = getCoinImages(imgGrayEven, radiuses, centers)
% getCoinImages get every coin's region out, do prefeature processing
% input: imgGrayEven, gray image after light influence elimination
%        radiuses, detected circles' radius, output of hough_circle detection
%        centers, detected circles' center coordinates   
  l = length(radiuses);
  coinImages = cell(1,l);
  for i=1:l
    % get the region with only a coin, save it in a new matrix
    left = (centers(i,1)-radiuses(i)+1);
    right = (centers(i,1)+radiuses(i)-1);
    up = (centers(i,2)+radiuses(i)-1);
    down = (centers(i,2)-radiuses(i)+1);
    imgCoin = imgGrayEven(down:up,left:right);
    % set all the pixel values out of the coin's circle zero
    imgCoin = im2uint8(imgCoin);
    sz = size(imgCoin);
    [W,H] = meshgrid(1:sz(2), 1:sz(1));
    mask = sqrt((W-radiuses(i)).^2 + (H-radiuses(i)).^2) < radiuses(i);
    imgMaskedCoin = double(imgCoin).^mask;
    imgMaskedCoin = uint8(imgMaskedCoin);
    % prefeature processing
    imgResizedCoin = resizeCoin(imgMaskedCoin);
    coinImages{i} = imgResizedCoin;
  end
end