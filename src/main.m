
%------------------------------------------------------------------------------
%   
%   Main script with userfriendly CLI menu to demonstrate and compare the Novel
%   hamming code implementation.
%
%------------------------------------------------------------------------------

clc;
fprintf ('\n\n\t A Novel Approach to Improving Burst Error Capability \n\t\t\t in Hamming Codes\n');

fprintf ('\n\t Main Menu \n');
fprintf ('\n 1. Simulate Hamming Codes');
fprintf ('\n 2. Compare and Contrast');
fprintf ('\n ==>');

ch = input(' ');

if (ch == 1)
    nicesim
else
    plotdata
end