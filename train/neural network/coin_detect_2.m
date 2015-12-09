clear all
close all
clc
files = dir('IMG*.JPG');
prefix='nickel_head_2_';
counter=1;
for file = files'
    disp(file.name);
    Img = imread(file.name);
    Img = imresize(Img, 0.6);
    hsv_image = rgb2hsv(Img) ;
    H=fspecial('gaussian',[100 100],10);
    v_gaussian = imfilter(hsv_image(:,:,3),H,'replicate');
    sz=size(hsv_image(:,:,3));
    v_m=mean(mean(hsv_image(:,:,3)));
    v_mean= ones(sz(1),sz(2)).*v_m;
    hsv_image(:,:,3)=hsv_image(:,:,3)-v_gaussian+v_mean;
    Img_even=hsv2rgb(hsv_image);
    Img_even_gray=rgb2gray(Img_even);
    Img_Gray=rgb2gray(Img);
    Img_Gray_Med = medfilt2(Img_Gray,[50 50]);
    imR = squeeze(Img(:,:,1));
    imG = squeeze(Img(:,:,2));
    imB = squeeze(Img(:,:,3));
    imBinaryR = im2bw(imR,graythresh(imR));
    BWR = imfill(imBinaryR,'holes');
    imBinaryG = im2bw(imG,graythresh(imG));
    BWG = imfill(imBinaryG,'holes');
    imBinaryB = im2bw(imB,graythresh(imB));
    BWB = imfill(imBinaryB,'holes');
    imBinary = imcomplement(BWR&BWG&BWB);
    Img_BW=imcomplement(imBinary);
    Img_BW_Med=medfilt2(Img_BW,[50 50]);
    [L, num] =bwlabel(Img_BW_Med,4);
    count=zeros(num,1);
    for i=1:num
        count(i)=sum(L(:) == i);
    end
    r=floor(sqrt(count/pi));
    r_max=max(r);
    [centers,radii] = imfindcircles(Img_Gray_Med,[round(r_max*0.9),round(r_max*1.1)], ...
        'Sensitivity',0.9,'EdgeThreshold',0.02);
    for i=1:length(radii)
        Img_Coin=Img_even_gray((centers(i,2)-radii(i)+1):(centers(i,2)+radii(i)-1),(centers(i,1)-radii(i)+1):(centers(i,1)+radii(i)-1),:);
        Img_Coin=im2uint8(Img_Coin);
        sz1=size(Img_Coin);
        [W,H] = meshgrid(1:sz1(2), 1:sz1(1));
        mask = sqrt((W-radii(i)).^2 + (H-radii(i)).^2) < radii(i);
        Img_Coin_masked=double(Img_Coin).^mask;
        Img_Coin_masked=uint8(Img_Coin_masked);
        filename = [ prefix num2str(counter) '.jpg' ];
        disp(filename);
        counter = counter + 1;
        imwrite(Img_Coin_masked,filename); 
    end
end