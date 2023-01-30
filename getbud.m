function [lu o A M] = getbud(problem,D)
%get bundary information for all test functions
switch problem

        case 1

            lu = [ -100 * ones(1, D); 100 * ones(1, D)];
            o = []; A = []; M = [];

        case 2

            lu = [ -100 * ones(1, D); 100 * ones(1, D)];
            o = []; A = []; M = [];

        case 3

            lu = [ -32 * ones(1, D); 32 * ones(1, D)];
            o = []; A = []; M = [];

        case 4

            lu = [ -600 * ones(1, D); 600 * ones(1, D)];
            o = []; A = []; M = [];

        case 5

            lu = [ -5.12 * ones(1, D); 5.12 * ones(1, D)];
            o = []; A = []; M = [];

        case 6

            lu = [ -500 * ones(1, D); 500 * ones(1, D)];
            o = []; A = []; M = [];

        case 7

            lu = [ -100 * ones(1, D); 100 * ones(1, D)];
            o = []; A = []; M = [];

        case 8

            lu = [ -100 * ones(1, D); 100 * ones(1, D)];
            o = []; A = []; M = [];

        case 9

            lu = [ -50 * ones(1, D); 50 * ones(1, D)];
            o = []; A = []; M = [];

        case 10

            lu = [ -50 * ones(1, D); 50 * ones(1, D)];
            o = []; A = []; M = [];

        case 11

            lu = [ -100 * ones(1, D); 100 * ones(1, D)];
            load sphere_func_data
            A = []; M = [];

        case 12

            lu = [ -100 * ones(1, D); 100 * ones(1, D)];
            load schwefel_102_data
            A = []; M = [];

        case 13

            lu = [ -100 * ones(1, D); 100 * ones(1, D)];
            load high_cond_elliptic_rot_data
            A = [];

            if D == 2, load elliptic_M_D2,
            elseif D == 10, load elliptic_M_D10,
            elseif D == 30, load elliptic_M_D30,
            elseif D == 50, load elliptic_M_D50,
            else
                A = normrnd(0, 1, D, D); [M, r] = cGram_Schmidt(A);
            end

        case 14

            lu = [ -100 * ones(1, D); 100 * ones(1, D)];
            load schwefel_102_data
            A = []; M = [];

        case 15

            lu = [ -100 * ones(1, D); 100 * ones(1, D)];
            load schwefel_206_data
            M = [];

        case 16

            lu = [ -100 * ones(1, D); 100 * ones(1, D)];
            load rosenbrock_func_data
            A = []; M = [];

        case 17

            lu = [0 * ones(1, D); 600 * ones(1, D)];
            load griewank_func_data
            A = [];

            if D == 2, load griewank_M_D2,
            elseif D == 10, load griewank_M_D10,
            elseif D == 30, load griewank_M_D30,
            elseif D == 50, load griewank_M_D50,
            else
                M = rot_matrix(n, c);
                M = M .* (1 + 0.3 .* normrnd(0, 1, D, D));
            end

        case 18

            lu = [ -32 * ones(1, D); 32 * ones(1, D)];
            load ackley_func_data
            A = [];

            if D == 2, load ackley_M_D2,
            elseif D == 10, load ackley_M_D10,
            elseif D == 30, load ackley_M_D30,
            elseif D == 50, load ackley_M_D50,
            else
                M = rot_matrix(D, c);
            end

        case 19

            lu = [ -5 * ones(1, D); 5 * ones(1, D)];
            load rastrigin_func_data
            A = []; M = [];

        case 20

            lu = [ -5 * ones(1, D); 5 * ones(1, D)];
            load rastrigin_func_data
            A = [];
            if D == 2, load rastrigin_M_D2,
            elseif D == 10, load rastrigin_M_D10,
            elseif D == 30, load rastrigin_M_D30,
            elseif D == 50, load rastrigin_M_D50,
            else
                M = rot_matrix(D, c);
            end

end
end 