% Get the data structure of objective function.

function [nVar, VarMin, VarMax] = ObjectiveDescription(x)

	switch x
        case 'ZDT1'
            nVar = 30;	% Number of Decision Variables
            VarMin = zeros(1, 30);
            VarMax = ones(1, 30);
        case 'ZDT2'
            nVar = 30;
            VarMin = zeros(1, 30);
            VarMax = ones(1, 30);
        case 'ZDT3'
            nVar = 30;
            VarMin = zeros(1, 30);
            VarMax = ones(1, 30);
        case 'ZDT4'
            nVar = 10;
            VarMin = [0, -5*ones(1, 9)];
            VarMax = [1, 5*ones(1, 9)];
        case 'ZDT6'
            nVar = 10;
            VarMin = zeros(1, 10);
            VarMax = ones(1, 10);
        case 'SCH'
            nVar = 1;
            VarMin = [-1000];
            VarMax = [1000];
        case 'KUR'
            nVar = 3;
            VarMin = -5*ones(1, 3);
            VarMax = 5*ones(1, 3);
        case 'Test3'
            nVar = 2;
            VarMin = [0 -30];
            VarMax = [1 30];
        end

end
