%  Matlab Code for SMPSO
%
%  function rep = leadersAdd(particle, rep, repSize, nCons)
%  Add a particle to Rep if it's non-dominated
%

function rep = leadersAdd(particle, rep, repSize, nCons)

    nRep = numel(rep);
    if nRep == 0
        rep = [rep; particle];
        return;
    else
        for i = nRep:-1:1
            flag = dominanceCompare(particle, rep(i), nCons);
            if flag == -1       % particle is worse
                return;
            elseif flag == 1    % particle is better
                rep(i) = [];
            elseif particle.Position == rep(i).Position     % particle is equal
                return;
            else    % none is better or worse
                % do nothing
            end
        end
    end
    
    % Insert the particle into the archive
    rep = [rep; particle];
    
    % Check if the archive is full
    if (numel(rep) > repSize)
        rep = crowdingDistanceAssignment(rep);
        distance = [rep.Distance];
        [temp, Index] = sort(distance);
        rep(Index(1)) = [];
    end
    
end
    