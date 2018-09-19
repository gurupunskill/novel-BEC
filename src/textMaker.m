function [] = textMaker()
    
    clc;
    
    % Get the string from user that we would want to test
    data = input('Enter string: ', 's');
    ascii_values_data = double(data);
    data_sent = de2bi(ascii_values_data);
  
    data_sent = num2str(data_sent, '%i')
    data_stream = '';
    length(data_sent)
    for i = 1:length(data_sent)
        data_stream = strcat(data_stream,data_sent(i))
    end
    
    data_stream
    

end

