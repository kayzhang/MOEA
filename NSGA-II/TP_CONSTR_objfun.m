function [y, cons] = TP_CONSTR_objfun(x)
	
	y = [0, 0];
	cons = [0, 0];

	y(1) = x(1);
	y(2) = (1 + x(2))/x(1);

	c = x(2) + 9*x(1) - 6;
	if(c < 0)
		cons(1) = abs(c);
	end

	c = -x(2) + 9*x(1) - 1;
	if(c < 0)
		cons(2) = abs(c);
	end
end
