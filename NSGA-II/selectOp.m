function newpop = selectOp(pop)

	popsize = length(pop);
	pool = zeros(1, popsize);   % pool : the individual index selected

	randnum = randi(popsize, [1, 2*popsize]);

	j = 1;
	for i = 1:2:(2*popsize)
		p1 = randnum(i);
		p2 = randnum(i+1);
		if((pop(p1).rank < pop(p2).rank) || ((pop(p1).rank == pop(p2).rank) && (pop(p1).distance > pop(p2).distance) ))
			pool(j) = p1;
		else
			pool(j) = p2;
		end

		j = j + 1;
	end
	newpop = pop(pool);
end
