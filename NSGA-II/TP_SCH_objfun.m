function [y, cons] = TP_SCH_objfun(x)
	
	y = [0, 0];
	cons= [];

	y(1) = x^2;
	y(2) = (x - 1)^2;
end
