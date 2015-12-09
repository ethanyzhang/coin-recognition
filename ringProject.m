function out = ringProject(img)
% this function does the ring projection
  [height, width] = size(img);
  R = round(sqrt(height*height + width*width)/2);
  out = zeros(R+1, 360);
  count = zeros(R+1, 360);
  coef = zeros(1, 360);
  cycle = floor(acosd(width/2/R));
  % Calculate the scale factor for each angle.
  for i=1:cycle
    coef(i)=ceil(width/2/cosd(i));
  end
  for i=cycle+1:90
    coef(i)=ceil(height/2/cosd(90-i));
  end
  coef(91:180)=fliplr(coef(1:90));
  coef(181:360)=coef(1:180);
  for i=1:width
    x=i-width/2;
    for j=1:height
      y=j-height/2;
      [theta, rho] = cart2pol(x, y);
      theta=round(rad2deg(theta));
      while theta <= 0
        theta=theta+360;
      end
      rho_scale = round(rho / coef(theta) * R);
      if rho_scale~=0
        out(rho_scale, theta)=out(rho_scale, theta)+img(j,i);
        count(rho_scale, theta)=count(rho_scale, theta)+1;
      end
    end
  end
  out = out ./ count;
  out=uint8(out);
end