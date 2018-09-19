function [ actual_single_errors, actual_burst_errors, std_detected, std_corrected, nov_detected, nov_corrected ] = simulate(data_size)
%Function to simulate the sending of information bits across a noisy medium
    
    
    %   First create the data that we want to send across the medium
    data_stream = rand(1,88*data_size) > 0.5;
    
    %   Encode this data using novel encoder and standard encoder -> returns codewords
    nov_codewords = nov_encode(data_stream);
    nov_n_rows = size(nov_codewords,1);
    
    std_codewords = std_encode(data_stream);
    std_n_rows = size(std_codewords,1);
    
    if (nov_n_rows ~= std_n_rows)
        disp('Unexpected encoding error')
        return;
    else
        n_rows = nov_n_rows;
    end
    
    %--------------------------------------------------------------------------
    %   In the codeword array the data is transmitted row by row.
    %   Burst errors are then induced in these rows.
    %
    %   A major consideration that we undertook was simulating errors based
    %   on probability. An error has a 30% chance of occuring. Among this
    %   30%, a single bit error has a 70% chance (21% overall) and a burst
    %   error has a 30% chance (9% overall). The number of bits changed
    %   during burst is also attributed to a uniform probability between 1
    %   and 8.
    %--------------------------------------------------------------------------
    
    std_transmitted_data = [];
    nov_transmitted_data = [];
    
    %   This array will contain the number of errors in each row
    n_errors = [];
    
    for i = 1:n_rows
        temp1 = std_codewords(i,:);
        temp2 = nov_codewords(i,:);
    
        %   Find position for burst error to start -> between 1 and 8
        %   Find number of bits in burst error
    
        if (rand() <= 0.3)
            pos = randi([1 8]);
            if (rand() <= 0.7)
                n_bits = 1;
                temp1(1,pos) = ~temp1(1,pos);
                temp2(1,pos) = ~temp2(1,pos);
            else
                n_bits = randi([1 (9-pos)]);
                for j = pos:(pos+n_bits-1)
                    temp1(1,j) = ~temp1(1,j);
                    temp2(1,j) = ~temp2(1,j);
                end
            end
        else
            n_bits = 0;
            pos = 0;
        end
    
        std_transmitted_data = [std_transmitted_data ; temp1];
        nov_transmitted_data = [nov_transmitted_data ; temp1];
        n_errors = [n_errors ; n_bits];
    end

    %--------------------------------------------------------------------------
    %
    %   Now the recieved data has to be decoded and the syndrome has to be
    %   found so as to detect and correct errors. nov_decode function is
    %   called.
    %   Number of single bit and burst errors induced are calculated and
    %   returned
    %
    %--------------------------------------------------------------------------

    
    [nov_corrected_data, nov_corrected, nov_detected] = nov_decode(nov_transmitted_data);
    [std_corrected_data, std_corrected, std_detected] = std_decode(std_transmitted_data);

    actual_single_errors = sum(n_errors == 1);
    no_zero = n_errors ~= 0;
    actual_burst_errors  = sum((no_zero ~= 1)); 

end










