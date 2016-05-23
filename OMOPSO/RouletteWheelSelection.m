% Select the Cell Index of the Leader Particle

function i = RouletteWheelSelection(P)

	r = rand;

	C = cumsum(P);	% the Cumulative Sum of P

	i = find(r <= C, 1, 'first');

end
