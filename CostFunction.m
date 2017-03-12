function [cost] = CostFunction(centers, points, W)
    cost = 0;
    for i=1:size(W, 2)
        for j=1:size(W, 1)
            cost = cost + (W(j, i)*(abs(points(i)-centers(j))^2));
        end
    end
end

