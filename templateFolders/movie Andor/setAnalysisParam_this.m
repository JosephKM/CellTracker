function setAnalysisParam_this
% for use with quickAnalysis function
global analysisParam;
fprintf(1, '%s called to define params\n',mfilename);

%%compute cells parameters
analysisParam.userParam = 'setUserParam_esi017_20x';
analysisParam.chan = [2 1];
analysisParam.data_direc = 'MaxI';
%% Main analysis parameters
analysisParam.nPos = 64; %total number of positions in dataset
analysisParam.nCon = 8; %total number of separate conditions
analysisParam.tLigandAdded = 1.5; %time ligand added in hours
analysisParam.nMinutesPerFrame = 15; %minutes per frame
analysisParam.ligandName = 'treatment';
analysisParam.yMolecule = 'GFP-beta-catenin';
analysisParam.yNuc = 'RFP-H2B';
analysisParam.conNames = {'well 1';'well 2';'well 3';'well 4';...
                         'well 5';'well 6';'well 7 ';'well 8'};
analysisParam.controlCondition = 1;

%% Shouldn't need to modify below
analysisParam.preLigand = 0;
analysisParam.figDir = 'figures';
analysisParam.outDirec = 'MaxI-Outfiles';
analysisParam.isFixedCells = 0;
analysisParam.isAndorMovie = 1;
analysisParam.outDirecStyle = 1;% 1 for Andor IQ style (i.e., posX.mat) % 2 for Out_ConditionPrefix_X.mat style
 %directory containing outfiles for each position 
analysisParam.nPosPerCon = analysisParam.nPos./analysisParam.nCon; %set how many positions per condition
analysisParam.backgroundPositions = nan; %array of positions for bg subtraction
analysisParam.fig = 20; %set which figure to start plotting at
%find x Axis
% load([analysisParam.outDirec filesep 'pos0.mat']);
% plotX = 0:(length(peaks)-1)*analysisParam.nMinutesPerFrame./60;
% analysisParam.plotX = plotX-analysisParam.tLigandAdded;
positionConditions = zeros(analysisParam.nPosPerCon,analysisParam.nCon);
positionConditions(:) = 0:analysisParam.nPos-1;
analysisParam.positionConditions = positionConditions';
end