function defaultopt = nsgaopt()
    % Function: defaultopt = nsgaopt()
    % Description: Create NSGA-II default options structure.
    % Syntax:  opt = nsgaopt()
    
	defaultopt = struct(...
		'popsize', 50, ...          % population size
		'maxGen', 100, ...          % maxinum generation
		'numVar', 0, ...            % number of design variables
		'numObj', 0, ...            % number of objectives
		'numCons', 0, ...           % number of constraints
		'lb', [], ...               % lower bound of design variables [1:numVar]
		'ub', [], ...               % upper bound of design variables [1:numVar]
		'objfun', @objfun, ...      % objective function
		'crossoverIndex', 20, ...   % distribution index for real-coded crossover operator
		'mutationIndex', 20, ...    % distribution index for real-coded mutation operator
		'mutationPara', 1, ...      % user specified value in the range [0, 1]
		'crossoverPr', 0.9, ...     % probability of crossover
		'mutationPr', 0.1);         % probability of mutation
