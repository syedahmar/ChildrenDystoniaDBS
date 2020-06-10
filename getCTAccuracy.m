function [Mdl,results]=getCTAccuracy(data_sel,categoricalPredictors,minLeafSize,FoldNumbers)
%% train model
%Mdl = fitctree(data_sel,'Improvement','CategoricalPredictors',categoricalPredictors,'MinLeafSize',minLeafSize,'SplitCriterion','gdi');
Mdl = fitctree(data_sel,'Improvement','CategoricalPredictors',categoricalPredictors,'MinLeafSize',minLeafSize);
Y_estimated=double(Mdl.predict(data_sel));
Y_actual=double(data_sel.Improvement);
NC=length(find((Y_estimated-Y_actual)==0));
NNC=length(find((Y_estimated-Y_actual)~=0));
%view(Mdl,'Mode','Graph');
AccuracyForAll=((NC)/(NC+NNC)*100);
InSampleAccuracy=confusionmat(Y_actual,Y_estimated);
senspe_is.TN_IS=InSampleAccuracy(1);
senspe_is.TP_IS=InSampleAccuracy(4);
senspe_is.FN_IS=InSampleAccuracy(2);
senspe_is.FP_IS=InSampleAccuracy(3);
%% cross validate to get the cross-validation error
cv_object=cvpartition(data_sel.Improvement,'k',FoldNumbers);
cvmodel = crossval(Mdl,'CVPartition',cv_object);
Y_estimated_val=double(kfoldPredict(cvmodel));

% let us also evaluate the performance in each fold (to get an idea of
% variability in accuracy)

for kfold=1:cv_object.NumTestSets
    IT=find(cv_object.test(kfold));
    NC=length(find((Y_estimated_val(IT)-Y_actual(IT))==0));
    NNC=length(find((Y_estimated_val(IT)-Y_actual(IT))~=0));
    AccuracyFolds(kfold,1)=((NC)/(NC+NNC)*100);
end

OutSampleAccuracy=confusionmat(Y_actual,Y_estimated_val);
(OutSampleAccuracy(1)+OutSampleAccuracy(4))/(sum(sum(OutSampleAccuracy)))*100;
senspe_os.TN_OS=OutSampleAccuracy(1);
senspe_os.TP_OS=OutSampleAccuracy(4);
senspe_os.FN_OS=OutSampleAccuracy(2);
senspe_os.FP_OS=OutSampleAccuracy(3);


results.accuracyfolds=AccuracyFolds;
results.meanAccuracy=mean(AccuracyFolds);
results.accuracyRaw=AccuracyForAll;
results.cvmodel=cvmodel;
results.cv_object=cv_object;
results.senspe_is=senspe_is;
results.senspe_os=senspe_os;
