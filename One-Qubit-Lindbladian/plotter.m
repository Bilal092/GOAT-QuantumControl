% load data files 
clear all;
close all;

% modify the code to load files as desired
load('GOAT_1Q_Closed1.mat')
Z1 = self.infidelity ;
load('GOAT_1Q_Closed2.mat')
Z2 = self.infidelity ;
load('GOAT_1Q_Closed3.mat')
Z3 = self.infidelity ;
load('GOAT_1Q_Closed4.mat')
Z4 = self.infidelity ;
load('GOAT_1Q_Closed5.mat')
Z5 = self.infidelity ;
load('GOAT_1Q_Closed6.mat')
Z6 = self.infidelity ;
% specify dimensions for differnet parameters of figures

width = 3.3;     % Width in inches
height = 2.4;    % Height in inches
alw = 0.5;    % AxesLineWidth
fsz = 8;      % Fontsize
fsz1=7;
lw = 0.5;      % LineWidth
msz = 6;       % MarkerSize


%% plot and specify control paramaters clearly
iter = 1:1000;
figure();
semilogy(0:length(Z1)-1,Z1,'b', 'LineWidth', lw);
hold on
semilogy(0:length(Z2)-1,Z2,'b', 'LineWidth', lw);
hold on
semilogy(0:length(Z3)-1,Z3,'b', 'LineWidth', lw);
hold on
semilogy(0:length(Z4)-1,Z4,'b', 'LineWidth', lw);
hold on
semilogy(0:length(Z5)-1,Z5,'b', 'LineWidth', lw);
hold on
semilogy(0:length(Z6)-1,Z6,'b', 'LineWidth', lw);
hold on


xlim([0 50]);
ylim([1e-10 1e0]);


%specify paramters for printing figures
set(gca,'FontName','Times New Roman','FontSize',fsz,'FontWeight','normal')%'FontWeight','bold','LineWidth',1)
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
% set(gca,'YLim',[0 1]);
% set(gca,'XLim',[0,1])
set(gca,'YTick',[1e-8 1e-7 1e-6 1e-5 1e-4 1e-3 1e-2 1e-1 1e0]);
% title('(a)')
%set(get(gca,'title'),'Position',[5.5 0.4 1.00011])

% set(gca,'XTick',0:0.004:0.002);
xlabel('iterations');
ylabel('infidelity')

set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');

left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);
% print('Infidelities-Krotov+GRAPE','-dpng','-r900');
% print('Infdelities-Krotov+GRAPE','-depsc2','-r900');

print('Infidelities-Krotov','-dpng','-r900');
print('Infdelities-Krotov','-depsc2','-r900');
print('Infdelities-Krotov','-dtiff','-r900');
