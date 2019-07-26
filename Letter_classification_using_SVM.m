%% Description
% This script takes the letter classification dataset and trains a
% support vecotr machine.
% The data is split and shuffled using indices created in the Letter_classification_using_feedforward_network.m
% script. THat script needs to be run before this script can be run.

% The letter dataset can be found at:
% http://archive.ics.uci.edu/ml/machine-learning-databases/letter-recognition/letter-recognition.data


%% Clear variables

clear all, close all, clc, format compact

%% Download data

filename = 'http://archive.ics.uci.edu/ml/machine-learning-databases/letter-recognition/letter-recognition.data'
fid = urlread(filename);

%filename = 'C:/Users/Simon.suthers/OneDrive - City, University of London/Core Modules/Neural Computing/Coursework/Letter Recognition/letter-recognition_test.txt'
%fid = fopen(filename);

A = textscan(fid, '%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'delimiter', ',');
fclose('all');

%convert data to 2 matrices
%input data
X1 = cell2mat(A(2:17));
%target
T1 = A{1,1};

%sort data by alphabetical order
[sortedT1,IX] = sort(T1);
sortedX1 = X1(IX,:);

%remove all rows greater than the letter J
%set letter to remove
remove = 'J';
%remove all rows greater than the letter J
sortedX1(cellfun(@(x) x > remove, sortedT1),:) = [];
sortedT1(cellfun(@(x) x > remove, sortedT1),:) = [];

%rename final matrices
x1 = sortedX1;
t1 = sortedT1;

clearvars -except x1 t1

%% Standardize inputs to mean=0 and variance=1

[pn,ps1] = mapstd(x1);

x1 = pn;

clearvars pn ps1

fprintf('Data standardized\n');

%% Split test data from record set

% Get testing indices from
% Letter_classification_using_feedforward_network.m file
fid = fopen('testindices.dat','r');
datacell = textscan(fid, '%f', 'delimiter', ',');
fclose(fid);
testind = datacell{1};

% split out testing set
testX = x1(testind,:);
testT = t1(testind,:);

clear fid datacell ans testind

% Get training indices from
% Letter_classification_using_feedforward_network.m file
% This will randomly sort the data
fid = fopen('trainindices.dat','r');
datacell = textscan(fid, '%f', 'delimiter', ',');
fclose(fid);
trainind = datacell{1};

% split out training set
trainX = x1(trainind,:);
trainT = t1(trainind,:);

clear fid datacell ans x1 t1 testind trainind



%% Train the ECOC classifier optimizing the hyper-paramters

%set optimizehyperparameters to true if setting hyperparamters
%WARING - this takes almost 30 minutes to run if set to true
optimizehyperparameters = false;

%Get size of matrix
%This is used later on in the confusion matrix
n = size(trainX, 1);
isLabels = unique(trainT);
nLabels = numel(isLabels);

% Create an SVM template
% See https://uk.mathworks.com/help/stats/templatesvm.html
t = templateSVM('Standardize',1,'BoxConstraint',1,'KernelScale',1,'KernelFunction','gaussian');


if optimizehyperparameters == true
    
    fprintf('Optimizing hyper-parameters\n');
    
    %Set hyperparameters for optimization
    % See https://uk.mathworks.com/help/stats/fitcecoc.html
    params = hyperparameters('fitcecoc',trainX,trainT,'svm');
    %coding
    params(1).Range = {'onevsone','onevsall'};
    params(1).Optimize = true;
    %BoxConstraint
    params(2).Range = [0.01,1];
    %Kernel Scale
    params(3).Range = [0.01,1];
    %KernelFunction
    params(4).Range = {'gaussian','linear'};
    params(4).Optimize = true;

    Mdl = fitcecoc(trainX,trainT,...
        'OptimizeHyperparameters',params,...
        'Coding','onevsall',...
        'learners',t,...
        'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName','expected-improvement-plus',...
                                                'Optimizer','gridsearch',...
                                                'ShowPlots',true,...
                                                'NumGridDivisions',3));

    T = Mdl.HyperparameterOptimizationResults;
    
    %Export results to excel
    filename = 'SVMHyperparameterOptimizationResults.xlsx';
    writetable(T,filename,'Sheet',1,'Range','A1');
    
    clear T
else
    
    fprintf('Training model with set hyper-parameters\n');
    % Train the ECOC classifier. It is good practice to specify the class order.
    Mdl = fitcecoc(trainX,trainT,'Learners',t,'ClassNames',isLabels,'Coding','onevsone');
end

Mdl.HyperparameterOptimizationResults

% Cross-validate Mdl using 10-fold cross-validation.
CVMdl = crossval(Mdl);

% Predict labels of training set.
[oofLabel] = kfoldPredict(CVMdl);

% tidy up variable names
clear t params optimizehyperparameters

%% See cost
% True Misclassification Cost per Class
% Cost is 0 if correct and 1 if incorrect, average cost per run

% Return mse for each fold in a vector
% returns the mean squared error between the predictions compared to the true responses
% A mse nearer 0 is preferred
% see https://uk.mathworks.com/help/stats/classificationpartitionedmodel.kfoldloss.html#bswic2v-2
oofLoss = kfoldLoss(CVMdl,'folds',[1:10],'mode','individual');

% Get mean accuracy across 10 folds
MeanAccuracy = mean(oofLoss);

fprintf('Mean loss error: %f\n', MeanAccuracy);

clear oofLoss MeanAccuracy

%% See coding status of model

% Display the class names used
Mdl.ClassNames
% Display the coding design matrix used for multi class SVM
t = Mdl.CodingMatrix
% 1 indicates that fitcecoc trained the SVM using observations in the corresponding class as members of the positive group.
% -1 indicates that fitcecoc trained the SVM using observations in the corresponding class as members of the negative group.
% 0 indicates that the SVM did not use observations in the corresponding class.

% Number of SVMs
fprintf('Number of SVMs: %d\n', size(Mdl.CodingMatrix,2));

%% Create confusion matrix for training results

% Convert labels from prediction to vector to a class-identifier matrix
[~,grp] = ismember(oofLabel,isLabels); 
labelsMat = zeros(nLabels,n); 
idxLinear = sub2ind([nLabels n],grp,(1:n)'); 
labelsMat(idxLinear) = 1; % Flags the row corresponding to the class 
clear grp idxLinear

% Convert labels from known data set to vector to a class-identifier matrix
[~,grp] = ismember(trainT,isLabels); 
testTMat = zeros(nLabels,n); 
idxLinear = sub2ind([nLabels n],grp,(1:n)'); 
testTMat(idxLinear) = 1; % Flags the row corresponding to the class
clear grp idxLinear

%Create an array for axis labels
chartlabels = isLabels;
chartlabels{11,1} = []; 

clear grpOOF grpT1 idxLinearT1 idxLinear

%Show confusion matrix
fig = figure;
plotconfusion(testTMat,labelsMat);
h = gca;
h.XTickLabel = chartlabels;
h.YTickLabel = chartlabels;

fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 6 6];
print(fig,'SVMConfusionTrainingSet','-dpng','-r0')

clear testTMat labelsMat h chartlabels fig

%% Test SVM on testing record set

% Use model trained from 10 fold cross validated model

%record how long it takes to test the SVM
t = cputime;
    
[label,score] = predict(Mdl,testX);

%calculate cpu time taken to test SVM
e = cputime-t;

fprintf('Time second to test model (seconds): %f\n', e);

table(testT(1:45),label(1:45),score(1:45,2),'VariableNames',...
    {'TrueLabel','PredictedLabel','Score'})



clear score e t

%% Show confusion matrix of testing data

n = size(testX, 1);

% Convert labels from prediction to vector to a class-identifier matrix
[~,grptestOOF] = ismember(label,isLabels); 
testTMat = zeros(nLabels,n); 
idxtestLinear = sub2ind([nLabels n],grptestOOF,(1:n)'); 
testTMat(idxtestLinear) = 1; % Flags the row corresponding to the class 
clear grptestOOF idxtestLinear

% Convert labels from known data set to vector to a class-identifier matrix
[~,grptestT1] = ismember(testT,isLabels); 
labelsMat = zeros(nLabels,n); 
idxtestLinearT1 = sub2ind([nLabels n],grptestT1,(1:n)'); 
labelsMat(idxtestLinearT1) = 1; 
clear grptestT1 idxtestLinearT1

%Create an array for axis labels
chartlabels = isLabels;
chartlabels{11,1} = []; 

clear grpOOF grpT1 idxLinearT1 idxLinear

%Show confusion matrix
fig = figure;
plotconfusion(testTMat,labelsMat);
h = gca;
h.XTickLabel = chartlabels;
h.YTickLabel = chartlabels;

fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 6 6];
print(fig,'SVMConfusionTestingSet','-dpng','-r0')

clear h chartlabels fig

%% Create chart showing resultset

% Get testing data PCA from FeedForward file
fid = fopen('testPCAData.dat','r');
datacell = textscan(fid, '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'delimiter', ',');
fclose(fid);
testpca = cell2mat(datacell);

clear fid datacell

% Retrun vector that splits results into 4 categories:
% Correctly labelled letter
% Correctly not labelled letter
% Incorrectly labelled letter
% Incorrectly not labelled letter
results = [testT label];

fig = DrawResultsClassificationChart(results, testpca);
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 9 7];
print(fig,'SVMResultsTrellis','-dpng','-r0')

clear results fig

%% Create chart showing resultset

% Get testing data PCA from FeedForward file
fid = fopen('testPCAData.dat','r');
datacell = textscan(fid, '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'delimiter', ',');
fclose(fid);
TestSetPCA = cell2mat(datacell);

clear fid datacell

fig = ClassificationChartForTestingresults(TestSetPCA(:,1), TestSetPCA(:,2), label, testT, 'NorthOutside');
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 10 10];
print(fig,'SVMResultsTrellis','-dpng','-r0')

clear TestSetPCA fig
