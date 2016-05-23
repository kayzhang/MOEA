function pop = ndsort(opt, pop)

	%*************************************************************************
	% 1. Initialize variables
	%   indi.np: number of individuals which dominate this individual
	%   indi.sp(:): a set of individuals that this individual dominate
	%*************************************************************************
	N = length(pop);
	ind = repmat(struct('np', 0, 'sp', []), [1, N]);

	for i = 1:N
		pop(i).rank = 0;
		pop(i).distance = 0;
	end

	%*************************************************************************
	% 2. fast non-dominated sort
	%*************************************************************************
	% Calculate the domination matrix for improving the efficiency.
	nViol = vertcat(pop(:).nViol);
	violSum = vertcat(pop(:).violSum);
	obj = vertcat(pop(:).obj);
	numObj = opt.numObj;

	% Calculate the domination maxtir which specified the domination
	% releation between two individual using constrained-domination.
	domMat = zeros(N, N);

	for p = 1:N-1
	    for q = p+1:N
	        %*************************************************************************
	        % 1. p and q are both feasible
	        %*************************************************************************
	        if(nViol(p) == 0 && nViol(q)==0)
	            pdomq = false;
	            qdomp = false;
	            for i = 1:numObj
	                if( obj(p, i) < obj(q, i) )
	                    pdomq = true;
	                elseif(obj(p, i) > obj(q, i))
	                    qdomp = true;
	                end
	            end

	            if( pdomq && ~qdomp )
	                domMat(p, q) = 1;
	            elseif( ~pdomq && qdomp )
	                domMat(p, q) = -1;
	            end
	        %*************************************************************************
	        % 2. p is feasible, and q is infeasible
	        %*************************************************************************
	        elseif(nViol(p) == 0 && nViol(q)~=0)
	            domMat(p, q) = 1;
	        %*************************************************************************
	        % 3. q is feasible, and p is infeasible
	        %*************************************************************************
	        elseif(nViol(p) ~= 0 && nViol(q)==0)
	            domMat(p, q) = -1;
	        %*************************************************************************
	        % 4. p and q are both infeasible
	        %*************************************************************************
	        else
	            if(violSum(p) < violSum(q))
	                domMat(p, q) = 1;
	            elseif(violSum(p) > violSum(q))
	                domMat(p, q) = -1;
	            end
	        end

			% Compute np and sp of each indivudal
	        if(domMat(p, q) == 1)			% p dominate q
	        	ind(q).np = ind(q).np + 1;
	        	ind(p).sp = [ind(p).sp q];
	        elseif(domMat(p, q) == -1)		% q dominate p
	        	ind(p).np = ind(p).np + 1;
				ind(q).sp = [ind(q).sp , p];
			end
	    end
    end

	front(1).f = [];

	for i = 1:N
		if( ind(i).np == 0 )
			pop(i).rank = 1;
			front(1).f = [front(1).f, i];
		end
	end

	fid = 1;
	while( ~isempty(front(fid).f) )
		Q = [];
		for p = front(fid).f
			for q = ind(p).sp
				ind(q).np = ind(q).np -1;
				if( ind(q).np == 0 )
					pop(q).rank = fid+1;
					Q = [Q q];
				end
			end
		end
		fid = fid + 1;
		front(fid).f = Q;
	end
	front(fid) = []; 	% delete the last empty front set

	%*************************************************************************
	% 3. Calculate the distance
	%*************************************************************************
	for fid = 1:length(front)
		idx = front(fid).f;
		frontPop = pop(idx);		% frontPop : individuals in front fid
    
		numInd = length(idx);		% nInd : number of individuals in current front

		obj = vertcat(frontPop.obj);
		obj = [obj, idx'];			% objctive values are sorted with individual ID
		for m = 1:numObj 
			obj = sortrows(obj, m);

			colIdx = numObj + 1;
			pop( obj(1, colIdx) ).distance = Inf;         % the first one
			pop( obj(numInd, colIdx) ).distance = Inf;    % the last one
        
			minobj = obj(1, m);         % the maximum of objective m
			maxobj = obj(numInd, m);    % the minimum of objective m
        
			for i = 2:(numInd-1)
				id = obj(i, colIdx);
				pop(id).distance = pop(id).distance + (obj(i+1, m) - obj(i-1, m)) / (maxobj - minobj);
			end
		end
	end
end
