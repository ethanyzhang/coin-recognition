clear all
close all
clc
files = dir('nickel_head_2*.jpg');
for file = files'
    im = imread(file.name);
    im=medfilt2(im,[5 5]);
    BW=imresize(im,[125 125]);
    BW=medfilt2(BW,[2 2]);
    BW = histeq(BW);
    background = imopen(BW,strel('disk',10));
    BW=BW-background;
    BW=imadjust(BW);
    writeNameEq = strrep(file.name, '.jpg', '_Eq.jpg');
    imwrite(BW,writeNameEq);
end