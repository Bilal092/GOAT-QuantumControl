function [f1,f2,f3] = Controls()

global self

duvdt = zeros(16,1);
t = self.tspan;

f1 = zeros(size(t));
f2 = zeros(size(t));
f3 = zeros(size(t));

%har = self.num_har;

for k = 1 : self.num_har
        f1  = f1 + self.A(k,1)*sin(k * t* self.w  + self.r(k,1)) + ...
          self.B(k,1)* cos(k * t* self.w  + self.r(k,1));
end


for k = 1 : self.num_har
    f2  = f2 + self.A(k,2)*sin(k * t* self.w  + self.r(k,2)) + ...
          self.B(k,2)* cos(k * t* self.w  + self.r(k,2));
end


for k = 1 : self.num_har
    f3  = f3 + self.A(k,3) * sin(k * t* self.w  + self.r(k,3)) + ...
          self.B(k,3) * cos(k * t* self.w  + self.r(k,3));
      
end

end



