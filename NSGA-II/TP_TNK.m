options = nsgaopt();
options.popsize = 100;
options.maxGen = 500;
options.numVar = 2;
options.numObj = 2;
options.numCons = 2;
options.lb = [0 0];
options.ub = [pi pi];
options.objfun = @TP_TNK_objfun;
options.crossoverIndex = 20;
options.mutationIndex = 100;
options.mutationPara = 0.9;
options.crossoverPr = 0;
options.mutationPr = 1/options.numVar;

pop = nsga2(options);
