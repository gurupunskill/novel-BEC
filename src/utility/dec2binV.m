function [output] = dec2binV(d,r)
%DEC2BINV converts a decimal number to its binary form in a row vector    
    
    %   function to convert a decimal integer to a binary string of at least
    %   'r' characters
    
    a = dec2bin(d,r);
    
    %convert string to a number
    
    b = str2num(a);
    
    %convert number to a row vector of digits
    
    c = [];
    for i = 1:length(a)
        n = mod(b,10);
        b = floor(b / 10);
        c = [n,c];
    end
    
    output = c;
end
% dec2binV end