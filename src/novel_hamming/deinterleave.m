function [ output ] = deinterleave( received_data )
%   DEINTERLEAVE Deinterleaves the received data to result in codewords.
%   Detailed explanation goes here

    received_data = received_data';
    n_cols = size(received_data,2);
    output = [];
    for i = 1:16:n_cols
        output = [output; received_data(:,i:i+15)];
    end
end

