function totalValue = sumCoinValue(standardRadiuses, radiuses)
% add all coins without penny together
    totalValue = 0;
    sz = size(radiuses);
    lebel = zeros(sz);
    for i=1:length(radiuses)
        closest = intmax;
        for j=1:length(standardRadiuses)
            if abs(radiuses(i)-standardRadiuses(j)) < closest
                closest = abs(radiuses(i)-standardRadiuses(j));
                lebel(i) = j;
            end
        end
        if lebel(i) == 1
            totalValue = totalValue+1;
        end
        if lebel(i) == 2
            totalValue = totalValue+5;
        end
        if lebel(i) == 3
            totalValue = totalValue+10;
        end
        if lebel(i) == 4
            totalValue = totalValue+25;
        end
    end
end

