function pop = initpop(opt, pop)
	
	nVar = opt.numVar;
	lb = opt.lb;
	ub = opt.ub;
	popsize = length(pop);
	for i = 1:popsize
		var = lb + rand(1, nVar).*(ub - lb);
		var = varlimit(var, lb, ub);
		pop(i).var = var;
	end
end
