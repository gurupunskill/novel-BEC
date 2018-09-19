function [ interleaved_codewords ] = interleave( codewords )
% INTERLEAVE Interleaves codewords using interleaving method suggested in
% the paper

    codewords = codewords';
    n_cols = size(codewords, 2);
    interleaved_codewords = [];
    
    %   To get the number of columns as 8 always
    for i = 1:8:n_cols
        interleaved_codewords = [interleaved_codewords; codewords(:,i:i+7)];
    end
end

