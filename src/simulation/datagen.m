
%----------------------------------------------------------------------
%
%   Script to store compare.m return values in a .csv file
%
%----------------------------------------------------------------------
   
disp ('Creating dataset with 10,1000,10,10')
data = compare(10,1000,10,10);
disp ('Storing data')
csvwrite('gendataset.csv',data);
disp ('Done')