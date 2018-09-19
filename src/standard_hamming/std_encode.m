function [ codewords ] = std_encode( data )
% STD_ENCODE Given data bytes, add parity bits and returns code work

    %----------------------------------------------------------------------
    %
    %   Data should be a row vector of binary data. Data size expected is 
    %   8*n.
    %   This algorithm uses (16,11,4) standard hamming coding to encode 
    %   every byte.  
    %
    %---------------------------------------------------------------------- 

    %   Obtain the check matrix and the genrator matrix 
    [G,H,C] = hamgen(4);
    
    sz = size(data);
    n = sz(2);

    %   Check if the number of bits in data stream is divisible by 8
    if (mod(n,8) ~= 0);
        disp('Invalid Data Size');
        codewords = n;
        return;
    end;

    %   To get blocks of 88 bits.
    %   88 bit blocks of linear data will be converted to a matrix of 
    %   dimensions 8x11
    n_8elevens = ceil(n/88);
    n_zeros = (n_8elevens*88) - n;

    intermediate = horzcat(data, zeros(1, n_zeros));
    intermediate = reshape(intermediate, 11, n_8elevens*8)';

    %   To obtain the parity bits
    codes = intermediate * G';
    codes = mod(codes, 2);

    %   To obtain the codewords with full parity
    codewords = [intermediate, codes];
    fullparity = ones(1,15);
    nextline = mod(codewords*fullparity',2);
    codewords = [codewords(:,1:11), nextline, codewords(:,12:15) ];
    
    temp = [];
    
    %   For tranmission purposes
    for i = 1:n_8elevens*8
        temp = [temp; codewords(i,1:8); codewords(i,9:16)];
    end
    
    codewords = temp;
end