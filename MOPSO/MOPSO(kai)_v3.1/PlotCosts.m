function PlotCosts(pop, rep)

	pop_costs = [pop.Cost];
	subplot(1, 2, 1);
    plot(pop_costs(1, :), pop_costs(2, :), 'ko');
% 	hold on;

	rep_costs = [rep.Cost];
	subplot(1, 2, 2);
    plot(rep_costs(1, :), rep_costs(2, :), 'r*');

	xlabel('1^{st} Objective');
	ylabel('2^{st} Objective');

	grid on;

% 	hold off;

end
