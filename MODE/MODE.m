clc;
clear;
close all;

%% Problem Definition
costFunctionType = 'ZDT3';	% Cost Function Type
[nVar, nObj, nCons, varMin, varMax] = objectiveDescription(costFunctionType);
varSize = [1 nVar];			% Size of Decision Variables Matrix

%% Initialize all parameter of the algotithm
maxIter = 1000;		% Maxinum Number of Iterations
popSize = 100;		% Population Size

F = 0.5;			% Scaling Factor
Cr = 0.2;			% Crossover Rate

%% A. Initialization of the Parameter Vector
parent = zeros(popSize, nVar);	% Parent Population
mutant = zeros(popSize, nVar);	% Mutant Population
child  = zeros(popSize, nVar);	% Child Population

for i = 1:popSize
	% Initialize
	for j = 1:nVar
		parent(i, j) = varMin(j) + rand*(varMax(j) - varMin(j));
	end

	% Evaluate
	cost(i, :) = evaluate(costFunctionType, parent(i, :));
end

%% Evolution Process
for n = 1:maxIter

	for i = 1:popSize

		% B. Mutation with Different Vectors
		% Generate three mutually exclusive integers randomly chosen
		% from range [1, popSize], which are also different form the
		% base vector index i.
		rev = randperm(popSize);
		while any(rev(1: 3)==i)
			rev = randperm(popSize);
		end

		% Mutant vector calculation
		mutant(i, :) = parent(rev(1,1), :)...
		+ F*(parent(rev(1, 2), :) - parent(rev(1,3), :));

		for j = 1:nVar
			if mutant(i, j) < varMin(j)
				mutant(i, j) = varMin(j);
			elseif mutant(i, j) > varMax(j)
				mutant(i, j) = varMax(j);
			end
		end

		% C. Crossover
		% Binomial Crossover
		jrand = randi(nVar);
		for j = 1:nVar
			if (rand<=Cr) || (j==jrand)
				child(i, j) = mutant(i, j);
			else
				child(i, j) = parent(i, j);
			end
		end

		% Evaluate the child population
		childCost(i, :) = evaluate(costFunctionType, child(i, :));

	end

	% C. Selection
	for i = 1:popSize
		if ~(childCost(i, :) > cost(i, :))
			parent(i, :) = child(i, :);
			cost(i, :) = childCost(i, :);
		end
	end

	% Plot the result
	figure(1);
	plot(cost(:, 1), cost(:, 2), 'r*');
	xlabel('1^{st} Objective');
	ylabel('2^{st} Objective');
	grid on;
	pause(0.01);

	% Show Iteration Information
	disp(['Iteration ' num2str(n)]);

end
