  function [dMdt,H] = Evolution(t, M,  A, w)
% This function computes unitary evolution from shrodinger
% equation

global self

f  = 0 ; 


for k = 1 : self.num_har
    
    f = f + A(k,1)*sin( k * t.* w ) ;
      
end

H = self.Ho +  f  * self.sx;
     
Lt = kron(eye(2),H);

dMdt(1:4,1) = -1j * Lt *M(1:4,1);
count = 5;
l =  1;

for k = 1:self.num_har
    
        dMdt(count:count+3,1) = -1j * (  sin( k * t.* w ) * self.L{l} * M(1:4,1) + ...
            Lt*M(count:count+3,1) );
        count = count+4;
end


temp  = zeros(4,4);

for k = 1:self.num_har
    temp = temp + A(k,1) * k * t.* cos( k * t.* w) * self.L{1};
end


dMdt(count:count+3,1) = -1j * ( temp * M(1:4,1) + ...
                       Lt*M(count:count+3,1) );




 end


