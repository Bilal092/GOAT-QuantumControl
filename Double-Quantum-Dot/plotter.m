load 'GOATDQD3.mat';
t = self.tspan;


t = self.tspan;

f1 = zeros(size(t));
f2 = zeros(size(t));
f3 = zeros(size(t));

%har = self.num_har;

for k = 1 : self.num_har
        f1  = f1 + self.A(k,1)*sin(k * t* self.w(1) ) ;
          
end


for k = 1 : self.num_har
    f2  = f2 + self.A(k,2)*sin(k * t* self.w(2)  );
end


% for k = 1 : self.num_har
%     f3  = f3 + self.A(k,3) * sin(k * t* self.w(3)  );
%       
% end

close all
plot(t,f1,'LineWidth',2)
hold on
plot(t,f2,'LineWidth',2)
% hold on
% plot(t,f3,'LineWidth',2)



%% genration of graphs and stuff
close all;
width = 3.3;     % Width in inches
height = 2.4;    % Height in inches
alw = 0.5;    % AxesLineWidth
fsz = 8;      % Fontsize
fsz1=7;
lw = 2;      % LineWidth
msz = 6;       % MarkerSize
% [u1, u2 , u3]  = Controls();
%%
figure();

subplot(2,1,1)
plot(t,f1,'r','LineWidth',2)

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
ylabel('$$\varepsilon_{_{U}}$','Interpreter','latex')
% set(gcf,'InvertHardcopy','on');
% set(gcf,'PaperUnits', 'inches');
% papersize = get(gcf, 'PaperSize');

% left = (papersize(1)- width)/2;
% bottom = (papersize(2)- height)/2;
% myfiguresize = [left, bottom, width, height];
% set(gcf,'PaperPosition', myfiguresize);
% print('CRAB-Control1','-dpng','-r900');
% print('CRAB-Control1','-depsc2','-r900');


subplot(2,1,2);
plot( t,f2,'g','LineWidth',2)


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
ylabel('$$\varepsilon_{_{L}}$','Interpreter','latex')
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


% subplot(3,1,3)
% plot(t, f3,'LineWidth',2)
% 
% set(gca,'FontName','Times New Roman','FontSize',fsz,'FontWeight','normal')%'FontWeight','bold','LineWidth',1)
% pos = get(gcf, 'Position');
% set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
% set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
% % set(gca,'YLim',[0 1]);
% % set(gca,'XLim',[0,1])
% % set(gca,'YTick',[1e-8 1e-7 1e-6 1e-5 1e-4 1e-3 1e-2 1e-1 1e0]);
% % title('(a)')
% %set(get(gca,'title'),'Position',[5.5 0.4 1.00011])

% set(gca,'XTick',0:0.004:0.002);
xlabel('time (n.s.)');
% ylabel('$$\varepsilon_{3}$','Interpreter','latex')
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');

left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);
print('GOAT-Controls','-dpng','-r900');
print('GOAT-Controls','-depsc2','-r900');





%%
figure();
iter = 1:length(self.infidelity);
semilogy(iter , self.infidelity,'LineWidth',lw,'Color','k');
set(gca,'FontName','Times New Roman','FontSize',fsz,'FontWeight','normal')%'FontWeight','bold','LineWidth',1)
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
% set(gca,'YLim',[0 1]);
set(gca,'XLim',[0,max(iter)])
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
print('GOAT-infidelity_Long','-dpng','-r900');
print('GOAT-infidelity_Long','-depsc2','-r900');



% infidelity7 = self.infidelity;
% iter7 = length(infidelity7);
% % saving data in matfile
% save('CRAB_NM7.mat','iter7');
% save('CRAB_NM7.mat' ,'infidelity7','-append')


%%
lw = 0.01;
load 'GOAT1_L.mat';
fid1 = self.infidelity;
iter1 = 0:length(self.infidelity)-1;
load 'GOAT2_L.mat';
fid2 = self.infidelity;
iter2 = 0:length(self.infidelity)-1;
load 'GOAT3_L.mat';
fid3 = self.infidelity;
iter3 = 0:length(self.infidelity)-1;
load 'GOAT4_L.mat';
fid4 = self.infidelity;
iter4 = 0:length(self.infidelity)-1;
load 'GOAT5_L.mat';
fid5 = self.infidelity;
iter5 = 0:length(self.infidelity)-1;
load 'GOAT6_L.mat';
fid6 = self.infidelity;
iter6 = 0:length(self.infidelity)-1;


figure();
iter = 1:length(self.infidelity);
semilogy(iter1 , fid1,'LineWidth',lw,'Color','r');
hold on
semilogy(iter2 , fid2,'LineWidth',lw,'Color','r');
hold on
semilogy(iter3 , fid3,'LineWidth',lw,'Color','r');
hold on
semilogy(iter4 , fid4,'LineWidth',lw,'Color','r');
hold on
semilogy(iter5 , fid5,'LineWidth',lw,'Color','r')
hold on
semilogy(iter6 , fid6,'LineWidth',lw,'Color','r');
hold off
set(gca,'FontName','Times New Roman','FontSize',fsz,'FontWeight','normal')%'FontWeight','bold','LineWidth',1)
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
% set(gca,'YLim',[0 1]);
set(gca,'XLim',[0,120]);
set(gca,'Ylim',[5e-13, 1e0]);
set(gca,'YTick',[1e-12 1e-10 1e-8 1e-6 1e-4 1e-2 1e0]);
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
print('GOAT-infidelity_Long_Multiple','-dpng','-r900');
print('GOAT-infidelity_Long_Multiple','-depsc2','-r900');





