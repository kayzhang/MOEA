%  Matlab Code for SMPSO
%
%  function total = evaluateConstraints(costFunctionType, x, nCons)
%  Compute the Overall Constraint Violation
%

function total = evaluateConstraints(costFunctionType, x, nCons)

    total = 0;
    switch costFunctionType
        case 'SRN'
            constraint(1) = 1 - (x(1)^2 + x(2)^2)/225;
            constraint(2) = (3*x(2) - x(1))/10 - 1;
        case 'OSY'
            constraint(1) = (x(1) + x(2))/2 - 1;
            constraint(2) = (6 - x(1) - x(2))/6;
            constraint(3) = (2 - x(2) + x(1))/2;
            constraint(4) = (2 - x(1) + 3*x(2))/2;
            constraint(5) = (4 - (x(3) - 3)^2 - x(4))/4;
            constraint(6) = ((x(5) - 3)^2 + x(6) - 4)/4;
    end
    
    for i = 1:nCons
        if constraint(i) < 0
            total = total + constraint(i);
        end
    end
    
end
         