function [w,q] = train1(Parameter,net,train_data,train_target)
%% parameter input
F = Parameter.F;
CR = Parameter.CR;
popsize = Parameter.popsize;
D = Parameter.D;
iter = Parameter.iter;

M = net.M;
fitness = zeros(popsize,1);
[I,J] =size(train_data); % J: the dimension of samples

%% initial population
lu = [-1 * ones(1, D); 1 * ones(1, D)];
pop = repmat(lu(1, :), popsize, 1) + rand(popsize, D) .* (repmat(lu(2, :) - lu(1, :), popsize, 1));

% objective function
for popindex = 1:popsize
    w = pop(popindex,1:J*M);
    q = pop(popindex,J*M+1:D);
    
    w=reshape(w,J,M);
    q=reshape(q,J,M);
    net.w = w;
    net.q = q;
  
    train_fit = my_DNM(train_data,net);
    cost = (train_fit - train_target).^2;
    fitness(popindex) = mean(cost);
end
% fitness = inf(popsize,1);

%%
for i = 1:iter
    % evalution function
    U = pop;
    fit_U = fitness;
    [r1, r2, r3] = getindex(popsize);
    % Implement DE/rand/1 mutation
    V = pop(r1, :) + F * (pop(r2, :) - pop(r3, :));
    
    % Check whether the mutant vector violates the boundaries or not
    V = repair(V, lu(1,1),lu(2,1));
    for j = 1:popsize
        j_rand = floor(rand * D) + 1;
        t = rand(1, D) < CR;
        t(1, j_rand) = 1;
        t_ = 1 - t;
        U(j, :) = t .* V(j, :) + t_ .* pop(j, :);
    end
    
    % objective function
    for popindex = 1:popsize
        w = U(popindex,1:J*M);
        q = U(popindex,J*M+1:D); 

        w=reshape(w,J,M);
        q=reshape(q,J,M);

        net.w = w;
        net.q = q;
        
        train_fit = my_DNM(train_data,net);
        cost = (train_fit - train_target).^2;
        fit_U(popindex) = mean(cost);
    end
    
    % Select the better one between the target vector and its trial vector
    for j = 1:popsize
        if fit_U(j, :) <= fitness(j, :)
            pop(j, :) = U(j, :);
            fitness(j, :) = fit_U(j, :);
        end
    end
    best(i) = min(fitness);
    disp(['The iteration ' num2str(i) ' error:' num2str(best(i))]);
end
%%
[~,index] = min(fitness);
best_population = pop(index,:);
w = best_population(1:J*M);
q = best_population(J*M+1:D);


w=reshape(w,J,M);
q=reshape(q,J,M);

net.w = w;
net.q = q;
end