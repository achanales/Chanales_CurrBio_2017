function[z]=fisherz(r)
%FISHERZ Fisher's Z-transform.
%   Z = FISHERZ(R) returns the Fisher's Z-transform of the correlation
%   coefficient R.

a=r(:);
z=.5.*log((1+a)./(1-a));
z = reshape(z,size(r,1),size(r,2));

end