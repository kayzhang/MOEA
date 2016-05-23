%  Matlab Code for SMPSO
%
%  function pop = computeSpeed(pop, rep, weightMin, weightMax, r1Min, ...
%  r1Max, r2Min, r2Max, c1Min, c1Max, c2Min, c2Max, deltaMin, deltaMax)
%  Compute the Speed
%

function swarm = computeSpeed(swarm, rep, weightMin, weightMax, r1Min, r1Max, r2Min, ...
    r2Max, c1Min, c1Max, c2Min, c2Max, deltaMin, deltaMax)

    nVar = numel(swarm(1).Position);
    swarmSize = numel(swarm);
    nRep = numel(rep);
    
    for i = 1:swarmSize
        
        % Select a global best for calculate the speed of particle i
        one = randi(nRep);
        two = randi(nRep);
        if rep(one).Distance > rep(two).Distance
            leader = rep(one);
        else
            leader = rep(two);
        end
        
        % Paras for velocity equation
        W = weightMax;
        % W = -(((WMax-WMin)*it/MaxIt;
        % We can also use adaptive inertia weight W here.
        C1 = c1Min + rand*(c1Max - c1Min);
        C2 = c2Min + rand*(c2Max - c2Min);
        r1 = r1Min + rand*(r1Max - r1Min);
        r2 = r2Min + rand*(r2Max - r2Min);
        
        % Compute the velocity of each particle
		swarm(i).Velocity = W*swarm(i).Velocity + C1*r1*(swarm(i).Best.Position - swarm(i).Position) + C2*r2*(leader.Position - swarm(i).Position);
        
        % Constriction Coefficient
        if C1+C2>4
            rho = C1 + C2;
        else
            rho = 0;
        end
        swarm(i).Velocity = swarm(i).Velocity.*(2/(2 - rho - sqrt(rho^2 - 4*rho)));
        
        % VelocityConstriction
        for k = 1:nVar
            if swarm(i).Velocity(k) > deltaMax(k)
                swarm(i).Velocity(k) = deltaMax(k);
            elseif swarm(i).Velocity < deltaMin(k)
                swarm(i).Velocity(k) = deltaMin(k);
            else
                % Do nothing
            end
        end
        
    end
    
end
