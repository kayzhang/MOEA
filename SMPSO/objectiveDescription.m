%  Matlab Code for SMPSO
%
%  function [nVar, nCons, VarMin, VarMax] = ObjectiveDescription(x)
%  Get the Data Structure of Objective Functions
%

function [nVar, nCons, varMin, varMax] = objectiveDescription(x)

    switch x
        case 'ZDT1'
            nVar = 30;              % Number of Decision Variables
            nCons = 0;
            varMin = zeros(1, 30);  % Upper Boundary of Decision Variables
            varMax = ones(1, 30);   % Lower Boundary of Decision Variables
        case 'ZDT2'
            nVar = 30;
            nCons = 0;
            varMin = zeros(1, 30);
            varMax = ones(1, 30);
        case 'ZDT3'
            nVar = 30;
            nCons = 0;
            varMin = zeros(1, 30);
            varMax = ones(1, 30);
        case 'ZDT4'
            nVar = 10;
            nCons = 0;
            varMin = [0, -5*ones(1, 9)];
            varMax = [1, 5*ones(1, 9)];
        case 'ZDT6'
            nVar = 10;
            nCons = 0;
            varMin = zeros(1, 10);
            varMax = ones(1, 10);
        case 'SCH'
            nVar = 1;
            nCons = 0;
            varMin = -1000;
            varMax = 1000;
        case 'KUR'
            nVar = 3;
            nCons = 0;
            varMin = -5*ones(1, 3);
            varMax = 5*ones(1, 3);
        case 'Test3'
            nVar = 2;
            nCons = 0;
            varMin = [0 -30];
            varMax = [1 30];
        case 'SRN'
            nVar = 2;
            nCons = 2;
            varMin = [-20 -20];
            varMax = [20 20];
        case 'OSY'
            nVar = 6;
            nCons = 6;
            varMin = [0 0 1 0 1 0];
            varMax = [10 10 5 6 5 10];
    end

end
