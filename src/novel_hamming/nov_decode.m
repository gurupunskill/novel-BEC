function [corrected_data, n_single_bit_error, n_corrupted_codewords] = nov_decode(received_data)
%NOV_DECODE decodes a (16,11,4) extended codeword to give dataword

    %--------------------------------------------------------------------------------
    % 
    %   NOV_DECODE decodes a (16,11,4) codeword to give dataword
    %   Remove parity bits and return the dataword 
    %   The checkMatrix is obtained using the first algorithm in the paper.
    %   It corrects the received data stream and returns the corrected data
    %   stream. (Can only correct single bit errors).
    %   
    %   corrected_data          => The data stream that has been corrected 
    %   n_single_bit_error      => The number of single bit errors(all are corrected)
    %   n_corrupted_codewords   => The number of corrupted codewords(number
    %                              of words where error was detected)
    %
    %--------------------------------------------------------------------------------

    %----------------------------------------------------------------------------
    %   Step 1: Reorganizing the encoded data blockto get the actual codewords
    %   The recieved encoded codeword is deinterleaved.
    %   (check deinterleave.m for more information)
    %----------------------------------------------------------------------------

    received_data = deinterleave(received_data);

    %----------------------------------------------------------------------------
    %   Step 2: The check Matrix is obtained using the first algorithm in the paper. 
    %----------------------------------------------------------------------------

    [G,H,C] = hamgen(4);

    %----------------------------------------------------------------------------
    %   Step 3: The syndrome is calculated. 
    %----------------------------------------------------------------------------

    syndrome = received_data*H';
    syndrome = mod(syndrome,2);
    
    %----------------------------------------------------------------------------
    %
    %   *   First column of syndrome is the overall parity bit.
    %
    %   *   Next 4 columns are the error bits.
    %
    %   *   The decimal representation of these bits have to be found and
    %       checked with the check codes from the check matrix H.
    %
    %   *   The position ofthe corresponding check code in H tells us the
    %       position of the single bit error in the code word.
    %
    %----------------------------------------------------------------------------
    
    overall_parity = syndrome( : , 1);
    syndrome_2 = syndrome( : , 2:end);
    
    syndrome_2 = bi2de(syndrome_2);
    
    %------------------------------------------------------------------------------------------------
    %   SECDED detection and correction scheme    
    %------------------------------------------------------------------------------------------------
    %   Case    # Errors      Overall parity    Syndrome                Type
    %    1          0             0 (even)          0                   no error
    %    2          1             1 (odd)           0                   overall parity bit is in error
    %    3          1             1 (odd)           !0                  single error (correctable via syndrome)
    %    4          >1            1 (odd)           !0 && not in H      multiple errors
    %    5          >1            0 (even)          !=0                 multiple errors
    %------------------------------------------------------------------------------------------------
    
    error_positions = [];
    n_corrupted_codewords = 0;
    
    %    -1 => multiple errors || rest => single bit error
    
    for i = 1:size(syndrome_2,1)
        position = 0;
        if (overall_parity(i) == 1)
            position = find(C==syndrome_2(i));
            if (isempty(position))
                position = -1;
            end
            n_corrupted_codewords = n_corrupted_codewords + 1;    
        else
            if(syndrome_2(i) ~= 0)
                position = -1;
                n_corrupted_codewords = n_corrupted_codewords + 1;
            end
        end
        error_positions = [error_positions , position]; 
    end
    
    %----------------------------------------------------------------------
    %   Correcting the transmitted data
    %----------------------------------------------------------------------
    
    sz1 = size(error_positions,2);
    corrected_data = [];
    
    for i = 1:sz1
        temp = received_data( i , :);
        if( error_positions(i) ~= -1 && error_positions(i) ~= 0)        
            temp(1,error_positions(i)) = ~temp(1,error_positions(i));
        end
        corrected_data = [corrected_data;temp];
    end
    
    n_single_bit_error = sz1 - sum(error_positions == -1) - sum(error_positions == 0);
end
% nov_decode function end
