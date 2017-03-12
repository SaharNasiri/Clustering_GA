function [c1, c2] = Crossover(p1, p2)

c1 = zeros(size(p1, 1), size(p1, 2));
c2 = zeros(size(p2, 1), size(p2, 2));

temp = randperm(size(p1, 2));
indx1 = min(temp(1), temp(2));
indx2 = max(temp(1), temp(2));

c1(:, 1:indx1-1) = p1(:, 1:indx1-1);
c1(:, indx1:indx2) = p2(:, indx1:indx2);
c1(:, indx2+1:end) = p1(:, indx2+1:end);
c2(:, 1:indx1-1) = p2(:, 1:indx1-1);
c2(:, indx1:indx2) = p1(:, indx1:indx2);
c2(:, indx2+1:end) = p2(:, indx2+1:end);
end

