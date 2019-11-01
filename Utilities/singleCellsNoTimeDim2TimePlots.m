

%singleCellsNoTimeDim2TimePlots groups conditions by variable and time
%   conditionGroups is an MxN matrix whose values correspond to the
%   treatment time (x axis). M = number of groups, N = timepoints in series
setAnalysisParam_this;
global analysisParam

load('singleCellMeansAndError.mat');
[B,I] = sort(analysisParam.conditionGroups,2);



nuc2nucMeans = reshape(nuc2nucMeans,[4,2])';
nuc2nucStd = reshape(nuc2nucStd,[4,2])';
nuc2nucSEM = reshape(nuc2nucSEM,[4,2])';
nCells = reshape(nCells,[4,2])';


%% Plot nuc2nucMeans w/ Std and Sem
figure; clf;
for ii = 1:size(nuc2nucMeans,1);
    subplot(2,1,1); hold on;
errorbar(B(ii,:),nuc2nucMeans(ii,I(1,:)),nuc2nucStd(ii,I(1,:)))
subplot(2,1,2); hold on;
errorbar(B(ii,:),nuc2nucMeans(ii,I(1,:)),nuc2nucSEM(ii,I(1,:)))
end
subplot(2,1,1);
title('errorbar = STD of cells');
ylabel('nuc GFP:RFP');
legend(analysisParam.groupNames,'Location','Best');
subplot(2,1,2);
ylabel('nuc GFP:RFP');
xlabel(['hours ' analysisParam.ligandName]);
title('errorbar = SEM of cells');

savefig([analysisParam.figDir filesep 'nuc2nucMeans.fig']);

%% normalize to first timepoint
figure; clf;

for ii = 1:size(nuc2nucMeans,1);
    subplot(2,1,1); hold on;

    sigmaz = QuotientError( nuc2nucMeans(ii,I(1,:)),nuc2nucMeans(ii,I(1,1)),nuc2nucStd(ii,I(1,:)),nuc2nucStd(ii,I(1,1)) );
errorbar(B(ii,:),nuc2nucMeans(ii,I(1,:))./nuc2nucMeans(ii,I(1,1)),sigmaz)

subplot(2,1,2); hold on;
errorbar(B(ii,:),nuc2nucMeans(ii,I(1,:))./nuc2nucMeans(ii,I(1,1)),sigmaz./sqrt(nCells(ii,:)))
end
subplot(2,1,1);
title('errorbar = STD of cells');
ylabel('nuc GFP:RFP:t=0');
subplot(2,1,2);
title('errorbar = SEM of cells');
legend(analysisParam.groupNames,'Location','Best');

ylabel('nuc GFP:RFP:t=0');
xlabel(['hours ' analysisParam.ligandName]);
savefig([analysisParam.figDir filesep 'nuc2nucMeans2firstTimepoint.fig']);


