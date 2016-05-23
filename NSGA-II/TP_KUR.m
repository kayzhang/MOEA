options = nsgaopt();
options.popsize = 50;
options.maxGen = 100;
options.numVar = 3;
options.numObj = 2;
options.numCons = 0;
options.lb = [-5 -5 -5];
options.ub = [5 5 5];
options.objfun = @TP_KUR_objfun;
options.crossoverIndex = 20;
options.mutationIndex = 20;
options.mutationPara = 0.9;
options.crossoverPr = 0;
options.mutationPr = 1/options.numVar;

pop = nsga2(options);
