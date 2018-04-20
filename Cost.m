function [Fbar, grad] = Cost(Xv)
global self;

% X is set fourier coefficients in CRAB type optimization
% it constitutes the set of fourier coefficients to be 
% optimized

self.Xv = Xv;
grad = zeros(2 * self.num_har * self.num_c,1);
Y = reshape(Xv, 2 * self.num_har, self.num_c);
A = Y( 1: self.num_har, 1:self.num_c );
B = Y( self.num_har + 1 : end ,  1:self.num_c);

self. A = A;
self. B = B;

if nargout > 1
    
    [Gradients,UT] = Computations(A, B);
    Fbar  = 1 - 1/16 *abs((trace(self.Uf' * UT)))^2;
    self.Infid = Fbar;
    
    for i = 1:2 * self.num_har * self.num_c
        grad(i) = -1/4*real(trace(self.Uf' * Gradients{i}));
    end
%     self.GradT= grad;

else
    
    [~,UT] = Computations(A, B);
    Fbar  = 1 - 1/16 *abs((trace(self.Uf' * UT)))^2;
    self.Infid = Fbar;
    
end

