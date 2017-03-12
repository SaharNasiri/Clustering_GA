function [W2] = WCreator(centers, points, W1)
for i=1:numel(points)
    for j=1:numel(centers)
        W1(j, i) = abs(points(i) - centers(j))^2;
    end
    col = W1(:, i);
    indx = randi([1, numel(centers)]);
    col(indx, 1) = 1;
    col(1:indx-1, 1) = 0;
    col(indx+1:end, 1) = 0;
    W1(:, i) = col;
end
W2 = W1;
end

