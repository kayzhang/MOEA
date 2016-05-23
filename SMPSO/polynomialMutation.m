%  Matlab Code for SMPSO
%
%  function particle = polynomialMutation(particle, pm, varMin, varMax,
%  mutationPara, eta_m)
%  Polynomial Mutation
%
%  In the new hybrid polynomial mutation, the disruptions level can be
%  quantified using different p(pop.mutationPara) values. It works as
%  follows: with probability 1-p use the non-highly disruptive polynomial
%  mutation and with probability p use the highly disruptive version. When
%  p=0.0 then only the non-highly disruptive polynomial mutation is used.
%  When setting p=1.0 then only the highly disruptive is used. The best p
%  value can be determined after experimental evaluation of different p
%  values for various algorithms and problems.
%
%  References
%  [1]M. Hamdan, ¡°On the Disruption-Level of Polynomial Mutation for
%  Evolutionary Multi-Objective Optimisation Algorithms,¡± Comput. Inform.,
%  vol. 29, no. 5, pp. 783¨C800, 2010.

function particle = polynomialMutation(particle, pm, varMin, varMax, mutationPara, eta_m)

    nVar = numel(particle);
    for i = 1:nVar
        if rand <= pm
            delta1 = (particle(i) - varMin(i))/(varMax(i) - varMin(i));
            delta2 = (varMax(i) - particle(i))/(varMax(i) - varMin(i));
            r = rand;
            if rand > mutationPara
                delta = min(delta1, delta2);
            elseif r <= 0.5
                delta = delta1;
            else
                delta = delta2;
            end
            if r <= 0.5
				deltaq = (2*r + (1 - 2*r)*(1 - delta)^(eta_m + 1))^(1/(eta_m + 1)) - 1;
			else
				deltaq = 1 - (2*(1 - r) + 2*(r - 0.5)*(1 - delta)^(eta_m + 1))^(1/(eta_m + 1));
            end
            particle(i) = particle(i) + deltaq*(varMax(i) - varMin(i));
            if particle(i) < varMin(i)
                particle(i) = varMin(i);
            end
            if particle(i) > varMax(i)
                particle(i) = varMax(i);
            end
        end
    end

end
