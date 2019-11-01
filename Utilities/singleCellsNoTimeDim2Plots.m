function [ output_args ] = singleCellsNoTimeDim2Plots( singleCellsNoTimeDim, allCells, conditionArray )
%singleCells2Plots generates a few plots to quickly look at singleCells
%dataset

%filterHigh discards outliers above thresh filterHigh

filterHigh = 10;
%   
global analysisParam;
% format time
lineWidth = 3;
mkdir(analysisParam.figDir);
% get ratios
colors = distinguishable_colors(analysisParam.nCon);

for iCon = 1:analysisParam.nCon;
    %for iTime = find(~cellfun('isempty', singleCellsNoTimeDim{iCon}))
        R = singleCellsNoTimeDim{iCon}(:,6)./singleCellsNoTimeDim{iCon}(:,5);
    GFP(iCon) = meannonan(singleCellsNoTimeDim{iCon}(:,6));
    RFP(iCon) = meannonan(singleCellsNoTimeDim{iCon}(:,5));
    nuc2nucMeans(iCon) = meannonan(R(R<filterHigh)); % find means of ratios less than filterHigh
    nuc2nucStd(iCon) = stdnonan(R(R<filterHigh)); % 
    nCells(iCon) = size(R(R<filterHigh),1);
    nuc2nucSEM(iCon) = nuc2nucStd(iCon)./sqrt(nCells(iCon));
    GFPstd(iCon) = stdnonan(singleCellsNoTimeDim{iCon}(:,6));
    RFPstd(iCon) = stdnonan(singleCellsNoTimeDim{iCon}(:,5));
    GFPsem(iCon) = GFPstd(iCon)./nCells(iCon);
    RFPsem(iCon) = RFPstd(iCon)./nCells(iCon);
   % end
end

save('singleCellMeansAndError.mat','nuc2nucMeans','nuc2nucStd','nCells','nuc2nucSEM','GFP','RFP','GFPstd','RFPstd','GFPsem','RFPsem');



figure; clf; hold on;
set(gcf, 'DefaultLineLineWidth', 'factory');
%% plot #cells
subplot(2,2,1); hold on;
bar(nCells);
ylabel('# cells');
title('detected cells');

%% plot GFP

subplot(2,2,2); hold on;
boxplot(allCells(:,6),conditionArray,'plotstyle','compact');
ylabel('nuc GFP');
title('GFP');

subplot(2,2,3); hold on;
boxplot(allCells(:,5),conditionArray,'plotstyle','compact');
ylabel('nuc RFP');
title('RFP');

subplot(2,2,4); hold on;
boxplot(allCells(:,6)./allCells(:,5),conditionArray,'plotstyle','compact');
ylabel('nuc GFP:RFP');
title('GFP:RFP');

% subplot(2,3,3); hold on;
% errorbar(GFP,GFPstd,'r.','LineWidth',lineWidth);
% errorbar(GFP,GFPsem,'g.','LineWidth',lineWidth);
% title('mean GFP');
% legend('STD of cells','SEM of cells');
% 



% subplot(2,3,6); hold on;
% errorbar(nuc2nucMeans,nuc2nucStd,'r.','LineWidth',lineWidth);
% errorbar(nuc2nucMeans,nuc2nucSEM,'g.','LineWidth',lineWidth);
% title('mean GFP:RFP');
% legend('STD of cells','SEM of cells');
% 

savefig([analysisParam.figDir filesep 'wells.fig']);
singleCellsNoTimeDim2TimePlots;

end

