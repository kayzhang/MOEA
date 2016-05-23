function pop = nsga2(opt)

	nVar = opt.numVar;
	nObj = opt.numObj;
	nCons = opt.numCons;
	popsize = opt.popsize;

	pop = repmat( struct(...
		'var', zeros(1, nVar), ...
		'obj', zeros(1, nObj), ...
		'cons', zeros(1, nCons), ...
		'rank', 0, ...
		'distance', 0, ...
		'nViol', 0, ...
		'violSum', 0), ...
		[1, popsize]);

	ngen = 1;
	pop = initpop(opt, pop);
	pop = evaluate(opt, pop);
	pop = ndsort(opt, pop);

    while( ngen < opt.maxGen )
		ngen = ngen + 1;

		% 1. Create new population
		newpop = selectOp(pop);
		newpop = crossoverOp(opt, newpop);
		newpop = mutationOp(opt, newpop);
		newpop = evaluate(opt, newpop);

		% 2. Combine the new population and old population : combinepop = pop + newpop
		combinepop = [pop, newpop];
        
        % 3. Fast non dominated sort
        combinepop = ndsort(opt, combinepop);

		% 4. Extract the next population
		pop = extractPop(opt, combinepop);
    
        plotObj = vertcat(pop(:).obj);
		plot(plotObj(:, 1), plotObj(:, 2), '*');
        pause(0.00000001);
        if ~mod(ngen, 100)
            clc
            fprintf('%d generations completed\n', ngen);
        end
    end
end
