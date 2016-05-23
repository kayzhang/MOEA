options = nsgaopt();
options.popsize = 50;
options.maxGen = 500;
options.numVar = 1;
options.numObj = 2;
options.numCons = 0;
options.lb = -1000;
options.ub = 1000;
options.objfun = @TP_SCH_objfun;
options.crossoverIndex = 20;
options.mutationIndex = 20;
options.mutationPara = 0.9;
options.crossoverPr = 0;
options.mutationPr = 1/options.numVar;

pop = nsga2(options);
