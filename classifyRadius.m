function [R,num] = classifyRadius(radiuses)
%RADI_CLASSIFY determine how many kinds of different coins are exist
%  input: radiuses, the radius getting from hough circle detection
%  output: R, radius
%        num, number of circles in the image which have the same radius R
  radiuses = sort(radiuses, 'descend');
  l = length(radiuses);
  r = zeros(l, 4);
  a = 1;
  b = 1;

  % classify
  for i = 1 : l-1
    temp = radiuses(i)/radiuses(i + 1);
    if temp > 1.08
     r(a:i,b) = radiuses(a:i);
     a = i + 1;
     b = b + 1;
    end
  end
  r(a:end,b) = radiuses(a:end);

  if mean(r(:,4)~=0)
    fprintf('Error, radius detected by hough transform are classified to more than 3 classes, which is not proper as there are only 3 type of coins without penny\n');
    return;
  end

  % get the number of elements for every class
  r1 = r(:,1);
  r2 = r(:,2);
  r3 = r(:,3);
  R = mean(r1(r1~=0));
  ind = find(r1~=0);
  num = size(ind,1);
  R2 = mean(r2(r2~=0));
  R3 = mean(r3(r3~=0));
  if ~isnan(R2)
    R = [R; R2];
    ind = find(r2~=0);
    num = [num; size(ind,1)];  
    if ~isnan(R3)
      R = [R; R3];
      ind = find(r3~=0);
      num = [num; size(ind,1)];
    end
  end
end

