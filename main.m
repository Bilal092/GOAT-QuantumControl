% using struct self

clear all
global self
self.sx = [0 1;
          1 0];

self.sy = [0 -1i;
          1i 0];

self.sz = [1  0;
          0  -1];
  
self.I  = eye(2);

self.siy = kron(self.I, self.sy);
self.szi = kron(self.sz, self.I);
self.siz = kron(self.I, self.sz);
self.szz = kron(self.sz, self.sz);

J  = 0.1;
self.Ho = 0.1 * self.szz;

self.num_har = 6;
self.num_c =3;
rng(23);
self.r  = rand(self.num_har,self.num_c);
self.w  = 0.1 ;

self.ti  = 0;
self.tf = 8;
self.steps = 2000;
self.tspan = linspace(self.ti, self. tf, self.steps);
% self.tspan = [0 8]


self.Uv  = zeros(length(self.tspan),16);
self.H = zeros(4, 4, length(self.tspan));

self.Controls = {self.siy, self.szi, self.siz};
self.L = {kron(eye(4),self.siy), kron(eye(4),self.szi), kron(eye(4),self.siz)};
self.Grad = [length(self.tspan),16 * self.num_c * self.num_har];
self.Gradients = {};
self.GradT = [];

self.U0 = eye(4);
self.UT = eye(4);


self.A = zeros(size(self.r));
self.B = zeros(size(self.r));
self.Uf = exp(-1i*pi*4) * [1 0 0 0;
                           0 1 0 0;
                           0 0 0 1;
                           0 0 1 0];
                       
                       
% optimization variable dumping in                        
self.iter = [];
self.state = [];
self.infidelity = [];
self.searchdir = [];
                       
self.X = rand(2*self.num_har, self.num_c)-0.5;
X = self.X(:);


% U = eye(4);
% M0 =zeros(16 + (2 * 16 * self.num_c * self.num_har),1);
% M0(1:16)=U(:);
% 
% [~,M] = ode45(@(t,M) Evolution(t,M, self.A , self.B), self.tspan, M0);



%%
% options = optimset('PlotFcns',@optimplotfval, 'MaxIter', 50000,...
%     'MaxFunEvals',50000,'Display','iter','OutputFcn',@outfun,...
%     'Algorithm','trust-region','SpecifyObjectiveGradient',true);
options = optimoptions('fminunc','SpecifyObjectiveGradient',true, 'PlotFcns',@optimplotfval, 'MaxIter', 50000,...
    'MaxFunEvals',50000,'Display','iter','OutputFcn',@outfun,...
    'Algorithm','trust-region',...
    'HessUpdate','bfgs');
[x,fval,exitflag,output] = fminunc(@Cost,X,options);
% options = optimset('MaxIter', 5000,...
%     'MaxFunEvals',10000,'OutputFcn',@outfun);
% [x,fval,exitflag,output] = fminsearch(@Cost,X,options);




 %%
% egenration of graphs and stuff
close all;
width = 3.3;     % Width in inches
height = 2.4;    % Height in inches
alw = 0.5;    % AxesLineWidth
fsz = 8;      % Fontsize
fsz1=7;
lw = 2;      % LineWidth
msz = 6;       % MarkerSize
[u1, u2 , u3]  = Controls();
%%
figure();

subplot(3,1,1)
plot(self.tspan, u1,'r','LineWidth',2)

set(gca,'FontName','Times New Roman','FontSize',fsz,'FontWeight','normal')%'FontWeight','bold','LineWidth',1)
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
% set(gca,'YLim',[0 1]);
% set(gca,'XLim',[0,1])
% set(gca,'YTick',[1e-8 1e-7 1e-6 1e-5 1e-4 1e-3 1e-2 1e-1 1e0]);
% title('(a)')
%set(get(gca,'title'),'Position',[5.5 0.4 1.00011])

% set(gca,'XTick',0:0.004:0.002);
% xlabel('time (a.u.)');
ylabel('$$\varepsilon_{1}$','Interpreter','latex')
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits', 'inches');
% papersize = get(gcf, 'PaperSize');

% left = (papersize(1)- width)/2;
% bottom = (papersize(2)- height)/2;
% myfiguresize = [left, bottom, width, height];
% set(gcf,'PaperPosition', myfiguresize);
% print('CRAB-Control1','-dpng','-r900');
% print('CRAB-Control1','-depsc2','-r900');


subplot(3,1,2);
plot( self.tspan,u2,'g','LineWidth',2)


set(gca,'FontName','Times New Roman','FontSize',fsz,'FontWeight','normal')%'FontWeight','bold','LineWidth',1)
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
% set(gca,'YLim',[0 1]);
% set(gca,'XLim',[0,1])
% set(gca,'YTick',[1e-8 1e-7 1e-6 1e-5 1e-4 1e-3 1e-2 1e-1 1e0]);
% title('(a)')
%set(get(gca,'title'),'Position',[5.5 0.4 1.00011])

% set(gca,'XTick',0:0.004:0.002);
% xlabel('time (a.u.)');
ylabel('$$\varepsilon_{2}$','Interpreter','latex')
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits', 'inches');
% papersize = get(gcf, 'PaperSize');
% 
% left = (papersize(1)- width)/2;
% bottom = (papersize(2)- height)/2;
% myfiguresize = [left, bottom, width, height];
% set(gcf,'PaperPosition', myfiguresize);
% print('CRAB-Control2','-dpng','-r900');
% print('CRAB-Control2','-depsc2','-r900');


subplot(3,1,3)
plot(self.tspan, u3,'LineWidth',2)

set(gca,'FontName','Times New Roman','FontSize',fsz,'FontWeight','normal')%'FontWeight','bold','LineWidth',1)
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
% set(gca,'YLim',[0 1]);
% set(gca,'XLim',[0,1])
% set(gca,'YTick',[1e-8 1e-7 1e-6 1e-5 1e-4 1e-3 1e-2 1e-1 1e0]);
% title('(a)')
%set(get(gca,'title'),'Position',[5.5 0.4 1.00011])

% set(gca,'XTick',0:0.004:0.002);
xlabel('time (a.u.)');
ylabel('$$\varepsilon_{3}$','Interpreter','latex')
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');

left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);
print('CRAB-Controls','-dpng','-r900');
print('CRAB-Controls','-depsc2','-r900');





%%
figure();
iter = 1:length(self.infidelity);
semilogy(iter , self.infidelity,'LineWidth',lw,'Color','m');
set(gca,'FontName','Times New Roman','FontSize',fsz,'FontWeight','normal')%'FontWeight','bold','LineWidth',1)
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
% set(gca,'YLim',[0 1]);
set(gca,'XLim',[-1,14000])
% set(gca,'YTick',[1e-1 1e0]);
% title('(a)')
% set(gca,'YTick',[1e-1 1e0]);
%set(get(gca,'title'),'Position',[5.5 0.4 1.00011])

%set(gca,'YTick',0:0.004:0.002);
xlabel('iterations');
ylabel('Infidelity')
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');

left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);
print('CRAB-infidelity_Long','-dpng','-r900');
print('CRAB-infidelity_Long','-depsc2','-r900');


%%
infidelity7 = self.infidelity;
iter7 = length(infidelity7);
% saving data in matfile
save('CRAB_NM7.mat','iter7');
save('CRAB_NM7.mat' ,'infidelity7','-append')








