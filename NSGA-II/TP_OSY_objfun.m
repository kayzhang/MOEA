function [y, cons] = TP_CONSTR_objfun(x)
	
	y = [0, 0];
	cons = [0, 0, 0, 0, 0, 0];

	y(1) = -(25*(x(1)-2)^2 + (x(2)-2)^2 + (x(3)-1)^2 + (x(4)-4)^2 + (x(5)-1)^2);
    y(2) = x(1)^2 + x(2)^2 + x(3)^2 + x(4)^2 + x(5)^2 + x(6)^2;

    constraint(1) = (x(1) + x(2))/2 - 1;
    constraint(2) = (6 - x(1) - x(2))/6;
    constraint(3) = (2 - x(2) + x(1))/2;
    constraint(4) = (2 - x(1) + 3*x(2))/2;
    constraint(5) = (4 - (x(3) - 3)^2 - x(4))/4;
    constraint(6) = ((x(5) - 3)^2 + x(6) - 4)/4;
    
    for i = 1:6
        if constraint(i) < 0
            cons(i) = constraint(i);
        end
    end
end
