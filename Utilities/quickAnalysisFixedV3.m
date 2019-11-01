%% quickly plot fixed plate data based on settings in setAnalysisParam_this;
mkdir('figures');
clear;
setAnalysisParam_parent;
allPeaks = getAllPeaks;
[singleCellsNoTimeDim allCells conditionArray] = allPeaks2singleCellsNoTimeDim(allPeaks);
singleCellsNoTimeDim2Plots( singleCellsNoTimeDim, allCells, conditionArray );
disp('Plots Complete');