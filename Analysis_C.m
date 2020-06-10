%% plot bar graph of all
meanResults=mean(globalResults.meanAccuracy);
figure,hold on,bar([1:63],meanResults);
set(gca(),'XTick',[0:5:60],'FontSize',20);
grid on;
ylabel('Out-of-Sample Accuracy');
xlabel('Combination');
ylim([25 68]);
xlim([0 65]);


%% plot individual ones
n=1;bar(n,meanResults(n),'y'); % sex
n=2;bar(n,meanResults(n),'k'); % Aetiology
n=4;bar(n,meanResults(n),'r'); % CMCT
n=8;bar(n,meanResults(n),'m'); % SEP
n=16;bar(n,meanResults(n),'c'); % Imaging
n=32;bar(n,meanResults(n),'g'); % Baseline
%legend('combinations','Sex','Aetiology','CMCT','SEP','Imaging','Baseline');

