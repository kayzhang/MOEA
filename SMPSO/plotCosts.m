%  Matlab Code for SMPSO
%
%  function plotCosts(swarm, rep)
%  Illustrate the Result in the Repository
%

function plotCosts(swarm, rep)

%     swarm_costs = [swarm.Cost];
%     subplot(1, 2, 1);
%     plot(swarm_costs(1, :), swarm_costs(2, :), 'ko');
%     xlabel('Swarm: 1^{st} Objective');
%     ylabel('Swarm: 2^{st} Objective');

    rep_costs = [rep.Cost];
%     subplot(1, 2, 2);
    plot(rep_costs(1, :), rep_costs(2, :), 'r*');
    xlabel('Repository: 1^{st} Objective');
    ylabel('Repository: 2^{st} Objective');

	grid on;

end
