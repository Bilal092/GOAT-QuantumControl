function [Fbar, grad] = Cost(Xv)
global self;

% X is set fourier coefficients in CRAB type optimization
% it constitutes the set of fourier coefficients to be 
% optimized

self.Xv = Xv;
grad = zeros(self.num_har * self.num_c + 1,1);
% Y = reshape(Xv,  self.num_har, self.num_c + 1);
A = Xv( 1: self.num_har, 1:self.num_c );
w = Xv( self.num_har + 1 : end ,  1:self.num_c);

self. A = A;
self. w = w;


if nargout > 1
    [Gradients,UT] = Computations(A, w);
    g = trace(self.Uf'*UT);
    Fbar  = 1 - 1/2 *real(((trace(self.Uf' * UT))));
    self.Infid = Fbar;
    
    for i = 1 : self.num_har * self.num_c + 1
        grad(i) = -1/2*real(trace(self.Uf' * Gradients{i}));
    end
%     self.GradT= grad;
% grad = grad';
self.GradT = grad;

else
    
    [~,UT] = Computations(A, w);
    Fbar  = 1 - 1/2 *real(((trace(self.Uf' * UT))));
    self.Infid = Fbar;
    
end

