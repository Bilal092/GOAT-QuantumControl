function [Gradients,GT] = Computations(A, w)

% final value of Unitary evolution operator during each round 
% of optimization is computed and stored
global self
self.A = A;
self.w = w;

G = eye(4);
M0 =zeros(16 + (1 * 16 *  self.num_c * self.num_har + 16),1);
M0(1:16,1)=G(:);

opt = odeset('RelTol',1e-10,'AbsTol',1e-11,'Stats','off');
[~,M] = ode45(@(t,M) Evolution(t,M, self.A , self.w), self.tspan, M0,opt);

self.Gv = M(:,1:16);
GTv = self.Gv(self.steps,:);
GT = reshape(GTv, 4, 4);
self.GT = GT;

self.Grad = M(:,17:end);
self.GradT = self.Grad(end,:);
count = 1;
i = 1;
for k = 1: self.num_c * self.num_har + 1
    
    temp = self.GradT(count:count+15);
    self.Gradients{i} = reshape(temp,4,4);
    i = i + 1;
    count = count + 16;
end
Gradients = self.Gradients;

end

