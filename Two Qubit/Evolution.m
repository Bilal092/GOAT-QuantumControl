  function [dMdt,H] = Evolution(t, M,  A, w)
% This function computes unitary evolution from shrodinger
% equation

global self

f1  = 0 ; 
f2  = 0 ;
f3  = 0 ;

for k = 1 : self.num_har
    
    f1 = f1 + A(k,1)*sin( k * t.* w(1) ) ;
    f2 = f2 + A(k,2)*sin( k * t.* w(2) ) ;
    f3 = f3 + A(k,3)*sin( k * t.* w(3) ) ;
      
end

H = self.Ho +  f1  * self.Controls{1} + f2  * self.Controls{2} + ...
    f3  * self.Controls{3};
     
Lt = kron(eye(4),H);


% first four varibales are evolution variables for one qubit quantum
% systems

dMdt(1:16,1) = -1j * Lt *M(1:16,1);
count = 17;
% l =  1;

% This part related to derivatives with respect to waight matrices
for l = 1 : self.num_c
    for k = 1:self.num_har
    
        dMdt(count:count + 15,1) = -1j * (  sin( k * t.* w(l)  ) * self.L{l} * M(1:16,1) + ...
            Lt*M(count:count + 15,1) );
        count = count + 16;
    end

end


% This part related to derivatives with respect to fourier base frequencies
%  for each control
temp{1}  = zeros(16,16);
temp{2}  = zeros(16,16);
temp{3}  = zeros(16,16);

for k = 1:self.num_har
    temp{1} = temp{1} + A(k,1) * k * t.* cos( k * t.* w(1)) * self.L{1};
    temp{2} = temp{2} + A(k,2) * k * t.* cos( k * t.* w(2)) * self.L{2};
    temp{3} = temp{3} + A(k,3) * k * t.* cos( k * t.* w(3)) * self.L{3};
end

for  l = 1 : self.num_c
    dMdt(count:count + 15,1) = -1j * ( temp{l} * M(1:16,1) + ...
                       Lt*M(count:count + 15,1) );
    count = count + 16;
end




 end


