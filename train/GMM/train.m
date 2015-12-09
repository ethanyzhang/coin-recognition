% training data
dirstruct = dir('*.png');
reim = [];
for i = 1:length(dirstruct)
     im = imread(dirstruct(i).name);
     im = rgb2hsv(im);
     [o,p,q] = size(im);
     reim = [reim; reshape(im,o*p,q)];
end
reim = reim';
reim = im2double(reim);
[label, model5, llh] = emgm(reim, 5);
save model5 model5