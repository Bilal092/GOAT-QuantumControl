load('CRAB_newton1.mat')
Z1 = infidelity1;
iter1 = 1:length(infidelity1);
load('CRAB_newton2.mat')
iter2 = 1:length(infidelity2);
Z2 = infidelity2;
load('CRAB_newton3.mat')
iter3 = 1:length(infidelity3);
Z3 = infidelity3;
load('CRAB_newton4.mat')
Z4 = infidelity4;
iter4 = 1:length(infidelity4);
load('CRAB_newton5.mat')
iter5 = 1:length(infidelity5);
Z5 = infidelity5;
load('CRAB_newton6.mat')
Z6 = infidelity6;
iter6 = 1:length(infidelity6);

%%


width = 3.3;     % Width in inches
height = 2.4;    % Height in inches
alw = 0.5;    % AxesLineWidth
fsz = 8;      % Fontsize
fsz1=7;
lw = 0.1;      % LineWidth
msz = 6;       % MarkerSize
%time=5*t;

%%


%
% iter = 1:5001;
figure();
semilogy(iter1,Z1,'b', 'LineWidth', lw,'Color','m');
hold on
semilogy(iter2,Z2,'b', 'LineWidth', lw,'Color','m');
hold on
semilogy(iter3,Z3,'b', 'LineWidth', lw,'Color','m');
hold on
semilogy(iter4,Z4, 'b', 'LineWidth', lw,'Color','m');
hold on
semilogy(iter5,Z5, 'b', 'LineWidth', lw,'Color','m');
hold on
semilogy(iter6, Z6,'b', 'LineWidth', lw,'Color','m');
% title('(a)')

xlim([0 40]);
ylim([1e-2 1e0]);

title('(d)')
xlabel('iterations');
ylabel('infidelity')

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


set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');

left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);
% print('Infidelities-Krotov+GRAPE','-dpng','-r900');
% print('Infdelities-Krotov+GRAPE','-depsc2','-r900');

print('Infidelities-CRAB_Newton','-dpng','-r900');
print('Infdelities-CRAB_Newton','-depsc2','-r900');

