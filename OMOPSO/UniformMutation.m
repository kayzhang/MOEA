% Uniform Mutation

function particle = UniformMutation(particle, pm, VarMin, VarMax, b)

    nVar = numel(particle);
    for i = 1:nVar
        if rand < pm
%             temp = (rand - 0.5)*b;
%             temp = temp + particle(i);
temp = VarMin(i) + rand*(VarMax(i) - VarMin(i));
            if temp < VarMin(i)
                temp = VarMin(i);
            elseif temp > VarMax(i)
                temp = VarMax(i);
            end
            particle(i) = temp;
        end
        
    end
