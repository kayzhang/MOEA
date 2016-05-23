%  Matlab Code for SMPSO
%
%  SMPSO: Speed-constrained Multi-objective Particle Swarm Optimization
%
%  References:
%  [1]C. A. C. Coello, G. T. Pulido, and M. S. Lechuga, ¡°Handling multiple
%  objectives with particle swarm optimization,¡± IEEE Transactions on
%  Evolutionary Computation, vol. 8, no. 3, pp. 256¨C279, Jun. 2004.
%  [2]M. R. Sierra and C. a. C. Coello, ¡°Improving PSO-Based
%  multi-objective optimization using crowding, mutation and
%  epsilon-dominance,¡± in Evolutionary Multi-Criterion Optimization, vol.
%  3410, C. a. C. Coello, A. H. Aguirre, and E. Zitzler, Eds. Berlin:
%  Springer-Verlag Berlin, 2005, pp. 505¨C519.
%  [3]A. J. Nebro, J. J. Durillo, J. Garcia-Nieto, C. A. C. Coello, F.
%  Luna, and E. Alba, ¡°SMPSO: A new PSO-based metaheuristic for
%  multi-objective optimization,¡± in ieee symposium on Computational
%  intelligence in miulti-criteria decision-making, 2009. mcdm ¡¯09, 2009,
%  pp. 66¨C73.
%

clc;
clear;
close all;

%% Problem Definition
costFunctionType = 'ZDT4';	% Cost Function Type
[nVar, nCons, varMin, varMax] = objectiveDescription(costFunctionType);
varSize = [1 nVar];         % Size of Decision Variables Matrix

%% Initialize all parameter of the algorithm
maxIterations = 250;        % Maximum Number of Iterations
swarmSize = 100;            % Swarm Size
repSize = 100;              % Repository Size
pm = 1/nVar;                % Mutation Rate
mutationPara = 1;           % Scale Factor of Non-highly (p=0) and Highly (p=1) Disruptive Polynomial Mutation
distributionIndex = 20;     % Distribution Index for Polynomial Mutation

r1Max = 1;
r1Min = 0;
r2Max = 1;
r2Min = 0;
c1Max = 2.5;
c1Min = 1.5;
c2Max = 2.5;
c2Min = 1.5;
weightMax = 0.1;
weightMin = 0.1;
deltaMax = (varMax - varMin)/2; % Upper Boundary of Velocity
deltaMin = -1*deltaMax;         % Lower Boundary of Velocity
% Paper [3] said that for changeVelocity 0.001 is better than -1 in paper
% [1], but in my actual test, -1 is better, and 0.001 even can't work.
changeVelocity1 = -1;       % Change Coefficient of Velocity when a Particle Goes beyond it's Lower Boundary
changeVelocity2 = -1;       % Change Coefficient of Velocity when a Particle Goes beyond it's Upper Boundary

% Create the population structure
empty_particle.Position = [];
empty_particle.Velocity = [];
empty_particle.Cost = [];
empty_particle.Best.Position = [];
empty_particle.Best.Cost = [];
empty_particle.Best.OverallConstraintViolation = [];
empty_particle.Distance = [];
empty_particle.OverallConstraintViolation = [];

swarm = repmat(empty_particle, swarmSize, 1);
rep = [];
    
for i = 1:swarmSize
    % Create the initial population and evaluate
	swarm(i).Position = unifrnd(varMin, varMax, varSize);
	swarm(i).Cost = evaluate(costFunctionType, swarm(i).Position);
    if nCons ~= 0
        swarm(i).OverallConstraintViolation = evaluateConstraints(costFunctionType, swarm(i).Position, nCons);
    end
    
    % Initial the speed of each particle to 0
    swarm(i).Velocity = zeros(varSize);
    
    % Add the particle to rep if it's non-dominated
    rep = leadersAdd(swarm(i), rep, repSize, nCons);

	% Initialize the memory of each particle
	swarm(i).Best.Position = swarm(i).Position;
	swarm(i).Best.Cost = swarm(i).Cost;
    swarm(i).Best.OverallConstraintViolation = swarm(i).OverallConstraintViolation;
end

% Crowding the leaders
rep = crowdingDistanceAssignment(rep);


%% MOPSO Main Loop

for it = 1:maxIterations

    % Compute the speed
    swarm = computeSpeed(swarm, rep, weightMin, weightMax, r1Min, r1Max, r2Min, r2Max, ...
        c1Min, c1Max, c2Min, c2Max, deltaMin, deltaMax);

    % Compute the new positions for the particles
    for i = 1:swarmSize
        % Update the position of each particle
		swarm(i).Position = swarm(i).Position + swarm(i).Velocity;
		% Maintain the particle whin the search space in case they go beyond their boundaries.
        for k = 1:nVar
            if swarm(i).Position(k) < varMin(k)
                swarm(i).Position(k) = varMin(k);
                swarm(i).Velocity(k) = changeVelocity1*swarm(i).Velocity(k);
            end
            if swarm(i).Position(k) > varMax(k)
                swarm(i).Position(k) = varMax(k);
                swarm(i).Velocity(k) = changeVelocity2*swarm(i).Velocity(k);
            end
        end
    end
    
    % Mutate the particles
    for i = 1:swarmSize
        if mod(i, 6) == 0
            % Polynomial Mutation
            swarm(i).Position = polynomialMutation(swarm(i).Position, pm, varMin, ...
                varMax, mutationPara, distributionIndex);
        end
    end
    
    % Evaluate the new particles in new positions
    for i = 1:swarmSize
        swarm(i).Cost = evaluate(costFunctionType, swarm(i).Position);
    end
    if nCons ~= 0
        for i = 1:swarmSize
            swarm(i).OverallConstraintViolation = evaluateConstraints(costFunctionType, swarm(i).Position, nCons);
        end
    end
    
    % Actualize the Repository
    for i = 1:swarmSize
        rep = leadersAdd(swarm(i), rep, repSize, nCons);
    end
    
    % Actualize the memory of this particle
    for i = 1:swarmSize
        if dominanceCompare(swarm(i), swarm(i).Best, nCons) ~= -1
            swarm(i).Best.Position = swarm(i).Position;
			swarm(i).Best.Cost = swarm(i).Cost;
        end
    end
    
    % Crowding the leaders
    rep = crowdingDistanceAssignment(rep);


	% Plot Costs
	figure(1);
	plotCosts(swarm, rep);
	pause(0.01);

	% Show Iteration Information
	disp(['Iteration ' num2str(it) ': Number of Rep Members = ' num2str(numel(rep))]);

end
