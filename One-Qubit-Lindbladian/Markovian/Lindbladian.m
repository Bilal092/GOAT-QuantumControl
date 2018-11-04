function [Lindbladian] = Lindbladian(O)
% Lindbadian su[eroperator for vectorized dynamics for MArkovian Quantum
% systems, It can be extended for higher qubit systems without any
% modification

Lindbladian = kron(conj(O), O) -(1/2) * kron(eye(2), O'*O) ...
    -(1/2) * kron(transpose(O) * conj(O), eye(2));

end

