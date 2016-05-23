% Project Title: Multi-Objective Particle Swarm Optimization (MOPSO)

% References
% [1]C. A. C. Coello, G. T. Pulido, and M. S. Lechuga, ¡°Handling multiple
% objectives with particle swarm optimization,¡± IEEE Transactions on
% Evolutionary Computation, vol. 8, no. 3, pp. 256¨C279, Jun. 2004.

clc;
clear;
close all;

%% Problem Definition
CostFunctionType = 'ZDT1';	% Cost Function Type
[nVar, VarMin, VarMax] = ObjectiveDescription(CostFunctionType);
VarSize = [1 nVar];         % Size of Decision Variables Matrix

%% Initialize all parameter of the algorithm
MaxIt = 250;		% Maximum Number of Iterations
nPop = 200;			% Population Size
nRepMax = 200;			% Repository Size
pm = 1/nVar;		% Mutation Rate
perturbation = 0.5;

empty_particle.Position = [];
empty_particle.Velocity = [];
empty_particle.Cost = [];
empty_particle.Best.Position = [];
empty_particle.Best.Cost = [];
empty_particle.IsDominated = [];
empty_particle.Distance = [];

pop = repmat(empty_particle, nPop, 1);
    
for i = 1:nPop
    % Create the initial population and evaluate
	pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
	pop(i).Cost = CostFunction(CostFunctionType, pop(i).Position);
    
    % Initial the speed of each particle to 0
    pop(i).Velocity = zeros(VarSize);

	% Initialize the memory of ezch particle
	pop(i).Best.Position = pop(i).Position;
	pop(i).Best.Cost = pop(i).Cost;
end

% Determine Domination
pop = DetermineDomination(pop);

% Add Non-Dominated Particles to REPOSITORY
rep = pop(~[pop.IsDominated]);


%% MOPSO Main Loop

for it = 1:MaxIt
    
    % Calculate the Crowding Distance
    rep = CrowdingDistance(rep);

	for i = 1:nPop

        % Compute the speed
        % Select a global best for calculate the speed of particle i
        nRep = numel(rep);
        n1 = randi(nRep);
        n2 = randi(nRep);
        if rep(n1).Distance > rep(n2).Distance
            leader = rep(n1);
        else
            leader = rep(n2);
        end
        % Paras for velocity equation
        w = 0.4*rand + 0.1;
        c1 = 0.5*rand + 1.5;
        c2 = 0.5*rand + 1.5;
        r1 = rand;
        r2 = rand;
        % Compute the velocity of each particle
		pop(i).Velocity = w*pop(i).Velocity + c1*r1*(pop(i).Best.Position - pop(i).Position) + c2*r2*(leader.Position - pop(i).Position);

        % Update the position of each particle
		pop(i).Position = pop(i).Position + pop(i).Velocity;
		% Maintain the particle whin the search space in case they go beyond their boundaries.
        for k = 1:nVar
            if pop(i).Position(k) < VarMin(k)
                pop(i).Position(k) = VarMin(k);
                pop(i).Velocity(k) = -1*pop(i).Velocity(k);
            end
            if pop(i).Position(k) > VarMax(k)
                pop(i).Position(k) = VarMax(k);
                pop(i).Velocity(k) = -1*pop(i).Velocity(k);
            end
        end
%         pop(i).Position = max(pop(i).Position, VarMin);
%         pop(i).Position = min(pop(i).Position, VarMax);

        % Mutate the particles
        if mod(i, 3) == 0
            % non-uniform mutation
            pop(i).Position = NonUniformMutation(pop(i).Position, pm, VarMin, VarMax, it, MaxIt, perturbation);
        elseif mod(i, 3) == 1
            % uniform mutation
            pop(i).Position = UniformMutation(pop(i).Position, pm, VarMin, VarMax, perturbation);
        else
            % particles without mutation
        end
        
        % Evaluate the new particles in new positions
        pop(i).Cost = CostFunction(CostFunctionType, pop(i).Position);

        % Actualize the memory of this particle
		if Dominates(pop(i).Best, pop(i))
			% Do nothing
        else
            pop(i).Best.Position = pop(i).Position;
			pop(i).Best.Cost = pop(i).Cost;
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

    % Calculate the Crowding Distance
    rep = CrowdingDistance(rep);
    
	% Check if Repository is Full
	if numel(rep) > nRepMax
		Extra = numel(rep) - nRepMax;
		rep = DeleteOneRepMember(rep, Extra);
	end

	% Plot Costs
	figure(1);
	PlotCosts(pop, rep);
	pause(0.01);

	% Show Iteration Information
	disp(['Iteration ' num2str(it) ': Number of Rep Members = ' num2str(numel(rep))]);

end
