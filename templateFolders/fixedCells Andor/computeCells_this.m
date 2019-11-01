% computeCells_this is run after MaxI and Ilastik

%% parameters
clear;
data_direc = 'MaxI';
file_suffix = '.tif'; % may have to make further adjustments if not using andor .tif files
chan = [1 2]; %first value is nuc channel, following contains other channels
paramfile = 'setUserParam_RkoHek20x'; %the paramfile for preprocessing images
positions = [0:199]; %positions to run (assumes andor dataset naming conventions)
%%
computeCellsAndMemChild( data_direc,positions,chan,paramfile );
quickAnalysisFixedV3;


