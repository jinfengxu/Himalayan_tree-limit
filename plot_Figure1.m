clear;clc

%% the origiral setting

page_width = 18; page_height = 18;
fig = figure('Units','centimeters',...
    'position',[0 0 page_width page_height],...
    'PaperPosition',[0 0 page_width page_height],...
    'color',[1 1 1]);
xstart = 0.15;ystart = 0.2;
height = 0.2455; width =0.724;
epsx = 0.075+0.01;epsy = 0.08;   
nrow = 1;ncol =1;
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

Fig1a_pattern = imread('Fig1a.tif');
imshow(Fig1a_pattern)

color_red = imread('Fig1a_colorbar.mat');
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
xlabel(Color_bar,{'Elevation (m)'},'FontSize',9,...
    'fontname','Arial','color','k','FontWeight','normal');

hold on
limy1 = get(ax(1),'YLim');
limylength =limy1(1,2)- limy1(1,1);

a = gca;
set(a,'box','off','color','none')
b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
axes(a)

%% the origiral setting
fig = figure('Units','centimeters',...
    'position',[0 0 page_width page_height],...
    'PaperPosition',[0 0 page_width page_height],...
    'color',[1 1 1]);
xstart = 0.1;ystart = 0.1;width = 0.33;height = 0.33;
epsx = 0.07;epsy = 0.07;
nrow = 1;ncol =2;
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

%% plot scatter
ax(2) = axes('Position',pos(1,:),'Color','none');

load('insitu.mat')
load('East.mat');
East_manually =all_point(:,2);East_Landsat =  all_point(:,1);
load('Center.mat');
Central_manually =result(:,2);Central_Landsat =result(:,1);
load('West.mat');
West_manually =result(:,2);West_Landsat =result(:,1);
manually = East_manually;  Landsat = East_Landsat;
manually(end:end+length(Central_manually)-1,1) = Central_manually;
Landsat(end:end+length(Central_Landsat)-1,1) = Central_Landsat;
manually(end:end+length(West_manually)-1,1) = West_manually;
Landsat(end:end+length(West_Landsat)-1,1) = West_Landsat;

East_box = [East_manually,East_Landsat];
East_manually_data = nan(size(East_box,1),size(East_box,2));
for ih = 2:size(East_box,1)
    East_manually_data(ih,:) = East_box(ih,:)-East_box(ih-1,:);
end
index_East_data = find(East_manually_data(:,1)==0 & East_manually_data(:,2)==0);
East_manually(index_East_data) = [];East_Landsat(index_East_data) = [];

Central_box = [Central_manually,Central_Landsat];
Central_data = nan(size(Central_box,1),size(Central_box,2));
for ih = 2:size(Central_box,1)
    Central_data(ih,:) = Central_box(ih,:)-Central_box(ih-1,:);
end
index_Central_data = find(Central_data(:,1)==0 & Central_data(:,2)==0);
Central_manually(index_Central_data) = [];Central_Landsat(index_Central_data) = [];

West_box = [West_manually,West_Landsat];
West_data = nan(size(West_box,1),size(West_box,2));
for ih = 2:size(West_box,1)
    West_data(ih,:) = West_box(ih,:)-West_box(ih-1,:);
end
index_West_data = find(West_data(:,1)==0 & West_data(:,2)==0);
West_manually(index_West_data) = [];West_Landsat(index_West_data) = [];

box = [manually,Landsat];
data = nan(size(box,1),size(box,2));
for ih = 2:size(box,1)
    data(ih,:) = box(ih,:)-box(ih-1,:);
end
index_z = find(data(:,1)==0 & data(:,2)==0);
manually(index_z) = [];Landsat(index_z) = [];

ft = fittype( 'poly1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = ([Paper_X(2),Paper_Y(2)]);
opts.Robust = 'LAR';
[fitresult, gof] = fit( Paper_X, Paper_Y, ft, opts);
X = (1300:100:5500)';
fdata = feval(fitresult,X);
pl1=plot([2500 5500],[2500 5500],'k--','LineWidth', 0.5);
Pline = plot(X', fdata); %
set(Pline,'color','k','LineWidth',1);
set(gca,'XLim',[2500 5500],'xtick',3000:1000:5000,...
    'YLim',[2500 5500],'ytick',3000:1000:5000,...
    'fontsize',9,'fontname','Arial','TickLength',[0.022, 0]) 

yLim = get(gca,'YLim');
axe_leny = yLim(2) -yLim(1);
xLim = get(gca,'XLim');
axe_leny2 = xLim(2)-xLim(1);

str1 = ['{\itR^{2}} = ',sprintf('%3.2f',gof.rsquare)];
str2 = ['ME = 17'];
str3 = ['Slope = ',sprintf('%3.2f',fitresult.p1)];

text(xLim(1)+0.59*axe_leny2,yLim(1) + 0.3*axe_leny,str1,...
    'FontSize',9,'fontname','Arial','color','k');
text(xLim(1)+0.59*axe_leny2,yLim(1) + 0.2*axe_leny,str2,...
    'FontSize',9,'fontname','Arial','color','k');
text(xLim(1)+0.59*axe_leny2,yLim(1) + 0.1*axe_leny,str3,...
    'FontSize',9,'fontname','Arial','color','k');

hold on
%%
load('point_Color.mat')
for ic = 1:length(Paper_X)
    idex = 3000:50:4800;
    [~,index]=min(abs(idex(:)-Paper_X(ic)));
    h11 = scatter(Paper_X(ic), Paper_Y(ic),20,color(index,:)./255,'filled');
end
yLim = get(gca,'YLim');
axe_leny = yLim(2) -yLim(1);
xLim = get(gca,'XLim');
axe_leny2 = xLim(2)-xLim(1);
text(xLim(1)+0.05*axe_leny2,yLim(1) + 0.93*axe_leny,'B',...
    'FontSize',11,'fontname','Arial','color','k','FontWeight','bold');

ylabel('Landsat-derived tree-limit elevation (m)',...
'FontSize',9,'fontname','Arial','color','k');
xlabel('{\itIn situ} treeline elevation (m)',...
    'FontSize',9,'fontname','Arial','color','k');

a = ax(2);
set(a,'box','off','color','none')
b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
axes(a)
set(gca,'Layer','top')

%% plot heatmap need package scatter_kde 

load('Fig1C.mat')
ax(3) = axes('Position',pos(2,:),'Color','none');
cc = ksdensity([manually,Landsat], [manually,Landsat]);
heatmap = scatter_kde(manually, Landsat, 'filled', 'MarkerSize', 2);
colorC = imread('color_C.png');
colormap(colorC)

[rho,pval] = corr(manually,Landsat);
ft = fittype( 'poly1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = ([manually(2),Landsat(2)]);
opts.Robust = 'LAR';
[fitresult, gof] = fit(manually, Landsat, ft, opts);
X = (1300:100:6000)';
fdata = feval(fitresult,X);
Pline = plot(X', fdata); %
pl1=plot([2500 5500],[2500 5500],'k--','LineWidth', 0.5);
set(Pline,'color','k','LineWidth',1);

set(gca,'XLim',[2500 5500],'xtick',3000:1000:5000,...
    'YLim',[2500 5500],'ytick',3000:1000:5000,'yticklabel',{''},...
    'fontsize',9,'fontname','Arial')

yLim = get(gca,'YLim');
axe_leny = yLim(2) -yLim(1);
xLim = get(gca,'XLim');
axe_leny2 = xLim(2)-xLim(1);

str1 = ['{\itR^{2}} = ',sprintf('%3.2f',gof.rsquare)];
str2 = ['ME = 23'];
str3 = ['Slope = ',sprintf('%3.2f',fitresult.p1)];

text(xLim(1)+0.7*axe_leny2,yLim(1) + 0.3*axe_leny,str1,'FontSize',9,...
    'fontname','Arial','color','k');
text(xLim(1)+0.28*axe_leny2,yLim(1) + 0.2*axe_leny,str2,'FontSize',9,...
    'fontname','Arial','color','k');
text(xLim(1)+0.24*axe_leny2,yLim(1) + 0.1*axe_leny,str3,'FontSize',9,...
    'fontname','Arial','color','k');

hold on
xlabel('Manually-interpreted tree-limit elevation (m)',...
    'FontSize',9,'fontname','Arial','color','k');

limy1 = get(ax(1),'YLim');
limylength =limy1(1,2)- limy1(1,1);

a = gca;
set(a,'box','off','color','none')
b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
axes(a)

%% Colorbar
caxis([0,1]);
bh=colorbar;
bh.Location = 'eastoutside';
bh.Ticks = 0:0.2:1;
bh.TickLabels = {'0','0.2','0.4','0.6','0.8','1.0'};
bh.FontSize = 9;
ylabel(bh,{'Frequency'},'fontsize',9,'fontname','Arial',...
    'color','k','FontWeight','normal','ROtation',90 );