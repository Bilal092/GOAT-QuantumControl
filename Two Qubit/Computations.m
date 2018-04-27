function [Gradients,UT] = Computations(A, w)

% final value of Unitary evolution operator during each round 
% of optimization is computed and stored
global self
self.A = A;
self.w = w;

U = eye(4);
M0 =zeros(16 + (1 * 16 *  self.num_c * self.num_har + 48),1);
M0(1:16)=U(:);

opt = odeset('RelTol',1e-12,'AbsTol',1e-12,'Stats','off');
[~,M] = ode45(@(t,M) Evolution(t,M, self.A , self.w), self.tspan, M0,opt);

self.Uv = M(:,1:16);
UTv = self.Uv(self.steps,:);
UT = reshape(UTv, 4, 4);
self.UT = UT;

self.Grad = M(:,17:end);
self.GradT = self.Grad(end,:);
count = 1;
i = 1;
for k = 1: self.num_c * self.num_har + self.num_c
    temp = self.GradT(count:count+15);
    self.Gradients{i} = reshape(temp,4,4);
    i = i + 1;
    count = count + 16;
end
Gradients = self.Gradients;

end

