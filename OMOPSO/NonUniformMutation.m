% Non-uniform Mutation

function particle = NonUniformMutation(particle, pm, VarMin, VarMax, it, MaxIt, b)
    
    nVar = numel(particle);
    for i = 1:nVar
        if rand < pm
            if rand <= 0.5
                y = VarMax(i) - particle(i);
                delta = y*(1 - rand^((1 - it/MaxIt)^b));
                temp = particle(i) + delta;
            else
                y = particle(i) - VarMin(i);
                delta = y*(1 - rand^((1 - it/MaxIt)^b));
                temp = particle(i) - delta;
            end
            if temp < VarMin(i)
                temp = VarMin(i);
            elseif temp > VarMax(i)
                temp = VarMax(i);
            end
            particle(i) = temp;
        end
    end
    
end
      