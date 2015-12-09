function tyncom = generateCombinations(n)
%COM_GEN generate all possible radius ratio of different types of coins combination
% 1cent: 19.05, 5cents: 21.21, 10cents: 17.91, 25cents: 24.26, 50cents: 30.61, 100cents: 26.46 
  tyncom = cell(1,4);
  if n == 3
    choicevec = [21.21 17.91 24.26];
  elseif n == 5
    choicevec = [21.21 17.91 24.26 30.61 26.46];
  end

  % two types of coins
  ty2com = nchoosek(choicevec,2);
  [m, n] = size(ty2com);
  ty2com(:,3) = ty2com(:,1)./ty2com(:,2);
  for i = 1:m
    if ty2com(i,3) < 1
      ty2com(i,3) = 1.0/ty2com(i,3);
    end
  end
  ty2com = sort(ty2com,2,'descend');
  tyncom{1} = ty2com;

  % three types of coins
  ty3com = nchoosek(choicevec,3);
  ty3com = sort(ty3com,2,'descend');
  ty3com(:,4) = ty3com(:,1)./ty3com(:,2);
  ty3com(:,5) = ty3com(:,1)./ty3com(:,3);
  ty3com(:,6) = ty3com(:,2)./ty3com(:,3);
  tyncom{2} = ty3com;

  if n > 3
  % four types of coins
  ty4com = nchoosek(choicevec,4);
  ty4com = sort(ty4com,2,'descend');
  ty4com(:,5) = ty4com(:,1)./ty4com(:,2);
  ty4com(:,6) = ty4com(:,1)./ty4com(:,3);
  ty4com(:,7) = ty4com(:,1)./ty4com(:,4);
  ty4com(:,8) = ty4com(:,2)./ty4com(:,3);
  ty4com(:,9) = ty4com(:,2)./ty4com(:,4);
  ty4com(:,10) = ty4com(:,3)./ty4com(:,4);
  tyncom{3} = ty4com;

  % five types of coins
  ty5com = nchoosek(choicevec,5);
  ty5com = sort(ty5com,2,'descend');
  ty5com(:,6) = ty5com(:,1)./ty5com(:,2);
  ty5com(:,7) = ty5com(:,1)./ty5com(:,3);
  ty5com(:,8) = ty5com(:,1)./ty5com(:,4);
  ty5com(:,9) = ty5com(:,1)./ty5com(:,5);
  ty5com(:,10) = ty5com(:,2)./ty5com(:,3);
  ty5com(:,11) = ty5com(:,2)./ty5com(:,4);
  ty5com(:,12) = ty5com(:,2)./ty5com(:,5);
  ty5com(:,13) = ty5com(:,3)./ty5com(:,4);
  ty5com(:,14) = ty5com(:,3)./ty5com(:,5);
  ty5com(:,15) = ty5com(:,4)./ty5com(:,5);
  tyncom{4} = ty5com;
  end
end


