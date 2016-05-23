options = nsgaopt();
options.popsize = 50;
options.maxGen = 1000;
options.numVar = 10;
options.numObj = 2;
options.numCons = 0;
options.lb = zeros(1, 10);
options.ub = ones(1, 10);
options.objfun = @TP_ZDT6_objfun;
options.crossoverIndex = 20;
options.mutationIndex = 20;
options.mutationPara = 0.9;
options.crossoverPr = 0;
options.mutationPr = 1/options.numVar;

pop = nsga2(options);
