% Project Title: Multi-Objective Particle Swarm Optimization (MOPSO)

% References
% [1]C. A. C. Coello, G. T. Pulido, and M. S. Lechuga, ¡°Handling multiple
% objectives with particle swarm optimization,¡± IEEE Transactions on
% Evolutionary Computation, vol. 8, no. 3, pp. 256¨C279, Jun. 2004.

clc;
clear;
close all;

%% Problem Definition

CostFunctionType = 'ZDT4';	% Cost Function Type

[nVar, VarMin, VarMax] = ObjectiveDescription(CostFunctionType);

VarSize = [1 nVar];         % Size of Decision Variables Matrix


%% MOPSO Parameters

MaxIt = 200;		% Maximum Number of Iterations

nPop = 200;			% Population Size

nRep = 100;			% Repository Size

w = 0.6;			% Inertia Weight
% wdamp = 0.99;		% Inertia Weight Damping Rate
c1 = 1;				% Personal Learning Coefficient
c2 = 2;				% Global Learning Coefficient

nGrid = 7;			% Number of Grids per Dimension
alpha = 0.1;		% Inflation Rate

beta = 2;			% Leader Selection Pressure
gamma = 2;			% Deletion Selection Pressure

mu = 0.1;			% Mutation Rate


%% Initialization

empty_particle.Position = [];
empty_particle.Velocity = [];
empty_particle.Cost = [];
empty_particle.Best.Position = [];
empty_particle.Best.Cost = [];
empty_particle.IsDominated = [];
empty_particle.GridIndex = [];
empty_particle.GridSubIndex = [];

pop = repmat(empty_particle, nPop, 1);

for i = 1:nPop

	pop(i).Position = unifrnd(VarMin, VarMax, VarSize);

	pop(i).Velocity = zeros(VarSize);

	pop(i).Cost = CostFunction(CostFunctionType, pop(i).Position);


	% Update Personal Best
	pop(i).Best.Position = pop(i).Position;
	pop(i).Best.Cost = pop(i).Cost;

end

% Determine Domination
pop = DetermineDomination(pop);

rep = pop(~[pop.IsDominated]);

Grid = CreateGrid(rep, nGrid, alpha);

for i = 1:numel(rep)
	rep(i) = FindGridIndex(rep(i), Grid);
end


%% MOPSO Main Loop

for it = 1:MaxIt

	for i = 1:nPop

		leader = SelectLeader(rep, beta);

		pop(i).Velocity = w*pop(i).Velocity + c1*rand(VarSize).*(pop(i).Best.Position - pop(i).Position) + c2*rand(VarSize).*(leader.Position - pop(i).Position);

		pop(i).Position = pop(i).Position + pop(i).Velocity;

		% Maintain the particle whin the search space in case they go beyond their boundaries.
		pop(i).Position = max(pop(i).Position, VarMin);
		pop(i).Position = min(pop(i).Position, VarMax);

		pop(i).Cost = CostFunction(CostFunctionType, pop(i).Position);

		% Apply Mutation
		pm = (1 - it/MaxIt)^(5/mu);
		if rand < pm
			NewSol.Position = Mutate(pop(i).Position, pm, VarMin, VarMax);
			NewSol.Cost = CostFunction(CostFunctionType, NewSol.Position);
			if Dominates(NewSol, pop(i))
				pop(i).Position = NewSol.Position;
				pop(i).Cost = NewSol.Cost;
			elseif Dominates(pop(i), NewSol)
				% Do Nothing
			else
				if rand < 0.5
					pop(i).Position = NewSol.Position;
					pop(i).Cost = NewSol.Cost;
				end
			end
		end

		if Dominates(pop(i), pop(i).Best)
			pop(i).Best.Position = pop(i).Position;
			pop(i).Best.Cost = pop(i).Cost;
		elseif Dominates(pop(i).Best, pop(i))
			% Do Nothing
		else
			if rand < 0.5
				pop(i).Best.Position = pop(i).Position;
				pop(i).Best.Cost = pop(i).Cost;
			end
		end

	end

	% Determine Domination
	pop = DetermineDomination(pop);

	% Add Non-Dominated Particles to REPOSITORY
	rep = [rep; pop(~[pop.IsDominated])];

	% Determine Domination of New Repository Members
    rep = DetermineDomination(rep);

    % Keep only Non-Dominated Members in the Repository
	rep = rep(~[rep.IsDominated]);

	% Update Grid
	Grid = CreateGrid(rep, nGrid, alpha);

	% Update Grid Indices
	for i = 1:numel(rep)
		rep(i) = FindGridIndex(rep(i), Grid);
	end

	% Check if Repository is Full
	if numel(rep) > nRep
		Extra = numel(rep) - nRep;
		for e = 1:Extra
			rep = DeleteOneRepMember(rep, gamma);
		end
	end

	% Plot Costs
	figure(1);
	PlotCosts(pop, rep);
	pause(0.01);

	% Show Iteration Information
	disp(['Iteration ' num2str(it) ': Number of Rep Members = ' num2str(numel(rep))]);

	% Damping Inertia Weight
	% w = w*wdamp;

end
