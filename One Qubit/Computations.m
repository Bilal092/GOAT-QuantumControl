function [Gradients,UT] = Computations(A, w)

% final value of Unitary evolution operator during each round 
% of optimization is computed and stored
global self
self.A = A;
self.w = w;

U = eye(2);
M0 =zeros(4 + (1 * 4 *  self.num_c * self.num_har + 4),1);
M0(1:4,1)=U(:);

opt = odeset('RelTol',1e-10,'AbsTol',1e-10,'Stats','off');
[~,M] = ode45(@(t,M) Evolution(t,M, self.A , self.w), self.tspan, M0,opt);

self.Uv = M(:,1:4);
UTv = self.Uv(self.steps,:);
UT = reshape(UTv, 2, 2);
self.UT = UT;

self.Grad = M(:,5:end);
self.GradT = self.Grad(end,:);
count = 1;
i = 1;
for k = 1: self.num_c * self.num_har + 1
    
    temp = self.GradT(count:count+3);
    self.Gradients{i} = reshape(temp,2,2);
    i = i + 1;
    count = count + 4;
end
Gradients = self.Gradients;

end

