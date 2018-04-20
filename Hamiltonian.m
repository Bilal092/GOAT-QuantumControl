function [Hamiltonian] = Hamiltonian(t)

global self


for k = 1 : self.num_har
    f1  = f1 + A(k,1)*sin(k * t* self.w  + self.r(k,1)) + ...
          B(k,1)*cos(k * t* self.w  + self.r(k,1));
      
    f2  = f2 + A(k,2)*sin(k * t* self.w  + self.r(k,2)) + ...
          B(k,2)* cos(k * t* self.w  + self.r(k,2));
      
    f3  = f3 + A(k,3) * sin(k * t* self.w  + self.r(k,3)) + ...
          B(k,3) * cos(k * t* self.w  + self.r(k,3));
end


Hamiltonian = self.Ho + f1 * self.siy +...
         f2 * self.szi + f3 * self.siz;
end

