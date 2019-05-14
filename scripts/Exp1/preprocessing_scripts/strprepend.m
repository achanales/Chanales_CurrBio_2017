function str = strprepend(number,decplace)
% function str = strprepend(number,decplace)
% Converts number to string preceded by zeros to a total of decplace
% decimal places. 
% jbh 07/15/08
str = sprintf(['%0' num2str(decplace) 'd'],number);