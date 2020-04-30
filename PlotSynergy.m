function PlotSynergy(EMG,Synergy_temp,Ch_name,Syn_num)

EMGColor        =   [   0.8    0       0;
                        0      0.4     0;
                        0.08	0.17	0.7;
                        0.9    0.8	   0 ;
                        0      0.75    0.75;
                        1      0       1 ;
                        0.4    0.4     0.4;
                        0.08	0.17	0.55;   % dark blue
                        0       0.4     0;      % dark green
                        0.6     0.2     0;      % dark red
                        0.04	0.52	0.78;   % dark cyan
                        0.75	0       0.75;	% dark magenta
                        0.68	0.47	0;      % dark yellow
                        0.37    0.15    0.07];  % dark brown

SynColor        =   [   0.08	0.07	0.95;   % blue
                        0       0.8     0;      % green
                        0.9     0.1     0;      % red
                        0.04	0.82	0.88;   % cyan
                        0.95	0       0.95;	% magenta
                        0.78	0.77	0;      % yellow
                        0.5     0.12    0.12];  % brown

c_grey = [0.7 0.7 0.7];
Fig_Name = [pwd '\'];
N_ch = length(Ch_name);
%% Synergy Timeprofile and Vector
C = length(Synergy_temp.W_ave(1,:));

hfig1           =   figure;
set(gcf,'Position', get(0,'ScreenSize')),

% plot Synergy_temp.W_ave
for j = 1:C
    subplot(C,1,j)
    barh(flipud(Synergy_temp.W_ave(:,j)),'FaceColor',SynColor(j,:),'EdgeColor','w'),
    axis([0 1.2*max(max(Synergy_temp.W_ave)) 0.5 N_ch+0.5]),
    set(gca,'YTick',1:N_ch,'YTickLabel',fliplr(Ch_name)),
    box off,
end
set(gcf,'PaperPositionMode','auto');
%print(hfig1,'-dbmp',[Fig_Name 'W_' Syn_num]);
%print(hfig1,'-depsc',[Fig_Name 'W_' Syn_num]);
%% plot averaged EMG and the reshaped EMG
hfig2           =   figure;
xSize_i  = 3; 
ySize_i  = 5;
xLeft_i  = 0;
yTop_i   = 0;
set(hfig2, 'Units', 'inches');  %  'centimeters'
set(hfig2, 'Position', [xLeft_i yTop_i xSize_i ySize_i]);
set(hfig2, 'PaperUnits', 'inches');  %  'centimeters'
set(hfig2, 'PaperPosition', [xLeft_i yTop_i xSize_i ySize_i]);
% plot EMG
for j = 1:N_ch
    subplot(N_ch,1,j)
    hold on, plot([0 0],[0 0], 'Color',EMGColor(j,:),'LineWidth',2)
    hold on, plot([0 0],[0 0], 'Color',c_grey,'LineWidth',1)
    hold on, plot(EMG.ReconstructMean(j,:), 'Color',EMGColor(j,:),'LineWidth',2)
    %ylim([-0.01 0.1]);
    legend1 = Ch_name{j};
    legend( legend1 )
    set(legend,'Box','off'),
    set(gca, 'Fontname', 'Calibri', 'Fontsize', 8,'FontWeight','bold','box','off'...
                ,'LineWidth',1,'XColor',c_grey,'YColor',c_grey);
end
set(gcf,'PaperPositionMode','auto');
%print(hfig2,'-dbmp',[Fig_Name 'Reconstructed_EMG_' Syn_num]);
%print(hfig2,'-depsc',[Fig_Name 'Reconstructed_EMG_' Syn_num]);

% plot reshaped EMG
hfig3           =   figure;
xSize_i  = 3;  
ySize_i  = 5; 
xLeft_i  = 0;
yTop_i   = 0;
set(hfig3, 'Units', 'inches');  %  'centimeters'
set(hfig3, 'Position', [xLeft_i yTop_i xSize_i ySize_i]);
set(hfig3, 'PaperUnits', 'inches');  %  'centimeters'
set(hfig3, 'PaperPosition', [xLeft_i yTop_i xSize_i ySize_i]);
for j = 1:N_ch
    subplot(N_ch,1,j)
    hold on, plot([0 0],[0 0], 'Color',EMGColor(j,:),'LineWidth',2)
    hold on, plot([0 0],[0 0], 'Color',c_grey,'LineWidth',1)    
    hold on, plot(EMG.CustomWave(j,:), 'Color',EMGColor(j,:),'LineWidth',2)
    %ylim([-0.01 0.1]);
    legend1 = Ch_name{j};
    legend( legend1 )
    set(legend,'Box','off'),
    set(gca, 'Fontname', 'Calibri', 'Fontsize', 8,'FontWeight','bold','box','off'...
                ,'LineWidth',1,'XColor',c_grey,'YColor',c_grey);
end

set(gcf,'PaperPositionMode','auto');
%print(hfig3,'-dbmp',[Fig_Name 'Reshaped_EMG_' Syn_num]);
%print(hfig3,'-depsc',[Fig_Name 'Reshaped_EMG_' Syn_num]);
