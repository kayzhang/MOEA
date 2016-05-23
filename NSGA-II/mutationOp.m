function pop = mutationOp(opt, pop)
    % In the new hybrid polynomial mutation, the disruptions level can be
    % quantified using different p(pop.mutationPara) values. It works as
    % follows: with probability 1-p use the non-highly disruptive
    % polynomial mutation and with probability p use the highly disruptive
    % version. When p=0.0 then only the non-highly disruptive polynomial
    % mutation is used. When setting p=1.0 then only the highly disruptive
    % is used. The best p value can be determined after experimental
    % evaluation of different p values for various algorithms and problems.
	
    % References
    % [1]M. Hamdan, ¡°On the Disruption-Level of Polynomial Mutation for
    % Evolutionary Multi-Objective Optimisation Algorithms,¡± Comput.
    % Inform., vol. 29, no. 5, pp. 783¨C800, 2010.
    
    nVar = opt.numVar;
	lb = opt.lb;
	ub = opt.ub;

	for i = 1:length(pop)
		child = pop(i);

		crsFlag = rand(1, nVar) < opt.mutationPr;

		for j = 1:nVar
			delta1 = (child.var(j) - lb(j))/(ub(j) - lb(j));
			delta2 = (ub(j) - child.var(j))/(ub(j) - lb(j));
			r = rand(1);
			if rand(1) > opt.mutationPara
				delta = min(delta1, delta2);
			elseif r <= 0.5
				delta = delta1;
			else
				delta = delta2;
			end
			if r <= 0.5
				deltaq(j) = (2*r + (1 - 2*r)*(1 - delta)^(opt.mutationIndex + 1))^(1/(opt.mutationIndex + 1)) - 1;
			else
				deltaq(j) = 1 - (2*(1 - r) + 2*(r - 0.5)*(1 - delta)^(opt.mutationIndex + 1))^(1/(opt.mutationIndex + 1));
			end
		end

		child.var = child.var + crsFlag.*deltaq.*(ub - lb);

		% Bounding limit
		child.var = varlimit(child.var, opt.lb, opt.ub);

		pop(i) = child;
	end
