clc;
clear;
close all;

%% Problem Definition
costFunctionType = 'ZDT4';	% Cost Function Type
[nVar, nObj, nCons, varMin, varMax] = objectiveDescription(costFunctionType);
varSize = [1 nVar];			% Size of Decision Variables Matrix

%% Initialize all parameter of the algotithm
maxIter = 250;		% Maxinum Number of Iterations
popSize = 100;		% Population Size

F = 0.5;			% Scaling Factor
Cr = 0.2;			% Crossover Rate

%% Initialize random population
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

	for x = 1:nVar 