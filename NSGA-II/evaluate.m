function pop = evaluate(opt, pop)
	
	for i = 1:length(pop)
		[pop(i).obj, cons] = opt.objfun(pop(i).var);
		if(~isempty(pop(i).cons))
			idx = find(cons);
			if(~isempty(idx))
				pop(i).nViol = length(idx);
				pop(i).voilSum = sum(cons);
			else
				pop(i).nViol = 0;
				pop(i).violSum = 0;
			end
		end
	end
end
