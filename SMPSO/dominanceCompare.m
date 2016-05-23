%  Matlab Code for SMPSO
%
%  function f = dominanceCompare(x, y, nCons)
%  Definition of Domination between two particles
% 

function b = dominanceCompare(x, y, nCons)

	xCost = x.Cost;
	yCost = y.Cost;
    
    if nCons ~= 0
        overall1 = x.OverallConstraintViolation;
        overall2 = y.OverallConstraintViolation;
        % x and y are both infeasible
        if (overall1 < 0) && (overall2 < 0)
            if overall1 > overall2
                b = 1;
            elseif overall1 < overall2
                b = -1;
            else
                b = 0;
            end
        % x is feasible and y is inseasible
        elseif (overall1 == 0) && (overall2 < 0)
            b = 1;
        % x is infeasible and y is feasible
        elseif (overall1 < 0) && (overall2 == 0)
            b = -1;
        % x and y are both feasible
        else
            b = 0;
        end
        
        if b == 0
            if all(xCost <= yCost) && any(xCost < yCost)
                b = 1;
                elseif all(xCost >= yCost) && any(xCost > yCost)
                b = -1;
            else
                b = 0;
            end
        end
    else
        if all(xCost <= yCost) && any(xCost < yCost)
            b = 1;
        elseif all(xCost >= yCost) && any(xCost > yCost)
            b = -1;
        else
            b = 0;
        end
    end
    
end
