%% 
% Cite xxx
% Written by Syed Ahmar Shah, June 2020

%% clear workspace and load data
clc;clear all;
load DummyData; % please not that the data is not real (see the paper on how to request access to the original data)
data=DummyData;

%% Select the data (acquired dystonia or primary dystonia)

IR=find((data.Aetiology)~='1'&(data.Aetiology)~='2'); % all acquired dystonia cases
%IR=find((data.Aetiology)=='1'| (data.Aetiology)=='2'); % all primary dystonia cases

%%
tic,Analysis_B,toc
mean(globalResults.meanAccuracy)
max(globalResults.meanAccuracy(:,1))
max(globalResults.meanAccuracy(:,2))
Analysis_C

% draw reference line
refline=100*length(find(data_sel.Improvement=='1'))/(length(find(data_sel.Improvement=='1'))+length(find(data_sel.Improvement=='0')));
hold on,plot((0:63),ones(64,1)*refline,'--r');
