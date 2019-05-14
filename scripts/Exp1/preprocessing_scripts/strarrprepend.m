function strmat = strarrprepend(numvec,decplace)
% function strmat = strarrprepend(numvec,decplace)
% Stupid wrapper function for converting an array of numbers into a
% zero-prepended string array.
% jbh 07/15/08

a = arrayfun(@(o)(strprepend(o,decplace)),numvec,'UniformOutput',0);
strmat = cell2mat(a);