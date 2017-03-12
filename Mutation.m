function [w2] = Mutation(w1, pm)
r = rand;

if r < pm
    rx = randi(size(w1, 2));
    rc = randperm(size(w1, 1));
    if w1(rc(1), rx) == 1
        w1(rc(1), rx) = 0;
        w1(rc(2), rx) = 1;
    else
        w1(find(w1(:,rx)== 1), rx) = 0;
        w1(rc(1), rx) = 1;        
    end
end
w2 = w1;
end



