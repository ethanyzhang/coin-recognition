function coinType = radiusToType(coin_radi)
% Convert coin's real radius to coin's value
  m = length(coin_radi);
  coinType = zeros(m,1);
  for i = 1:m
    if coin_radi(i) == 19.05
      coinType(i) = 1;
    elseif coin_radi(i) == 21.21
      coinType(i) = 5;
    elseif coin_radi(i) == 17.91
      coinType(i) = 10;
    elseif coin_radi(i) == 24.26
      coinType(i) = 25;
    elseif coin_radi(i) == 30.61
      coinType(i) = 50;
    elseif coin_radi(i) == 26.49
      coinType(i) = 100;
    else
      fprintf('%s\n','error');
    end
  end
end
