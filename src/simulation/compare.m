function [all_data] = compare(min,max,step,count)
%COMPARE calls simulate.m over defined parameters

    %----------------------------------------------------------------------
    %
    %   This function's purpose is to provide us with data to compare the two
    %   hamming code implementations. It calls simulate over the defined
    %   input parameters.
    %   It returns a large matrix that records the dataset size and all
    %   returned parameters of simulate.m
    %
    %----------------------------------------------------------------------
    
    all_data = [];
    for i = min:step:max
        for j = 1:count
            [a,b,c,d,e,f] = simulate(i);
            all_data = [all_data; i, [a,b,c,d,e,f]];
        end
        fprintf('Current Step ==> %d\n', i)
    end
    
end