% using struct self
clc;
clear all;
%%
format long 
global self
self.sx = [0 1;
          1 0];

self.sy = [0 -1i;
          1i 0];

self.sz = [1  0;
          0  -1];
  
self.I  = eye(2);


self.siy = kron(eye(2), self.sy);
self.szi = kron(self.sz, eye(2));
self.siz = kron(eye(2), self.sz);
self.szz = kron(self.sz, self.sz);

self.Ho = 0.1 * self.szz;

self.num_har = 8;
self.num_c =3;
 rng(23);
 
 
self.r  = rand(self.num_har,self.num_c);
self.w  = rand(self.num_c, 1);

self.ti  = 0;
self.tf = 20;
self.steps = 5000;
self.tspan = linspace(self.ti, self. tf, self.steps);
% self.tspan = [0 8]


self.Uv  = zeros(length(self.tspan),16);
self.H = zeros(4, 4, length(self.tspan));

self.Controls = {self.siy, self.szi, self.siz};
self.L = {kron(eye(4),self.siy), kron(eye(4),self.szi), ...
    kron(eye(4),self.siz)};
self.Grad = [length(self.tspan),16 * self.num_c * self.num_har];
self.Gradients = {};
self.GradT = [];

self.U0 = eye(4);
self.UT = eye(4);


self.A = 1*rand(size(self.r))-0.5;
% self.w = 10*rand(size(self.r));
% self.w = rand(size(self.r));
% self.Bw = rand(size(self.r));

self.Uf = exp(1i*pi/4)* [1 0 0 0;
                          0 1 0 0;
                          0 0 0 1;
                          0 0 1 0];                       
% optimization variable dumping in                        
self.iter = [];
self.state = [];
self.infidelity = [];
self.searchdir = [];
                       
self.X = 1*(ones(self.num_har, self.num_c)-0.5);
self.X = self.X(:);
self.X  = cat(1, self.X, self.w);

%

% U = eye(4);
% M0 =zeros(16 + (1 * 16 *  self.num_c * self.num_har + 48),1);
% M0(1:16)=U(:);
% opt = odeset('RelTol',1e-11,'AbsTol',1e-11,'Stats','on');
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

[x,fval,exitflag,output] = fminunc(@Cost,self.X,options);


% options = optimset('MaxIter', 5000,...
%     'MaxFunEvals',10000,'OutputFcn',@outfun,'SpecifyObjectiveGradient',true);
% options = optimoptions('fsolve','Display','iter','PlotFcn',@optimplotfirstorderopt,...
%     'SpecifyObjectiveGradient',true, 'FunctionTolerance', 1e-9);
% [x,fval,exitflag,output] = fsolve(@Cost,X,options);

%%

save('GOAT6_L', 'self')
