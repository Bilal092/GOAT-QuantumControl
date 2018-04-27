function [Fbar, grad] = Cost(Xv)
global self;

% X is set fourier coefficients in CRAB type optimization
% it constitutes the set of fourier coefficients to be 
% optimized

self.Xv = Xv;
grad = zeros(self.num_har * self.num_c + 1,1);

Y1 = Xv(1:self.num_har * self.num_c);
Y2 = Xv(self.num_har * self.num_c + 1: end);

A = reshape( Y1, self.num_har , self.num_c );

w = Y2;

self. A = A;
self. w = w;


if nargout > 1
    [Gradients,UT] = Computations(A, w);
    g = trace(self.Uf'*UT);
    Fbar  = 1 - 1/4 *real(((trace(self.Uf' * UT))));
    self.Infid = Fbar;
    
    for i = 1 : self.num_har * self.num_c + 3
        grad(i) = -1/4*real(trace(self.Uf' * Gradients{i}));
    end
%     self.GradT= grad;
% grad = grad';
self.GradT = grad;

else
    
    [~,UT] = Computations(A, w);
    Fbar  = 1 - 1/4 *real(((trace(self.Uf' * UT))));
    self.Infid = Fbar;
    
end

