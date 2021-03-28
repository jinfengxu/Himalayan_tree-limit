clear;clc
%% the origiral setting
page_width = 18; page_height = 18;
fig = figure('Units','centimeters',...
    'position',[0 0 page_width page_height],...
    'PaperPosition',[0 0 page_width page_height],...
    'color',[1 1 1]);
xstart = 0.15;ystart = 0.2;height = 0.2455; width =0.724;
epsx = 0.075+0.01;epsy = 0.08;nrow = 2;ncol =1;
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

%% plot map

ax(1) = axes('Position',pos(1,:),'Color','none');
set(ax(1) ,'XColor','k','YColor','k','xlim',[74.67 95.44],...
    'ylim',[27.23 34],'ytick',28:2:34,...
    'Fontname','Arial','fontsize',9,'FontWeight','normal',...
    'yticklabel',{'28\circN','30\circN','32\circN','34\circN'},...
    'xticklabel',{'75\circE','80\circE','85\circE','90\circE','95\circE'});

ylabel('Latitude','FontSize',9,'fontname','Arial','color','k')
xlabel('Longitude','FontSize',9,'fontname','Arial','color','k')
Fig2a_pattern = imread('Fig2a.tif');

imshow(Fig2a_pattern)

color_red = imread('Fig2a_colorbar.mat');
R = double(color_red(15,:,1));
G = double(color_red(15,:,2));
B = double(color_red(15,:,3));
cmap = [R',G',B']./255;
colormap(cmap);

caxis([3000,5000]);
Color_bar=colorbar;
Color_bar.Location = 'north';
Color_bar.Ticks = 3200:200:4800; 
Color_bar.TickLabels = {'<3200','3400','3600',...
    '3800','4000','4200','4400','4600','>4800'};
Color_bar.FontSize = 9;
xlabel(Color_bar,{'Tree-limit elevation (m)'},'FontSize',9,...
    'fontname','Arial','color','k','FontWeight','normal');
hold on
limy1 = get(ax(1),'YLim');
limylength =limy1(1,2)- limy1(1,1);
a = gca;
set(a,'box','off','color','none')
b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
axes(a)

%% plot tree-limit on longitude

ax(2) = axes('Position',pos(2,:),'Color','none');
load('Moutain_autitude.mat')
[data,~] = xlsread('Fig2b.xlsx');
longtitude = data(:,1);
actual_elevation = data(:,2);
DclmT = data(:,3);
potentila_elevation = actual_elevation+ppt;
index_lon = unique(longtitude);

for iun = 1:length(index_lon)
    index_elevation = find(longtitude == index_lon(iun));
    index_potential_median(iun) = median(potentila_elevation(index_elevation)); 
    index_potential_sd(iun) = std(potentila_elevation(index_elevation)); 
    index_actual_median(iun) = median(actual_elevation(index_elevation));                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           median(actual_elevation(index_elevation)); %潜在的中值
    index_actual_sd(iun) = std(actual_elevation(index_elevation)); 
end
p1 = smoothdata(index_actual_median,'loess',70);
p2 = smoothdata(index_potential_median,'loess',70);
linewiteh = 1;

ax(2) = axes('Position',pos(2,:),'Color','none');

% mountain shadow
m_s = ones(length(Moutain_autitude),1)';
m_s(:) = 1000;
x_m = (74.67:((95.44-74.67)/1958):95.44);
x_m = x_m(1,2:end);
m_shadow = fill([x_m,fliplr(x_m)],[Moutain_autitude,m_s],[217 212 208]./255);
m_shadow.EdgeColor = 'none';
hold on
plot(x_m,Moutain_autitude,'-','color',[217 212 208]./255,'LineWidth',linewiteh)

% potential treeline
p_shadow = fill([index_lon',fliplr(index_lon')],...
    [p2+index_potential_sd,fliplr(p2-index_potential_sd)],'r');
p_shadow.EdgeColor = 'none';
hold on
plot(index_lon,p2,'-','color','r','LineWidth',linewiteh)
hold on

% tree-limit
a_shadow = fill([index_lon',fliplr(index_lon')],...
    [p1+index_actual_sd,fliplr(p1-index_actual_sd)],[0.5 0.5 0.5]);
a_shadow.EdgeColor = 'none';
hold on
plot(index_lon,p1,'-','color','k','LineWidth',linewiteh)
hold on
alpha(0.15)
set(ax(1) ,'XColor','k','YColor','k','xlim',[74.67 95.44],...
    'ylim',[1000 6000],'ytick',1500:1000:5500,...
    'Fontname','Arial','fontsize',9,'FontWeight','normal',...
    'yticklabel',{'1500','2500','3500','4500','8500'},...
    'xticklabel',{'75\circE','80\circE','85\circE','90\circE','95\circE'});
ylabel('Treeline elevation (m)')
xlabel('Longitude')
plot([90 91.1],[3300 3300],'color',[217 212 208]/255,'LineWidth',linewiteh);
text(91.3,3300,'Mountain peak','FontSize',9,'FontName','Arial')
plot([90 91.1],[2900 2900],'color','r','LineWidth',linewiteh);
text(91.3,2900,'\itClmT','FontSize',9,'FontName','Arial')
plot([90 91.1],[2500 2500],'color','k','LineWidth',linewiteh);
text(91.3,2500,'\itActT','FontSize',9,'FontName','Arial')
plot([90 91.1],[2100 2100],'color',[33,83,255]/255,'LineWidth',linewiteh);
text(91.3,2000,'\itD_{ClmT}','FontSize',9,'FontName','Arial')

%%
hold on
limy1 = get(ax(1),'YLim');
limylength =limy1(1,2)- limy1(1,1);
a = gca;
set(a,'box','off','color','none')
b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
axes(a)
ax(2) = axes('Parent',fig);
ax(2).Position = pos(1,:);
s = 300;
hold on
Dclmt = p2-p1;

%% bar
index_bar = 75:0.5:95;
for il = 2:length(index_bar)
index_longetitude = find(index_lon>=index_bar(il-1) & index_lon<=index_bar(il));
bar_result(il-1) = nanmean(Dclmt(index_longetitude));
bar_std(il-1) = std(Dclmt(index_longetitude));
end
columnbar = bar(index_bar(2:end)-0.2,bar_result,0.8);
columnbar.FaceColor = 'flat';
columnbar.EdgeColor = 'none';
for i = 1:length(bar_result)
    columnbar.CData(i,:) = [33,83,255]/255;
end
hold on
set(ax(2),'YAxisLocation','right','Color','none','XColor','none',...
    'YColor',[33,83,255]/255,...
    'xlim',get(ax(1),'xlim'),'xtick',[],'box','off','XColor','k');
limy2 = get(ax(2),'YLim');
limylength =limy2(1,2)- limy2(1,1);
set(ax(2),'YLim',[0 3500],'FontSize',9,'ytick',0:400:800,...
    'yticklabel',{'0','400','800','','','','','','','','','','','',''})% 
hold on
yy = ylabel({'{\itD_{ClmT}} (m)'},'FontSize',9);
