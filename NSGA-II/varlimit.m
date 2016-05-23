function var = varlimit(var, lb, ub)
	
	numVar = length(var);
	for i = 1:numVar
		if(var(i) < lb(i))
			var(i) = lb(i);
		elseif(var(i) > ub(i))
			var(i) = ub(i);
		end
	end
end
