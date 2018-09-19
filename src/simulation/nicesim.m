
%--------------------------------------------------------------------------
%
%   Script to show the basic implementation of the algorithm and its
%   working step byt step. It shows the induction of errors, detection and
%   correction of the same.
%
%--------------------------------------------------------------------------

clc;
fprintf ('\n\n This script walks through the algorithms implemented in a \n step by step manner');

%   Generate data
fprintf ('\n\n Step 1: Generate some data \n This is the data that needs to be transmitted');
data = rand(1,88) > 0.5;
datar = reshape(data,11,8)'
input(' ');

%   Encode data
fprintf ('\n\n Step 2: Encode the data using standard hamming method and novel hamming methods');
standard = std_encode(data)
novel = nov_encode(data)

fprintf ('\n\n Note the difference in the first rows of the standard and the novel encodings');
input(' ');

%   Transmission
fprintf ('\n\n Step 3: Induce some error.\n Let us change the first three bits (burst) for demonstration purposes');
standard(1,1) = ~ standard(1,1);
standard(1,2) = ~ standard(1,2);
standard(1,3) = ~ standard(1,3);

novel(1,1) = ~ novel(1,1);
novel(1,2) = ~ novel(1,2);
novel(1,3) = ~ novel(1,3);

standard
novel
input(' ');

%   Decode data
fprintf ('\n\n Step 4: Decode and correct the transmitted data')
[nov_corrected_data, nov_corrected, nov_detected] = nov_decode(novel);
[std_corrected_data, std_corrected, std_detected] = std_decode(standard);

%   actal data
datar

%   standard corrected data
std_corrected_data

%   novel corrected data
nov_corrected_data
