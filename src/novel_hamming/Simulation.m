%   Script to simulate the sending of information bits across a noisy medium

clc;

%   First create the data that we want to send across the medium

data_stream = rand(1,88);
data_stream = (data_stream(1,:) > 0.5);

%   Encode this data using novel encoder -> returns codewords

codewords = nov_encode(data_stream);
n_rows = size(codewords,1);

%--------------------------------------------------------------------------
%   In this codeword array the data is transmitted row by row according to 
%   the novel method
%   Burst errors are then induced in these rows.
%--------------------------------------------------------------------------

transmitted_data = [];

%   This array will contain the number of errors in each row
n_errors = [];

for i = 1:n_rows
    temp = codewords(i,:);
    
    %   Find position for burst error to start -> between 1 and 8
    %   Find number of bits in burst error
    
    if (rand() <= 0.3)
        if (rand() <= 0.7)
            pos = randi([1 8]);
            n_bits = 1;
            temp(1,pos) = ~temp(1,pos);
        else
            pos = randi([1 8]);
            n_bits = randi([1 (8-pos)]);
            for j = pos:(pos+n_bits)
                temp(1,j) = ~temp(1,j) ;
            end
        end
    else
        n_bits = 0;
        pos = 0;
    end
    
    transmitted_data = [transmitted_data ; temp];
    n_errors = [n_errors ; [n_bits, pos]];
end

%--------------------------------------------------------------------------
%
%   Now the recieved data has to be decoded and the syndrome has to be
%   found so as to detect and correct errors. nov_decode function is
%   called.
%
%--------------------------------------------------------------------------

[corrected_data , n_single_bit_errors , n_corrupted_words] = nov_decode(transmitted_data);










