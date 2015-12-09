function i = ratio_comp(n, tynum, r)
% Find the most nearest radius ratio vectors among all possibilities
% input: n, radius type number
%        tynum, ratio lists
%        r, radius vector
% output: most possible radius index in tynum

  m = size(tynum, 1);
  if n == 3
    ratio = [r(1)/r(2), r(1)/r(3), r(2)/r(3)];
  elseif n == 4
    ratio = [r(1)/r(2), r(1)/r(3), r(1)/r(4),r(2)/r(3), r(2)/r(4), r(3)/r(4)];
  elseif n == 5
    ratio = [r(1)/r(2), r(1)/r(3), r(1)/r(4),r(1)/r(5), r(2)/r(3), r(2)/r(4),r(2)/r(5),r(3)/r(4),r(3)/r(5),r(4)/r(5)];
  end 
  ratio = repmat(ratio, m, 1);
  dif = abs(tynum(:,(n+1):end) - ratio);
  sum_dif = sum(dif,2);
  i = find(sum_dif == min(sum_dif));
end