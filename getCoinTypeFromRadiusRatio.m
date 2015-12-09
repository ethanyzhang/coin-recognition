function [coinType] = getCoinTypeFromRadiusRatio(r)
%COIN_REGO_RATIO determine coin type by radius ratio
%   input: r, vector of radius, rmax to rmin in sequence
%   output: coin_type, radius corresponds coin type
  tyncom = generateCombinations(3);
  n = length(r);
  if n == 0
    coinType = 0;
  elseif n == 1
    % finished by neural network
  elseif n == 2
    ty2com = tyncom{1};
    ratio = r(1)/r(2);
    dif = abs(ty2com(:,3) - ratio);
    i = find(dif == min(dif));
    if length(i) == 1
      coin_radi = ty2com(i,1:2);
      coinType = radiusToType(coin_radi);
    else
      % to be continued
    end
  elseif n == 3
    ty3com = tyncom{2};
    i = ratio_comp(n, ty3com, r);
    if length(i) == 1
      coin_radi = ty3com(i,1:3);
      coinType = radi_to_ty(coin_radi);
    else
      % to be continued
    end
  elseif n == 4
    ty4com = tyncom{3};
    i = ratio_comp(n, ty4com, r);
    if length(i) == 1
      coin_radi = ty4com(i,1:4);
      coinType = radi_to_ty(coin_radi);
    else
      % to be continued
    end
  elseif n == 5
    ty5com = tyncom{4};
    i = ratio_comp(n, ty5com, r);
    if length(i) == 1
      coin_radi = ty5com(i,1:5);
      coinType = radi_to_ty(coin_radi);
    else
      % to be continued
    end
  elseif n == 6
    coinType = [50, 100, 25, 5, 1, 10];
  else
    fprintf('%s\n','Error in circle detection.');
    fprintf('%s\n','There are at most 6 types of American coins. Radius types are larger than possible coin types. Impossible.');
    return;
  end 
end
  
  
  
  
  