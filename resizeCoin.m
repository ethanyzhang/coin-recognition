function imgResizedCoin = resizeCoin(imgMaskedCoin)
%PreFeature resize all the coin only images to 125*125
%   input: images after light_elimination
%   output: 125*125 gray image
    im = imgMaskedCoin;
    % noise reduction
    im = medfilt2(im,[5 5]);
    im = imresize(im,[125 125]);
    im = medfilt2(im,[2 2]);
    % histogram equalization
    im = histeq(im);
    % sharpen the image
    background = imopen(im,strel('disk',10));
    im = im - background;
    imgResizedCoin = imadjust(im);
end

