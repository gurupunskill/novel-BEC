function [ codewords ] = nov_encode( data )
%   NOV_ENCODE Given data bytes, add parity bits and returns code word
%   after interleaving

    %----------------------------------------------------------------------
    %
    %   Data should be a row vector of binary data. Data size expected is 
    %   8*n.
    %   This algorithm uses (16,11,4) standard hamming coding to encode 
    %   every byte. 
    %
    %   The novelty in the method employed is not in the hamming encoding 
    %   and decoding but rather in how the data is transmitted. 
    %
    %----------------------------------------------------------------------

    %   Obtain the check matrix and the genrator matrix 
    
    [G,H,C] = hamgen(4);
    
    sz = size(data);
    n_bits_of_data = sz(2);

    %   Check if the number of bits in data stream is divisible by 8
    
    if (mod(n_bits_of_data,8) ~= 0);
        disp('Invalid Data Size');
        codewords = n_bits_of_data;
        return;
    end;
    
    %   To get blocks of 88 bits.
    %   88 bit blocks of linear data will be converted to a matrix of 
    %   dimensions 8x11
    
    n_8elevens = ceil(n_bits_of_data/88);
    n_zeros = (n_8elevens*88) - n_bits_of_data;

    intermediate = horzcat(data, zeros(1, n_zeros));
    intermediate = reshape(intermediate, 11, n_8elevens*8)';

    %   To obtain the parity bits
    
    codes = intermediate * G';
    codes = mod(codes, 2);

    %   To obtain the codewords without full parity
    
    codewords = [intermediate, codes];
    
    %   To obtain the codewords with full parity
    fullparity = ones(1,15);
    nextline = mod(codewords*fullparity',2);
    codewords = [codewords(:,1:11), nextline, codewords(:,12:15) ];
    
    %   To interleave the data block.
    %   Row by row transmission of data takes place.
    %   For this reason the number of columns must be 8.
    
    codewords = interleave(codewords);

end