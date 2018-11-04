function [L] = Liouvillian(H)
%Liouvillian function for vectorized dynamcis of quantum system
I = eye(2);
L = kron(I, H) - kron(transpose(H),I);
end

