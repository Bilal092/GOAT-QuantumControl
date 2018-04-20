 function [dMdt,H] = Evolution(t, M,  A, B)
% This function computes unitary evolution from shrodinger
% equation

global self

f1  = 0 ; 
f2  = 0 ;
f3  = 0 ; 


for k = 1 : self.num_har
    f1  = f1 + A(k,1)*sin(k * t.* self.w  + self.r(k,1)) + ...
          B(k,1)*cos(k * t.* self.w  + self.r(k,1));
      
    f2  = f2 + A(k,2)*sin(k * t.* self.w  + self.r(k,2)) + ...
          B(k,2)* cos(k * t.* self.w  + self.r(k,2));
      
    f3  = f3 + A(k,3) * sin(k * t.* self.w  + self.r(k,3)) + ...
          B(k,3) * cos(k * t.* self.w  + self.r(k,3));
end


H = self.Ho + f1 * self.siy +...
         f2 * self.szi + f3 * self.siz;
     
     
Lt = kron(eye(4),H);
% L{1} = kron(eye(4), self.Controls{1});
% L{2} = kron(eye(4), self.Controls{3});
% L{3} = kron(eye(4), self.Controls{3});


dMdt(1:16,1) = -1i * Lt *M(1:16,1);
count = 17;
for l = 1: self.num_c
    for k = 1:self.num_har
        dMdt(count:count+15,1) = -1j * (  sin(k * t.* self.w  + self.r(k,1)) * self.L{l} * M(1:16,1) + ...
            Lt*M(count:count+15,1));
        count = count+16;
    end
end


for l = 1: self.num_c
    for k = 1:self.num_har
        dMdt(count:count+15,1) = -1j * (cos(k * t.* self.w  + self.r(k,1)) * self.L{l} * M(1:16,1) + ...
            Lt*M(count:count+15,1));
        count = count+16;
    end
end

 end


