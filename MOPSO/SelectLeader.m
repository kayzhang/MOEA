function leader = SelectLeader(rep, beta)

	% Grid Index of All Repository MemBer
	GI = [rep.GridIndex];

	% Occupied Cells
	OC = unique(GI);

	% Number of Particles in Occupied Cells
	N = zeros(size(OC));
	for k = 1:numel(OC)
		N(k) = numel(find(GI == OC(k)));
	end

	% Selection Probabilities
%	P = exp(-beta*N);
    P = 10./N;
	P = P/sum(P);

	% Select Cell Index
	sci = RouletteWheelSelection(P);

	% Selected Cell
	sc = OC(sci);

	% Selected Cell Members
	SCM = find(GI == sc);

	% Selected Member Index
	smi = randi([1 numel(SCM)]);

	% Selected Member
	sm = SCM(smi);

	% Leader
	leader = rep(sm);

end
