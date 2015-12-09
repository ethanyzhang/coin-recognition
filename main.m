function main(file)
% input: file, RGB image
  warning('off', 'all');
  image = imread(file);
  disp('Please wait while we are processing the image.');

  originalImage = image;
  image = imresize(image, 0.5);
  image = im2double(image);
  % Get rid of the background.
  disp('Computing background mask.');
  maskedImage = maskBackground(image);

  disp('Separating pennies from other types of coin.');
  [imgPenny, imgOther] = separatePenny(maskedImage);
  pennyRadiuses = getPennyRadiuses(imgPenny);

  % if there is penny in the image, use radius difference to get coins value 
  if ~isempty(pennyRadiuses)
    disp(['There are ' num2str(length(pennyRadiuses)) ' pennies in the image.']);
    standardRadiuses = zeros(4,1);
    standardRadiuses(1) = mean(pennyRadiuses);
    % nickel, dime, quarter
    standardRadiuses(2) = standardRadiuses(1)*21.21/19.05;
    standardRadiuses(3) = standardRadiuses(1)*17.91/19.05;
    standardRadiuses(4) = standardRadiuses(1)*24.26/19.05;
    standardRadiuses(1) = 0;
    otherRadiuses = getOtherCoinsInfo(imgOther);
    disp(['There are ' num2str(length(otherRadiuses)) ' coins of other type in the image.']);
    totalValue = length(pennyRadiuses) + sumCoinValue(standardRadiuses, otherRadiuses);
  % if there is no penny in the image
  else
    disp('There is no penny in the image.');
    [otherRadiuses, otherCenters] = getOtherCoinsInfo(imgOther);
    if ~isempty(otherRadiuses)
      disp(['There are ' num2str(length(otherRadiuses)) ' coins of other type in the image.']);
      [classifiedRadiuses, num] = classifyRadius(otherRadiuses);

      % if there are only one type of coins in the image, neural network
      if length(classifiedRadiuses) == 1
        disp('There is only one type of coin in the image, use artificial neural network for classification.');
        load('net.mat');
        classValue = [25 25 10 10 5 5 5];
        imgGrayEven = eliminateLight(image);
        coinImages = getCoinImages(imgGrayEven, otherRadiuses, otherCenters);
        coinImageCount = length(otherRadiuses);
        % Use C++ ----------------------------------
        inputVectors = zeros(coinImageCount, 32040);
        for i = 1:coinImageCount
            image = coinImages{i};
            projectedImage = ringProject(image);
            in = reshape(projectedImage, 1, 32040);
            inputVector = im2double(in);
            inputVectors(i) = inputVector;
        end
        fid = fopen('nn/input.bin', 'wb');
        fwrite(fid, inputVectors);
        fclose(fid);
        system('nn/nn');
        resultVector = csvread('nn/output.csv');
        
        % Use Matlab ------------------------------
%         resultVector = zeros(1, coinImageCount);
%         for i = 1:coinImageCount
%           image = coinImages{i};
%           projectedImage = ringProject(image);
%           in = reshape(projectedImage, 32040, 1);
%           testX = im2double(in);
%           testY = net(testX);
%           testY = uint8(testY);
%           testIndices = vec2ind(testY);
%           resultVector(1, i) = testIndices;
%         end

        valueVector = classValue(resultVector);
        % choose the mode of the classification result as the final result
        individualValue = mode(valueVector);
        totalValue = individualValue * coinImageCount;

      % if there are more than one type of coins(not counting penny) in the image
      else
        disp('There are more than one type of coin in the image, then use radius ratio to decide the coin type.')
        [coinType] = getCoinTypeFromRadiusRatio(classifiedRadiuses);
        totalValue = sum(coinType.*num);
      end
    else
      totalValue = 0;
    end
  end

  % show results on the input image
  T = ['TOTAL: ' num2str(totalValue) ' cents'];
  finalImage = insertText(originalImage, [0 100], T, 'FontSize', 70);
  close all;
  figure;
  imshow(finalImage);
  disp([ 'The total is ' num2str(totalValue) ' cents.']);
end
