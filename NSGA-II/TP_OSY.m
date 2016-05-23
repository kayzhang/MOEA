options = nsgaopt();
options.popsize = 100;
options.maxGen = 1000;
options.numVar = 6;
options.numObj = 2;
options.numCons = 6;
options.lb = [0 0 1 0 1 0];
options.ub = [10 10 5 6 5 10];
options.objfun = @TP_OSY_objfun;
options.crossoverIndex = 20;
options.mutationIndex = 20;
options.mutationPara = 1;
options.crossoverPr = 0.9;
options.mutationPr = 1/options.numVar;

pop = nsga2(options);
