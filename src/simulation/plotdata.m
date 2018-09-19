
%--------------------------------------------------------------------------
%
%   A Script to plot the comparison between the Novel and Standard hamming
%   code implementations.
%
%   Since the data is quite large, we pregenerated a csv file that holds all
%   the simulation variables returned by simulate.m over multiple
%   simulations. 
%   The datagen.m script generated this dataset and stored it in a csv file.
%
%--------------------------------------------------------------------------

dt = csvread('gendataset.csv');

% Define scatter point size
sz = 10;

%--------------------------------------------------------------------------
% PLOT 1 - Detection Comparision
%--------------------------------------------------------------------------

subplot (3,2,1);
hold on;

% std detect
scatter (dt(:,1), dt(:,4), sz, 'filled', 'b')

% nov detect
scatter (dt(:,1), dt(:,6), sz, 'filled', 'r')

h = lsline;
h(1).Color = 'r';
h(2).Color = 'b';
ylabel('No. of Errors Detected');
xlabel('Data Size Transmitted (x88 bits)');
legend ('Standard Hamming', 'Novel Hamming', 'Location', 'northwest');
title('Error Detection');

%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% PLOT 2 - Correction Comparison
%--------------------------------------------------------------------------

subplot (3,2,2);
hold on;

% std correct
scatter (dt(:,1), dt(:,5), sz, 'filled', 'b')
% nov correct
scatter (dt(:,1), dt(:,7), sz, 'filled', 'r')

h = lsline;
h(1).Color = 'r';
h(2).Color = 'b';
ylabel('No. of Errors Corrected');
xlabel('Data Size Transmitted (x88 bits)');
legend ('Standard Hamming', 'Novel Hamming', 'Location', 'northwest');
title ('Error Correction');

%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% PLOT 3 - All Comparisons
%--------------------------------------------------------------------------

subplot (3,2,[3,4, 5, 6]);
hold on;

% std detect
scatter (dt(:,1), dt(:,4), sz, 'filled', 'b')
% nov detect
scatter (dt(:,1), dt(:,6), sz, 'filled', 'r')

% std correct
scatter (dt(:,1), dt(:,5), sz, 'filled', 'c')
% nov correct
scatter (dt(:,1), dt(:,7), sz, 'filled', 'm')

h = lsline;
h(1).Color = 'm';
h(2).Color = 'c';
h(3).Color = 'r';
h(4).Color = 'b';
legend ('Standard Hamming Detection', 'Novel Hamming Detection', 'Standard Hamming Correction', 'Novel Hamming Correction', 'Location', 'northwest');
title ('Complete Plot');
ylabel('No. of Errors');
xlabel('Data Size Transmitted (x88 bits)');
%--------------------------------------------------------------------------
