function z = calculatePDF(I, model_name)
%PDF_CAL calculate the pdf of every pixel in an image, function is
%according to Gaussian mixture model
%   input: I, hsv image
%          model_name, model parameters, mu, sigma, weight
%          y, pdf image
%   output: z, binary image with high pdf equals 1 while low pdf equals 0
  [o,p,q] = size(I);
  x = reshape(I,o*p,q);
  model = model_name;
  mu = model.mu;
  sigma = model.Sigma;
  weight = model.weight;
  obj = gmdistribution(mu',sigma,weight);
  y = pdf(obj,x);
  z = reshape(y,o,p);
  level = graythresh(z);
  z = im2bw(z,level);
  z = medfilt2(z,[5,5]);
end