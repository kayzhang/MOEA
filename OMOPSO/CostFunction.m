% Calculate the value of the test function.

function f = CostFunction(CostFunctionType, x)

	switch CostFunctionType
        case 'ZDT1'
            n = numel(x);
            f1 = x(1);
            g = 1 + 9/(n - 1)*sum(x(2:end));
            h = 1 - sqrt(f1/g);
            f2 = g*h;
            f = [f1; f2];
        case 'ZDT2'
            n = numel(x);
            f1 = x(1);
            g = 1 + 9/(n - 1)*sum(x(2:end));
            h = 1 - (f1/g)^2;
            f2 = g*h;
            f = [f1; f2];
        case 'ZDT3'
            n = numel(x);
            f1 = x(1);
            g = 1 + 9/(n - 1)*sum(x(2:end));
            h = 1 - sqrt(f1/g) - f1/g*sin(10*pi*f1);
            f2 = g*h;
            f = [f1; f2];
        case 'ZDT4'
            n = numel(x);
            f1 = x(1);
            g = 1 + 10*(n - 1);
            for i = 2:10
                g = g + x(i)^2 - 10*cos(4*pi*x(i));
            end
            h = 1 - sqrt(f1/g);
            f2 = g*h;
            f = [f1; f2];
        case 'ZDT6'
            n = numel(x);
            f1 = x(1);
            g = 1 + 9*(sum(x(2:end))/(n - 1))^0.25;
            h = 1 - (f1/g)^2;
            f2 = g*h;
            f = [f1; f2];
        case 'SCH'
            n = numel(x);
            f1 = x(1)^2;
            f2 = (x(1) - 2)^2;
            f = [f1; f2];
        case 'KUR'
            n = numel(x);
            f1 = 0;
            f2 = 0;
            for i = 1:n-1
                f1 = f1 - 10*exp(-0.2*sqrt(x(i)^2 + x(i+1)^2));
            end
            for i = 1:n
                f2 = f2 + abs(x(i))^0.8 + 5*sin(x(i)^3);
            end
            f = [f1; f2];
        case 'Test3'
            n = numel(x);
            f1 = x(1);
            g = 11 + x(2)^2 - 10*cos(2*pi*x(2));
            if f1 <= g
                h = 1 - sqrt(f1/g);
            else
                h = 0;
            end
            f2 = g*h;
            f = [f1; f2];
        end

end
