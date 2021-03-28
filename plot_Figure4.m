clear;clc
%% the origiral setting
page_width = 18; page_height = 18;
fig = figure('Units','centimeters',...
    'position',[0 0 page_width page_height],...
    'PaperPosition',[0 0 page_width page_height],...
    'color',[1 1 1]);
xstart = 0.19;ystart = 0.15;width =0.6; height = 0.3;
epsx =0.11;  epsy = 0;nrow = 2;ncol =1;
pos = zeros(nrow*ncol,4);
for r = 1:nrow
    for c = 1:ncol
        n = (r-1)*ncol+c;
        pos(n,1) = xstart + (c-1)*width + (c-1)*epsx;
        pos(n,2) = 1 - (ystart + r*height + (r-1)*epsy);
        pos(n,3) = width;
        pos(n,4) = height;
    end
end

%%  boxplot
ax(1) = axes('Position',pos(1,:),'Color','none');
set(ax(1),'XLim',[0 8],'XTick',1:1:7,'YLim',[0.95 1.05],'YTick',0.95:0.025:1.05,...
    'yticklabel',{'-30','-15','0','50','100'},...
    'xticklabel',{'West','Center','East','','','',''},...
    'fontname','Arial','fontsize',9,'FontWeight','normal');
hold on
load('Fig4a.mat')

%
vert = [0.8, west_prctile20; 1.2, west_prctile20; 1.2, west_prctile80; 0.8, west_prctile80];
patch('Faces',[1,2,3,4],'Vertices',vert,'FaceColor',[253,209,209]./255,'EdgeColor',[253,209,209]./255);
vert = [0.8, west_prctile40; 1.2, west_prctile40; 1.2,west_prctile60; 0.8, west_prctile60];
patch('Faces',[1,2,3,4],'Vertices',vert,'FaceColor',[253,141,143]./255,'EdgeColor',[253,141,143]./255);
plot([0.78,1.22],[west_mean, west_mean],'-','color','w','LineWidth',1.5)
plot([0.8,1.2],[west_prctile50, west_prctile50],'-','color','r','LineWidth',1.5)
plot([0.9,1.1],[west_prctile95, west_prctile95],'-','color','k','LineWidth',1)
plot([0.9,1.1],[west_prctile5 ,west_prctile5],'-','color','k','LineWidth',1)
plot([1,1],[west_prctile80,west_prctile95],'-','color','k','LineWidth',1)
plot([1,1],[west_prctile20,west_prctile5],'-','color','k','LineWidth',1)

%
vert = [1.8,central_prctile20;2.2,central_prctile20;2.2,central_prctile80;1.8,central_prctile80];
patch('Faces',[1,2,3,4],'Vertices',vert,'FaceColor',[254,223,191]./255,'EdgeColor',[254,223,191]./255);
vert = [1.8, central_prctile40; 2.2, central_prctile40; 2.2, central_prctile60; 1.8, central_prctile60];
patch('Faces',[1,2,3,4],'Vertices',vert,'FaceColor',[242,121,81]./255,'EdgeColor',[242,121,81]./255);
plot([1.78,2.22],[central_mean,central_mean],'-','color','w','LineWidth',1.5)
plot([1.8,2.2],[central_prctile50 ,central_prctile50],'-','color',[215,45,44]/255,'LineWidth',1.5)
plot([1.9,2.1],[central_prctile95, central_prctile95],'-','color','k','LineWidth',1)
plot([1.9,2.1],[central_prctile5, central_prctile5],'-','color','k','LineWidth',1)
plot([2,2],[central_prctile80, central_prctile95],'-','color','k','LineWidth',1)
plot([2,2],[central_prctile20, central_prctile5 ],'-','color','k','LineWidth',1)

%
vert = [2.8, east_prctile20; 3.2, east_prctile20; 3.2, east_prctile80; 2.8, east_prctile80];
patch('Faces',[1,2,3,4],'Vertices',vert,'FaceColor',[138,218,253]/255,'EdgeColor',[138,218,253]/255);
vert = [2.8,east_prctile40;3.2,east_prctile40;3.2,east_prctile60;2.8,east_prctile60];
patch('Faces',[1,2,3,4],'Vertices',vert,'FaceColor',[26,155,252]/255,'EdgeColor',[26,155,252]/255);
plot([2.8,3.2],[east_prctile50,east_prctile50],'-','color','b','LineWidth',1.3)
plot([2.75,3.25],[east_mean,east_mean],'-','color','w','LineWidth',1.3)
plot([2.9,3.1],[east_prctile95,east_prctile95],'-','color','k','LineWidth',1)
plot([2.9,3.1],[east_prctile5,east_prctile5],'-','color','k','LineWidth',1)
plot([3,3],[east_prctile80,east_prctile95],'-','color','k','LineWidth',1)
plot([3,3],[east_prctile20,east_prctile5],'-','color','k','LineWidth',1)
ylabel({'Projected changes in {\itD_{ClmT}} (m)'},'fontsize',9,'fontname',...
    'Arial','color','k','FontWeight','normal','ROtation',90 );
%
yLim = get(gca,'YLim');
axe_leny = yLim(2) -yLim(1);
xLim = get(gca,'XLim');
axe_leny2 = xLim(2)-xLim(1);
text(xLim(1)+0.05*axe_leny2,yLim(1) + 0.93*axe_leny,'A',...
    'FontSize',12,'fontname','Arial','color','k','FontWeight','bold');
box on
a = ax(1);
set(a,'box','off','color','none')
b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
axes(a)
set(gca,'Layer','top')

ax(2) = axes('Parent',fig);
ax(2).Position = pos(1,:);
set(ax(2),'YAxisLocation','right','Color','none','XColor','none','YColor','k',...
    'xlim',get(ax(1),'xlim'),'xtick',[],'box','off','XColor','k');
hold on
set(ax(2),'layer','top') 

set(ax(2),'XLim',[0 8],'XTick',1:1:7,'YLim',[0 160],'YTick',0:40:160,...
    'yticklabel',{'0','40','80','120','160'},...
    'xticklabel',{'','','','','West','Center','East'},...
    'fontname','Arial','fontsize',9,'FontWeight','normal');
plot([4,4],[0,160],'--','color',[0.8 0.8 0.8],'LineWidth',1)
load('Fig4a2.mat')

vert = [4.8, west_prctile20; 5.2, west_prctile20; 5.2, west_prctile80; 4.8, west_prctile80];
patch('Faces',[1,2,3,4],'Vertices',vert,'FaceColor',[253,209,209]./255,'EdgeColor',[253,209,209]./255);
hold on
vert = [4.8, west_prctile40; 5.2, west_prctile40; 5.2,west_prctile60; 4.8, west_prctile60];
patch('Faces',[1,2,3,4],'Vertices',vert,'FaceColor',[253,141,143]./255,'EdgeColor',[253,141,143]./255);
plot([4.78,5.22],[west_mean, west_mean],'-','color','w','LineWidth',1.5)
plot([4.8,5.2],[west_prctile50, west_prctile50],'-','color','r','LineWidth',1.5)
plot([4.9,5.1],[west_prctile95, west_prctile95],'-','color','k','LineWidth',1)
plot([4.9,5.1],[west_prctile5 ,west_prctile5],'-','color','k','LineWidth',1)
plot([5,5],[west_prctile80,west_prctile95],'-','color','k','LineWidth',1)
plot([5,5],[west_prctile20,west_prctile5],'-','color','k','LineWidth',1)

vert = [5.8,central_prctile20;6.2,central_prctile20;6.2,central_prctile80;5.8,central_prctile80];
patch('Faces',[1,2,3,4],'Vertices',vert,'FaceColor',[254,223,191]./255,'EdgeColor',[254,223,191]./255);
hold on
vert = [5.8, central_prctile40; 6.2, central_prctile40; 6.2, central_prctile60; 5.8, central_prctile60];
patch('Faces',[1,2,3,4],'Vertices',vert,'FaceColor',[242,121,81]./255,'EdgeColor',[242,121,81]./255);
plot([5.78,6.22],[central_mean,central_mean],'-','color','w','LineWidth',1.5)
plot([5.8,6.2],[central_prctile50 ,central_prctile50],'-','color',[215,45,44]/255,'LineWidth',1.5)
plot([5.9,6.1],[central_prctile95, central_prctile95],'-','color','k','LineWidth',1)
plot([5.9,6.1],[central_prctile5, central_prctile5],'-','color','k','LineWidth',1)
plot([6,6],[central_prctile80, central_prctile95],'-','color','k','LineWidth',1)
plot([6,6],[central_prctile20, central_prctile5 ],'-','color','k','LineWidth',1)

vert = [6.8, east_prctile20; 7.2, east_prctile20; 7.2, east_prctile80; 6.8, east_prctile80];
patch('Faces',[1,2,3,4],'Vertices',vert,'FaceColor',[138,218,253]/255,'EdgeColor',[138,218,253]/255);
vert = [6.8,east_prctile40;7.2,east_prctile40;7.2,east_prctile60;6.8,east_prctile60];
patch('Faces',[1,2,3,4],'Vertices',vert,'FaceColor',[26,155,252]/255,'EdgeColor',[26,155,252]/255);
plot([6.8,7.2],[east_prctile50,east_prctile50],'-','color','b','LineWidth',1.3)
plot([6.75,7.25],[east_mean,east_mean],'-','color','w','LineWidth',1.3)
plot([6.9,7.1],[east_prctile95,east_prctile95],'-','color','k','LineWidth',1)
plot([6.9,7.1],[east_prctile5,east_prctile5],'-','color','k','LineWidth',1)
plot([7,7],[east_prctile80,east_prctile95],'-','color','k','LineWidth',1)
plot([7,7],[east_prctile20,east_prctile5],'-','color','k','LineWidth',1)

ylabel({'Projected changes in tree-limit (m)'},'fontsize',9,'fontname',...
    'Arial','color','k','FontWeight','normal','ROtation',90 );

text(7.4,east_prctile5,'5^{th}','fontsize',9,'fontname','Arial','color','k','FontWeight','normal')
text(7.4,east_prctile95,'95^{th}','fontsize',9,'fontname','Arial','color','k','FontWeight','normal')
text(7.4,east_prctile60,'60^{th}','fontsize',9,'fontname','Arial','color','k','FontWeight','normal')
text(7.4,east_prctile40,'40^{th}','fontsize',9,'fontname','Arial','color','k','FontWeight','normal')

text(6.2,east_prctile80,'80^{th}','fontsize',9,'fontname','Arial','color','k','FontWeight','normal')
text(6.2,east_prctile20,'20^{th}','fontsize',9,'fontname','Arial','color','k','FontWeight','normal')
text(6.03,east_mean,'Mean','fontsize',9,'fontname','Arial','color','k','FontWeight','normal')
text(6.2,east_prctile50-10,'50^{th}','fontsize',9,'fontname','Arial','color','k','FontWeight','normal')

% the origiral setting
page_width = 18; page_height = 18;
fig = figure('Units','centimeters',...        
    'position',[0 0 page_width page_height],...
    'PaperPosition',[0 0 page_width page_height],...
    'color',[1 1 1]);
xstart = 0.1;ystart = 0.1;
height = 0.3; width =height*60/30; epsx = 0;  epsy = 0;   
nrow = 2;ncol =2;
pos = zeros(nrow*ncol,4);
for r = 1:nrow
    for c = 1:ncol
        n = (r-1)*ncol+c;
        pos(n,1) = xstart + (c-1)*width + (c-1)*epsx; pos(n,2) = 1 - (ystart + r*height + (r-1)*epsy);
        pos(n,3) = width; pos(n,4) = height;
    end
end
pos2(1,1) = pos(1,1) +width/2;
pos2(1,2) = pos(1,2) +height/2+0.01;
pos2(1,3) =width/13*5;
pos2(1,4) =height/7*3;
ax(1)= axes('Position',pos(1,:),'Color','none');
load('DistributionReCal6.mat')
Change211(isnan(Change211)) = Change311(isnan(Change211));
Change111([54,2]) = nan;
Change311([54,2]) = nan;
Ele([54,2]) = nan;
Change111(isnan(Change111)) = [];
Change311(isnan(Change311)) = [];
Ele(isnan(Ele)) = [];

ax(3)= axes('Position',pos(3,:),'Color','none');
%% plot 1 for frequency
load('RedPurple.mat')
cmap = cmap(1:50:250,:);cmap = flip(cmap,1);
cmap = [cmap(1,:);cmap(3,:);cmap(5,:)];
cmap = [255,222,94;252,174,94;213,61,77];
cmap = [255,242,150;252,174,94;211,63,77];
cmap = flip(cmap,1);

%
[n,x]=hist(Change111*100,0:10:90);
[n1,x]=hist(Change311*100,0:10:90);
h =bar(x',[n',n1'],0.8);
hold on
set(h(1),'FaceColor',cmap(1,:)/255,'FaceAlpha',1,'EdgeColor','none','EdgeAlpha',0.4)
set(h(2),'FaceColor',cmap(2,:)/255,'FaceAlpha',1,'EdgeColor','none','EdgeAlpha',0.4)
xlabel('Potential habitat loss in eastern Himalaya (%)','Fontname','Arial','FontSize',9,'FontWeight','normal')
ylabel('Number of species','Fontname','Arial','FontSize',9,'FontWeight','normal')

set(ax(3),'Ylim',[0 70],'Ytick',0:20:60,'Fontname','Arial','FontSize',9,'FontWeight','normal')
yLim = get(gca,'YLim');
axe_leny = yLim(2) -yLim(1);
xLim = get(gca,'XLim');
axe_leny2 = xLim(2)-xLim(1);
text(xLim(1)+0.04*axe_leny2,yLim(1) + 0.93*axe_leny,'B','FontSize',12,'fontname','Arial','color','k','FontWeight','bold');

box off
axes('position',ax(1).Position,'box','on','ytick',[],'xtick',[],'color','none')
set(ax(3),'layer','top') 

ax(3)= axes('Position',pos(2,:),'Color','none');
set(ax(3),'Xlim',[0 1],'Ylim',[0 1],'Fontname','Arial','FontSize',9,'FontWeight','normal')
len = 0.25;
start = 0.5
rectangle('Position',[0.05 start  0.1 0.05],'FaceColor',cmap(1,:)/255,'EdgeColor','none');
rectangle('Position',[0.05 start-len  0.1 0.05],'FaceColor',cmap(2,:)/255,'EdgeColor','none');
text(0.1, start-0.1,'no dispersal','horizontalalignment','center','Fontname','Arial','FontSize',9,'FontWeight','normal')
text(0.1, start-0.1-len,'full dispersal', 'horizontalalignment','center','Fontname','Arial','FontSize',9,'FontWeight','normal')
axis off

% subplot3
ax(4)= axes('Position',pos2(1,:),'Color','none');
inc = [0;300;600];
clear n
for i = 1:size(inc,1)
    if i ==size(inc,1)
        indexEle = find(Ele >=inc(i));
    else
        indexEle = find(Ele >=inc(i) & Ele<inc(i+1));
    end
    freqplot = Change311(indexEle);
    n(i,1) = nanmean(freqplot)*100;
    e(i,1) = nanstd(freqplot)*100;
    freqplot1 = Change111(indexEle);
    n(i,2) = nanmean(freqplot1)*100;
    e(i,2) = nanstd(freqplot1)*100;
end
h1 = barh(8,n(1,1)',0.6,'EdgeColor','none','FaceColor',cmap(1,:)/255,'FaceAlpha',1);
hold on
h11 = errorbar(n(1,1),8,e(1,1),'horizontal','Color','k','CapSize',2)

h5 = barh(7,n(1,2)',0.6,'EdgeColor','none','FaceColor',cmap(2,:)/255,'FaceAlpha',1);
errorbar(n(1,2),7,e(1,2),'horizontal','Color','k','CapSize',2)

h2 = barh(5,n(2,1)',0.6,'EdgeColor','none','FaceColor',cmap(1,:)/255,'FaceAlpha',0.75)
errorbar(n(2,1),5,e(2,1),'horizontal','Color','k','CapSize',2)
h6 = barh(4,n(2,2)',0.6,'EdgeColor','none','FaceColor',cmap(2,:)/255,'FaceAlpha',0.75)
errorbar(n(2,2),4,e(2,2),'horizontal','Color','k','CapSize',2)
h3 = barh(2,n(3,1)',0.6,'EdgeColor','none','FaceColor',cmap(1,:)/255,'FaceAlpha',0.5);
errorbar(n(3,1),2,e(3,1),'horizontal','Color','k','CapSize',2)
h7 = barh(1,n(3,2)',0.6,'EdgeColor','none','FaceColor',cmap(2,:)/255,'FaceAlpha',0.5);
errorbar(n(3,2),1,e(2,2),'horizontal','Color','k','CapSize',2)
set(ax(4),'Xlim',[0 100],'Xtick',0:20:80,'Ytick',[1.5,4.5,7.5],'Yticklabel',{'<300','300¨C600','>600'},'Fontname','Arial','FontSize',9,'FontWeight','normal')
ylabel({'Elevational', 'range size (m)'},'Fontname','Arial','FontSize',9,'FontWeight','normal')
xlabel('Mean loss (%)','Fontname','Arial','FontSize',9,'FontWeight','normal')
box off
axes('position',ax(2).Position,'box','on','ytick',[],'xtick',[],'color','none')
set(ax(4),'layer','top') 