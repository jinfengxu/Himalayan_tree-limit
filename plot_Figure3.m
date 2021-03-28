clear;clc
%% the origiral setting
page_width = 18; page_height = 18;
fig = figure('Units','centimeters',...
    'position',[0 0 page_width page_height],...
    'PaperPosition',[0 0 page_width page_height],...
    'color',[1 1 1]);
xstart = 0.23;ystart = 0.1;
width = 0.32; height =0.765;
epsx = 0.075+0.01;  epsy = 0.08;
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
ax(1) = axes('Position',pos(1,:),'Color','none');

[data,~] = xlsread('Imp.xlsx');
varible = flipud(data(:,1));
Xd = 1:1:20;
Yd = varible;
ACDbar=barh(Xd,Yd,0.65);
ACDbar.FaceColor = 'flat';
ACDbar.EdgeColor ='flat';
%% color map
black = [0.85,0.85,0.85];
blue = [0,112,193]/255;
red = [255,0,0]/255;
yellow = [255,217,102]/255;
green = [120,200,255]/255;
ACDbar.CData(1,:) = blue;ACDbar.CData(2,:) = black;
ACDbar.CData(3,:) = red;ACDbar.CData(4,:) = blue;
ACDbar.CData(5,:) = black;ACDbar.CData(6,:) = blue;
ACDbar.CData(7,:) = yellow;ACDbar.CData(8,:) = black;
ACDbar.CData(9,:) = yellow;ACDbar.CData(10,:) = yellow;
ACDbar.CData(11,:) = yellow;ACDbar.CData(12,:) = red;
ACDbar.CData(13,:) = yellow;ACDbar.CData(14,:) = yellow;
ACDbar.CData(15,:) = blue;ACDbar.CData(16,:) = blue;
ACDbar.CData(17,:) = blue;ACDbar.CData(18,:) = blue;
ACDbar.CData(19,:) = red;ACDbar.CData(20,:) = blue;

Y_label = {'Climate water deficit',...
    'Anthropogenic disturbance',...
    'Vapor pressure deficit',...
    'Summer desiccation',...
    'Cloud cover',...
    'T_{min} of coldest month',...
    'Total nitrogen density',...
    'Cation exchange capacity',...
    'Earthquake',...
    'Clay content',...
    'Total phosphorus',...
    'Soil bulk density',...
    'Aspect',...
    'pH',...
    'Number of nights below zero',...
    'Slope',...
    'Winter frost',...
    'Fire',...
    'Surface curvature',...
    'Extreme low temperature '
    };

Y_label = fliplr(Y_label);
set(ax(1),'YLim',[0 21],'YTick',1:1:20,'xLim',[0 70],...
    'XTick',10:10:60,'FontSize',9,'Fontname','Arial',...
    'YTickLabel',Y_label);
xlabel('Relative importance (%IncMSE)','FontSize',9,'fontname',...
    'Arial','color','k')
yLim = get(gca,'YLim');
axe_leny = yLim(2) -yLim(1);
xLim = get(gca,'XLim');
axe_leny2 = xLim(2)-xLim(1);
text(xLim(1)+0.89*axe_leny2,yLim(1) + 0.97*axe_leny,'A',...
    'FontSize',11,'fontname','Arial','color','k','FontWeight','bold');

%%
scale = 1.3;
r1 = rectangle('Position',[20 1.8+3*scale 8 0.65],'FaceColor',blue);
r1.EdgeColor  = blue;
text(30,2.13+3*scale,'Climatic limitation',...
    'FontSize',9,'fontname','Arial','color','k')
r2 = rectangle('Position',[20 1.8+2*scale 8 0.65],'FaceColor',red);
r2.EdgeColor  = red;
text(30,2+2.13*scale,'Disturbance','FontSize',9,'fontname','Arial','color','k')
r3 = rectangle('Position',[20 1.8+scale 8 0.65],'FaceColor',black);
r3.EdgeColor  = black;
text(30,2.13+scale,{'Topography'},'FontSize',9,'fontname','Arial','color','k')
r4 = rectangle('Position',[20 1.8 8 0.65],'FaceColor',yellow);
r4.EdgeColor  = yellow;
text(30,2.13,'Soil','FontSize',9,'fontname','Arial','color','k')
a = ax(1);
set(a,'box','off','color','none')
b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
axes(a)
set(gca,'Layer','top')

%% plot line chart
[X,~] =xlsread('variableX.csv');
[Y,~] = xlsread('variableY.csv');
[K,~] =xlsread('variableK.csv');

%% the origiral setting
xstart = 0.6 ;ystart = 0.1;
width = 0.32;height = 0.2;
epsx = 0.06;epsy = 0.0823;
nrow = 3;ncol =1;
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
for I=2:4
    ax(I-1) =axes('Parent',fig);
    ax(I-1).Position = pos(I-1,:);
    CWD_X = X(:,I-1);
    CWD_Y = Y(:,I-1);
    CWD_K = K(:,I-1);
    index_std = std(CWD_Y); index_mean = mean(CWD_Y);
    index_ann = find(CWD_Y>(index_mean+3*index_std) | ...
        CWD_Y<(index_mean-3*index_std));
    if I<3
        [~,in]=sort(CWD_X);
        CWD_XK=[CWD_X(in),  CWD_K(in)];
        CWD_XK(:,1)=smooth(CWD_XK(:,1),200);
        CWD_XK(:,2)=smooth(CWD_XK(:,2),200);
    else
        [~,in]=sort(CWD_X);
        CWD_XK=[CWD_X(in),  CWD_K(in)];
        CWD_XK(:,1)=smooth(CWD_XK(:,1),200);
        CWD_XK(:,2)=smooth(CWD_XK(:,2),200);
    end
    box on
    
    if I==2
        CWD_XK2 = CWD_XK(:,2);
        scatter(CWD_X, CWD_Y,30,blue,'filled' ,'MarkerFaceAlpha',.01);
        hold on
        plot(CWD_XK(:,1),CWD_XK2,'color',[1 1 1],'LineWidth',3.5)
        plot(CWD_XK(:,1),CWD_XK2,'color',blue,'LineWidth',1.2)
        set(gca,'XLim',[0 100],'xtick',0:20:100,'xticklabel',...
            {'0','60','120','180','240','300'},...
            'fontsize',9,'fontname','Arial')
        set(gca,'YLim',[-500 500],'ytick',-400:200:400,...
            'fontsize',9,'fontname','Arial',...
            'TickLength',[0.015, 0])
        box on
        xlabel('Climate water deficit (mm year^{-1})',...
            'FontSize',9,'fontname','Arial','color','k')
        ylabel({'Contribution to {\itD_{ClmT}} (m)'},...
            'FontSize',9,'fontname','Arial','color','k')
        set(ax(I-1),'YAxisLocation','right')
        
        yLim = get(gca,'YLim');
        axe_leny = yLim(2) -yLim(1);
        xLim = get(gca,'XLim');
        axe_leny2 = xLim(2)-xLim(1);
        text(xLim(1)+0.05*axe_leny2,yLim(1) + 0.87*axe_leny,...
            'B','FontSize',11,'fontname','Arial',...
            'color','k','FontWeight','bold');
        a = ax(I-1);
        set(a,'box','off','color','none')
        b = axes('Position',get(a,'Position'),'box','on','xtick',[],'ytick',[]);
        axes(a)
        set(gca,'Layer','top')
    end
    
    if I==3
        scatter(CWD_X, CWD_Y,30,red,'filled' ,'MarkerFaceAlpha',.01);
        hold on
        plot(CWD_XK(:,1),CWD_XK2,'color',[1 1 1],'LineWidth',3.5)
        plot(CWD_XK(:,1),CWD_XK2,'color',red,'LineWidth',1.2)
        set(gca,'XLim',[0 15],'xtick',0:3:15,...
            'fontsize',9,'fontname','Arial')
        set(gca,'YLim',[-500 500],'ytick',...
            -400:200:400,'fontsize',9,'fontname','Arial',...
            'TickLength',[0.015, 0])
        box on
        xlabel('Anthropogenic disturbance','FontSize',...
            9,'fontname','Arial','color','k')
        ylabel({'Contribution to {\itD_{ClmT}} (m)'},...
            'FontSize',9,'fontname','Arial','color','k')
        set(ax(I-1),'YAxisLocation','right')
        yLim = get(gca,'YLim');
        axe_leny = yLim(2) -yLim(1);
        xLim = get(gca,'XLim');
        axe_leny2 = xLim(2)-xLim(1);
        text(xLim(1)+0.05*axe_leny2,yLim(1) + 0.87*axe_leny,'C',...
            'FontSize',11,'fontname','Arial','color','k',...
            'FontWeight','bold');
        a = ax(I-1);
        set(a,'box','off','color','none')
        b = axes('Position',get(a,'Position'),...
            'box','on','xtick',[],'ytick',[]);
        axes(a)
        set(gca,'Layer','top')
    end
    
    if I==4
        scatter(CWD_X, CWD_Y,30,blue,'filled' ,'MarkerFaceAlpha',.01);
        hold on
        plot(CWD_XK(:,1),CWD_XK(:,2),'color',[1 1 1],'LineWidth',3.5)
        plot(CWD_XK(:,1),CWD_XK(:,2),'color',blue,'LineWidth',1.2)
        set(gca,'XLim',[0.1 1.1],'xtick',0.1:0.2:1.1,...
            'fontsize',9,'fontname','Arial')
        set(gca,'YLim',[-500 500],'ytick',-400:200:400,...
            'fontsize',9,'fontname','Arial',...
            'TickLength',[0.015, 0])
        box on
        xlabel('Vapor pressure deficit (hPa)',...
            'FontSize',9,'fontname','Arial','color','k')
        ylabel({'Contribution to {\itD_{ClmT}} (m)'},...
            'FontSize',9,'fontname','Arial','color','k')
        set(ax(I-1),'YAxisLocation','right')
        
        yLim = get(gca,'YLim');
        axe_leny = yLim(2) -yLim(1);
        xLim = get(gca,'XLim');
        axe_leny2 = xLim(2)-xLim(1);
        text(xLim(1)+0.05*axe_leny2,yLim(1) + 0.87*axe_leny,...
            'D','FontSize',11,'fontname','Arial',...
            'color','k','FontWeight','bold');
        a = ax(I-1);
        set(a,'box','off','color','none')
        b = axes('Position',get(a,'Position'),...
            'box','on','xtick',[],'ytick',[]);
        axes(a)
        set(gca,'Layer','top')
    end
end