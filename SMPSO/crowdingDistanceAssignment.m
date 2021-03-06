%  Matlab Code for SMPSO
%
%  function rep = crowdingDistanceAssignmeng(rep)
%  Calculate the Crowding Distance of the Repository
%
%  References
%  [1]K. Deb, A. Pratap, S. Agarwal, and T. Meyarivan, ��A fast and elitist
%  multiobjective genetic algorithm: NSGA-II,�� IEEE Transactions on
%  Evolutionary Computation, vol. 6, no. 2, pp. 182�C197, Apr. 2002.
%

function rep = crowdingDistanceAssignment(rep)

    nRep = numel(rep);      % Number of Particles in Rep
    M = numel(rep(1).Cost); % Number of the Objectives
    cost = [rep.Cost];
    distance = zeros(M, nRep);
    for i = 1:M
        [sorted, index] = sort(cost(i, :));
        f_min = sorted(1);
        f_max = sorted(end);
        distance(i, index(1)) = Inf;
        distance(i, index(end)) = Inf;
        for j = 1:nRep
            sorted(j) = rep(index(j)).Cost(i);
        end
        for j = 2:nRep-1
            if f_max - f_min == 0
                distance(i, index(j)) = Inf;
            else
                distance(i, index(j)) = (sorted(j+1) - sorted(j-1))/(f_max - f_min);
            end
        end
    end
    for i = 1:nRep
        rep(i).Distance = sum(distance(:, i));
    end

end
