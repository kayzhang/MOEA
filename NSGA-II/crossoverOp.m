function pop = crossoverOp(opt, pop)
    % Function: pop = crossoverOp(opt, pop)
    
    % References
    % [1]K. Deb and R. B. Agrawal, ¡°Simulated binary crossover for
    % continuous search space,¡± Complex systems, vol. 9, no. 2, pp.
    % 115-148, 1995.
    % [2]¡°Survey on multiobjective evolutionary and real coded genetic
    % algorithms.¡± .

    nVar = opt.numVar;
	
	for i = 1:2:length(pop)
		child1 = pop(i);
		child2 = pop(i+1);

		crsFlag = rand(1, nVar) < opt.crossoverPr;

		for j = 1:nVar
			u(j) = rand(1);
			if u(j) <= 0.5;
				bq(j) = (2*u(j))^(1/(opt.crossoverIndex + 1));
			else
				bq(j) = (1/(2*(1 - u(j))))^(1/(opt.crossoverIndex + 1));
			end
		end
		
		child1.var = pop(i).var + crsFlag.*(0.5.*((1 + bq).*pop(i).var + (1 - bq).*pop(i+1).var) - pop(i).var);
		child2.var = pop(i+1).var + crsFlag.*(0.5.*((1 - bq).*pop(i).var + (1 + bq).*pop(i+1).var) - pop(i+1).var);

		% Bounding limit
		child1.var = varlimit(child1.var, opt.lb, opt.ub);
		child2.var = varlimit(child2.var, opt.lb, opt.ub);

		pop(i) = child1;
		pop(i+1) = child2;
	end
end				
