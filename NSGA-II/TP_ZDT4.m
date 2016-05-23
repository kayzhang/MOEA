options = nsgaopt();
options.popsize = 50;
options.maxGen = 1000;
options.numVar = 10;
options.numObj = 2;
options.numCons = 0;
options.lb = [0 -5*ones(1, 9)];
options.ub = [1 5*ones(1, 9)];
options.objfun = @TP_ZDT4_objfun;
options.crossoverIndex = 20;
options.mutationIndex = 10;
options.mutationPara = 0.9;
options.crossoverPr = 0.9;
options.mutationPr = 1/options.numVar;

pop = nsga2(options);
