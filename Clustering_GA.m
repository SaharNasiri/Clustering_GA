clc; clear all; close all;

%-------Problem Definition---------%

load('D:\Sahar\QIAU\Evolutionary Process\Clustering-GA\Points.mat');
X = X(1, 1:1000);
nX = numel(X);
C = [100, 400, 800];
W = zeros(numel(C), numel(X));

costFunc = @(W) CostFunction(C, X, W);

%-------Parameters---------%

npop = 50; %No. of population
pc = 0.6; %Crossover Possibility
nc = 2*round(pc*npop/2); %No. of population created by crossover
pm = 0.4; %Mutation Possibility
nm = round(pm*npop);
mu = [];
%mu = 0.3;

%-------Initialization---------%
for j=1:50
    
    mu = [mu rand];
    
    empty_indv.w = [];
    empty_indv.cost = [];
    pop = repmat(empty_indv, npop, 1);
    
    
    for i=1:npop
        pop(i).w = WCreator(C, X, W);
        pop(i).cost = costFunc(pop(i).w);
    end
    
    %sort
    Costs = [pop.cost];
    [temp, sortOrder] = sort(Costs);
    pop = pop(sortOrder);
    bestSol = pop(1);
    bestCost = [];
    meanCost = [];
    varCost = [];
    
    %-------Main Loop---------%
    
    count = 0;
    it = 0;
    while true
        it = it + 1;
        Costs = [pop.cost];
        %Crossover
        popc = repmat(empty_indv, nc, 2);
        
        for k=1:nc
            i1 = RWS(1./Costs); %The problem is minimize
            i2 = RWS(1./Costs);
            
            p1 = pop(i1);
            p2 = pop(i2);
            
            [popc(k, 1).w, popc(k, 2).w] = Crossover(p1.w, p2.w);
            popc(k, 1).cost = costFunc(popc(k, 1).w);
            popc(k, 2).cost = costFunc(popc(k, 2).w);
        end
        popc = popc(:);
        
        %Mutation
        popm = repmat(empty_indv, nm, 1);
        for k=1:nm
            i = randi([1 npop]);
            p = pop(i);
            popm(k).w = Mutation(p.w, mu(j));
            popm(k).cost = costFunc(popm(k).w);
        end
        
        %Merge
        pop = [popc; popm];
        Costs = [pop.cost];
        [temp, sortOrder] = sort(Costs);
        pop = pop(sortOrder);
        
        %Trunacte
        pop = pop(1:npop);
        bestSol = pop(1);
        bestCost(it) = bestSol.cost;
        %disp(['Iteration: ' num2str(it) ' Best Cost: ' num2str(bestCost(it))]);
        if it > 1
            if bestCost(it - 1) == bestCost(it);
                count = count + 1;
            else
                count = 0;
            end
        end
        if count > 10
            break;
        end
        
    end
    
    %-------Result---------%
%     
%         figure;
%         plot(bestCost);
%         xlabel('Iteration');
%         ylabel('Cost');
%         hold on;
%     
%     
%         figure;
%         x=find(bestSol.w(1,:)==1);
%         plot(X(x),'b*');
%         x=find(bestSol.w(2,:)==1);
%         hold on; plot(X(x),'r*');
%         x=find(bestSol.w(3,:)==1);
%         hold on; plot(X(x),'g*');
    
    
    meanCost = [meanCost mean(bestCost)];
    
    varCost = [varCost var(bestCost)];
    
end

figure;
plot(mu, meanCost,'r*');
xlabel('mu');
ylabel('Mean/ Varians');
hold on
plot(mu, varCost, 'b*');

disp(['Mean of Costs: ' num2str(mean(meanCost))]);
disp(['Var of Costs: ' num2str(mean(varCost))]);




