function [r1, r2, r3]  = getindex(popsize)

r1 = zeros(1, popsize);
r2 = zeros(1, popsize);
r3 = zeros(1, popsize);

for i = 1 : popsize
    
    sequence = 1 : popsize;
    sequence(i) = [];

    temp = floor(rand * (popsize - 1)) + 1;
    r1(i) = sequence(temp);
    sequence(temp) = [];

    temp = floor(rand * (popsize - 2)) + 1;
    r2(i) = sequence(temp);
    sequence(temp) = [];

    temp = floor(rand * (popsize - 3)) + 1;
    r3(i) = sequence(temp);

end