function V = repair(V, lb,ub)

[NP, D]  = size(V);

% xl = repmat(lb, NP, 1);
% xu = repmat(ub, NP, 1);
xl=lb;
xu=ub;

% if any variable of the mutant vector violates the lower bound
pos = V < xl;
V(pos) = 2 .* xl - V(pos);
pos_ = V(pos) > xu; 
V(pos(pos_)) = xu;

% if any variable of the mutant vector violates the upper bound
pos = V > xu;
V(pos) = 2 .* xu - V(pos);
pos_ = V(pos) < xl; 
V(pos(pos_)) = xl;