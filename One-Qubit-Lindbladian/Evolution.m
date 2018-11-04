  function [dMdt,H] = Evolution(t, M,  A, w)
% This function computes unitary evolution from shrodinger
% equation

global self

f  = 0 ; 

for k = 1 : self.num_har
    
    f = f + A(k,1) * sin( k * t.* w ) ;
      
end

H = self.Ho +  f  * self.sx;
I4 = eye(4);

Lt = kron(I4,Liouvillian(H));
Ltx = kron(I4,Liouvillian(self.sx)); 

dMdt(1:16,1) = -1j * Lt * M(1:16,1);
count = 17;
% l =  1;
% derivatives w.r.t fourier weights  
for k = 1:self.num_har
 dMdt(count:count + 15, 1) = -1j *...
     (sin( k * t.* w ) * Ltx * M(1:16,1) + Lt * M(count:count + 15, 1) );
        count = count + 16;
end

% derivatives w.r.t fourier frequencies

temp  = zeros(16,16);

for k = 1:self.num_har
    temp = temp + A(k,1) * k * t.* cos( k * t.* w) * Ltx ;
end


dMdt(count:count+15,1) = -1j * (temp * M(1:16,1) + ...
                       Lt*M(count:count+15,1) );


 end


