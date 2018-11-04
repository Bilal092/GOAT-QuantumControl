% using struct self
clc;
clear all;
close all;
%%
format long 
global self
rng(3455)
self.sx = [0 1;
          1 0];

self.sy = [0 -1i;
          1i 0];

self.sz = [1  0;
          0  -1];
      
self.sminus = self.sx - self.sy;
self.sigma = [0 1; 0 0];
self.I  = eye(2);

self.Ho = 1 * self.sz;

self.num_har = 8;
self.num_c =1;
%  rng(0);
 
 
self.r  = rand(self.num_har,self.num_c);
self.w  = 0.1 ;

self.ti  = 0;
self.tf = 4;
self.steps = 10000;
self.tspan = linspace(self.ti, self. tf, self.steps);
% self.tspan = [0 8]


self.Uv  = zeros(length(self.tspan),4);
self.H = zeros(2, 2, length(self.tspan));

self.Controls = {self.sx};
self.L = {kron(eye(2),self.sx)};
self.Grad = [length(self.tspan),4 * self.num_c * self.num_har];
self.Gradients = {};
self.GradT = [];

self.U0 = eye(2);
%self.UT = eye(2);


self.A = 1*rand(size(self.r))-0.5;
% self.w = 10*rand(size(self.r));
% self.w = rand(size(self.r));
% self.Bw = rand(size(self.r));

self.Uf = 1j* [0 1;
                          1 0];
self.G0 = kron(self.U0, conj(self.U0));
self.Gf = kron(self.Uf, conj(self.Uf));
                       
                       
% optimization variable dumping in                        
self.iter = [];
self.state = [];
self.infidelity = [];
self.searchdir = [];
                       
self.X = 1*(rand(self.num_har, self.num_c)-0.5);
X = self.X(:);
X  = cat(1, X, self.w);

%[y,t] 

U = eye(2);
M0 =zeros(16 + (1 * 16 *  self.num_c * self.num_har + 16),1);
M0(1:16)=self.G0(:);
% opt = odeset('RelTol',1e-10,'AbsTol',1e-11,'Stats','on');
% [t,M] = ode45(@(t,M) Evolution(t,M, self.A , self.w), self.tspan, M0,opt);



%%
% options = optimset('PlotFcns',@optimplotfval, 'MaxIter', 50000,...
%     'MaxFunEvals',50000,'Display','iter','OutputFcn',@outfun,...
%     'Algorithm','trust-region','SpecifyObjectiveGradient',true);
% options = optimoptions('fminunc','SpecifyObjectiveGradient',true, 'PlotFcns',@optimplotfval, 'MaxIter', 50000,...
%     'MaxFunEvals',50000,'Display','iter','OutputFcn',@outfun,...
%     'Algorithm','quasi-newton',... 
%     'HessUpdate','bfgs', 'FunctionTolerance', 1e-9,...
%     'FinDiffRelStep', 1e-6);
options = optimoptions('fminunc',...
    'TolX',         1e-9,...
    'TolFun',       1e-9,...
    'DerivativeCheck', 'off',...
    'FinDiffType',  'central',...    
    'GradObj',      'on',...
    'OutputFcn',    @outfun,...
    'Display',      'iter',...
    'Algorithm', 'quasi-newton',...
    'HessUpdate','bfgs',...
    'PlotFcns',@optimplotfval...
    );

[x,fval,exitflag,output] = fminunc(@Cost,X,options);


% options = optimset('MaxIter', 5000,...
%     'MaxFunEvals',10000,'OutputFcn',@outfun,'SpecifyObjectiveGradient',true);
% options = optimoptions('fsolve','Display','iter','PlotFcn',@optimplotfirstorderopt,...
%     'SpecifyObjectiveGradient',true, 'FunctionTolerance', 1e-9);
% [x,fval,exitflag,output] = fsolve(@Cost,X,options);

%%
close all
A = self.A;
w = self.w;
t = self.tspan;

u = zeros(1,length(self.tspan));

for k=1:length(A)
    u = u + A(k)  * sin(k * w * t);
end

figure;
plot(t,u,'r','LineWidth',2);
figure;
semilogy(self.infidelity,'k-.','LineWidth',2)

%%

save('GOAT_1Q_Closed5', 'self')
 
