% generate feature selector matrix here
fselector=de2bi((1:63));
%% look at the data with acquired dystonia only
resCol=7; % column corresponding to improvement
baseLineCol=6;
minLeafSize=10;
nIterations=100;
globalResults=[];
foldNumbers=10;
for kf=1:size(fselector,1)
    ind_cols=find(fselector(kf,:));
    data_sel=data(IR,[ind_cols,resCol]);
    categoricalPredictors=ind_cols(ind_cols~=baseLineCol);
    %globalResults=[];
    for k=1:nIterations
        disp(['Attempting iteration number: ',num2str(k),' in Feature Selection Number: ',num2str(kf)]);
        [Mdl,results]=getCTAccuracy(data_sel,find(categoricalPredictors),minLeafSize,foldNumbers);
        globalResults.meanAccuracy(k,kf)=results.meanAccuracy;
        globalResults.rawAccuracy(k,kf)=results.accuracyRaw;
        globalResults.Model{k,kf}=Mdl;
        globalResults.SelectedMeasures{k,kf}=data_sel.Properties.VariableNames;
        globalResults.CVModel{k,kf}=results.cvmodel;
        globalResults.SenSpe_IS(k,kf)=results.senspe_is;
        globalResults.SenSpe_OS(k,kf)=results.senspe_os;
    end
end
globalResults.SelectedI=IR;
globalResults.minLeafSize=minLeafSize;
globalResults.nIterations=nIterations;
