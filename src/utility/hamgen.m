function [G,H,C] =  hamgen(r)
% HAMGEN Generates hamming generator matrix G and the check matrix H given redundancy r.

    
    % ---------------------------------------------------------------------
    %                           
    %       n = k + r + 1       
    %       => where r is number of redundant bits
    %       => where k is number of information bits
    %       => where n is number of code word bits
    %
    %       returns 
    %       G  => Generator matrix 
    %       H  => Extended Check Matrix                  
    %                                                   
    % ---------------------------------------------------------------------
    
    % ---------------------------------------------------------------------
    % Step 1:   Create matrix with dimensions r x (2^r - 1) and fill all 
    %           columns with every binary value between 1 and (2^r-1).    
    % ---------------------------------------------------------------------
    % Step 2:   Reorder the matrix such that all powers of 2 are left out
    %           (Identity matrix is appended later).
    % ---------------------------------------------------------------------- 
    
    ncols = (2.^r) - 1;
    G = [];
    
    power_of_2 = 1;
    
    for i = 1:ncols
        if ( i == power_of_2 )
            power_of_2 = power_of_2 * 2;
            continue;
        end
        b = dec2binV(i,r);
        G = [G;b];
    end    
        
    G = G';
    
    % ---------------------------------------------------------------------
    % Step 3:   Take first (2^r -1)-r columns of the matrix (all
    %           columns except those creating the identity part),
    %           and then add a zero column (overall parity-check
    %           column) to this matrix on the left
    % ---------------------------------------------------------------------
    % Step 4:   Append to an identity matrix of size rxr.
    % ---------------------------------------------------------------------
    
    
    H = [G,zeros(r,1),eye(r)];

    % ---------------------------------------------------------------------
    % Step 5:   Add row of 1s to the top of matrix
    % ---------------------------------------------------------------------
    
    C = bi2de(H');
    H = [ones(1,ncols+1);H];
    
end
% hamgen END
