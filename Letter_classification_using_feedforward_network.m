%% Description
% This script takes the letter classification dataset and trains a
% multi-layered perceptron.
% Two grid searches can be performed to opitmize the hyper-parameters

% The letter dataset can be found at:
% http://archive.ics.uci.edu/ml/machine-learning-databases/letter-recognition/letter-recognition.data

%% Clear current variables

close all, clear all, clc, format compact

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

sortedT1 = grp2idx(sortedT1);

%remove all rows greater than 10
remove = 10;

sortedX1(sortedT1>remove,:) = [];
sortedT1(sortedT1>remove,:) = [];

x1 = transpose(sortedX1);

%create results vector - this vector has a row for each category
t1category = full(ind2vec(transpose(sortedT1),remove));
%create results vector - this vector is a binary vector of each category
% see https://uk.mathworks.com/matlabcentral/newsreader/view_thread/59792
t1binary = dec2bin(transpose(sortedT1)) - '0';
t1binary = transpose(t1binary);
%keep categories for use later
t1labels = sortedT1;

clearvars -except x1 t1category t1labels t1binary

%% See how many numbers are in each category

T = cell2table(tabulate(categorical(t1labels)),'VariableNames',{'Letter','Number','Percentage'})

%Export results to excel
filename = 'CategoryData.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1')

clear T filename

%% Standardize inputs to mean=0 and variance=1

[pn,ps1] = mapstd(x1);

%rename data
x1_standardised = pn;

clearvars pn ps1 x1

%% Create scatter plot of data using PCA

%do not remove any rows for the exercise
maxfrac = 0;
% process inputs with principal component analysis
[Y,PS] = processpca(x1_standardised,maxfrac);

Y1 = transpose(Y);

%plot data onto scatter plot
labels = transpose(mat2cell(transpose(char(t1labels + 64)), 1, ones(size(t1labels,1), 1)));

fig1 = figure
gscatter(Y1(:,1),Y1(:,2),labels)
grid on
xlabel('pca1');
ylabel('pca2');
title('Letter classification');

% Save plot to file
fig1.PaperUnits = 'inches';
fig1.PaperPosition = [0 0 6 4];
print(fig1,'AllTrueResults','-dpng','-r0')


%plot data onto sub plots of scatter plot
fig = DrawLetterClassificationChart(Y1, t1labels);
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 9 7];
print(fig,'AllTrueResultsTrellis','-dpng','-r0')


clearvars -except x1_standardised t1category t1labels t1binary Y1

%% Quickly test neural network on data

vals = TestNeuralNetwork(x1_standardised, t1category);
fprintf('Percentage correct Classification : %f%%\n', vals * 100);
clear vals;

%% Split data manually into training and testing sets
% The testing set will be used later to compare with a second model

%number of data points
N = size(x1_standardised, 2); %7648 columns

%sort the data randomly and split
ind0 = randperm(N);
% or for testing sort the data then split:
%ind0 = 1:N;

k = 0.85;
M = floor(N*k);

trnind = [1:M];
tstind = [1+M:N];

trainind = ind0(trnind); 
testind = ind0(tstind);

trainX = x1_standardised(:,trainind);
trainTCategory = t1category(:,trainind);
trainTBinary = t1binary(:,trainind);


% Save train indices and test indices to file
% these indices can be used in the SVM file
csvwrite('testindices.dat',testind);
csvwrite('trainindices.dat',trainind);

% Save testing rows of PCA to file. this is used later to plot the results
% of the testing set to a chart
TestSetPCA = Y1(testind',:);

csvwrite('testPCAData.dat',TestSetPCA);

clear k M N ind0 trnind tstind trainind Y1

%% Draw testing results on chart
%plot data onto sub plots of scatter plot

testLabels = t1labels(testind',:);

fig = DrawLetterClassificationChart(TestSetPCA, testLabels);
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 9 7];
print(fig,'TestingTrueResults','-dpng','-r0')

%% Quickly test neural network on data

vals = TestNeuralNetwork(trainX, trainTCategory);
fprintf('Percentage correct Classification : %f%%\n', vals);
clear vals;

%% Create grid for grid search to find optimum layer size
% There are two grid searches created in this script. This grid search
% looks at various sizes of neurons in layer 1. The next grid search optimizes 
% the hyper-parameters.
% Both grid searches can be used in the "Train neural network using cross
% validation" section


numberoflayers = [2];
numberofneuronsinlayerone = [10 20 30 40 50];
numberofneuronsinlayertwo = [10];
mudecrease = [0.1];
muincrease = [5];

a = {numberoflayers, numberofneuronsinlayerone, numberofneuronsinlayertwo, muincrease, mudecrease};
gridsearch = combvec(a{:}).';

clear a

a = [1:size(gridsearch, 1)]';
gridsearch = [gridsearch, a];

clear a numberoflayers numberofneuronsinlayerone numberofneuronsinlayertwo muincrease mudecrease ResultSetToUse


%% Create grid for grid search to optimize hyper-parameters
% This grid search is used to optimize the hyper-paramters
% Use either this grid seach, or the grid search above.

numberoflayers = [2];
numberofneuronsinlayerone = [10 20 30];
numberofneuronsinlayertwo = [10 20];
mudecrease = [0.01 0.1];
muincrease = [5 10];

a = {numberoflayers, numberofneuronsinlayerone, numberofneuronsinlayertwo, muincrease, mudecrease};
gridsearch = combvec(a{:}).';

clear a

a = [1:size(gridsearch, 1)]';
gridsearch = [gridsearch, a];

clear a numberoflayers numberofneuronsinlayerone numberofneuronsinlayertwo muincrease mudecrease ResultSetToUse

%% Train neural network using cross validation

% Matrix for storing the results of all the runs
results = [];

%loop through each row in grid search to find optimum settings for neural
%network
for idx = 1:size(gridsearch, 1)
%for idx = 1:3
    
    % number of nuerons in layer 1
    LayerOneNeurons = gridsearch(idx, 2);
    
    % number of nuerons in layer 2
    LayerTwoNeurons = gridsearch(idx, 3);
    
    %set mu increase factor
    muincrease = gridsearch(idx, 4);
    
    %set mu decrease factor
    mudecrease  = gridsearch(idx, 5);
    
    vals = crossval(@(XTRAIN, YTRAIN, XTEST, YTEST)CrossValidationMLPFunction(XTRAIN, YTRAIN, XTEST, YTEST, LayerOneNeurons, LayerTwoNeurons, muincrease, mudecrease), trainX', trainTCategory', 'kfold', 5);
    
    %get average accuracy from each of the folds of cross validation
    accuracy = mean(vals(:,1));
    mse = mean(vals(:,2));
    timeelapsed = mean(vals(:,3));
    
    result = [gridsearch(idx,:), accuracy, mse, timeelapsed]
    
    % add result row to results matrix
    results=[results;result];
    
    fprintf('Finished results for row : %d\n', idx);
        
end 

% Export results to excel
T = array2table(results,'VariableNames',{'Layers',...
    'LayerOneNeurons','LayerTwoNeurons',...
    'muincrease','mudecrease'...
    'RowNumber','accuracy','mse','timeelapsed'})

%Export results to excel
%File name used when searching to optimize hyper-parameters
filename = 'FeedForwardGridSearchResults.xlsx';
%File name used when looking at layer size
%filename = 'FeedForwardLayerSizeResults.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1');

clear LayerOneNeurons LayerTwoNeurons LearningRate Momentum idx accuracy result vals filename T

%% Plot line chart for neuron layer size
% This chart is used to show how the MSE for the model reduces with more
% neurons.
% It is used with the first grid search searchning layer size.
% It cannot be used with the second grid search for optimizing
% hyper-parameters.

fig = figure;
yyaxis left
plot(results(:,2),results(:,8),'-o','MarkerIndices',1:1:5)
title('Perfomance of increasing neurons in layer 1')
xlabel('Number of neurons')
xticks(results(:,2))
ylabel('Mean Squared Error')
ylim([0 inf])

yyaxis right
plot(results(:,2),results(:,9),'-o','MarkerIndices',1:1:5)
ylabel('Time (seconds)')


fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 12 8];
print(fig,'NeuronLayerSizeChart','-dpng','-r0')

clear fig

%% Find best model from the Grid Serach and build a neural network on that model

% Load results from excel (saved in section above)
filename = 'FeedForwardGridSearchResults.xlsx';
results = xlsread(filename);

% Get row with the best accuracy
[BestAccuracy,i1] = max(results(:,7));
[BestMse,i2] = min(results(:,8));
BestResults = results(i2,:);

fprintf('Best accuracy is: %f%%\nBest accuracy in row: %d\n', BestAccuracy*100, i1);
fprintf('Best mse is: %f\nBest mse in row: %d\n', BestMse, i2);

clear i1 BestAccuracy i2 BestMse filename

%% Create feedforward neural network using best results from hyper-paramter optimization
% https://uk.mathworks.com/matlabcentral/answers/68563-k-fold-cross-validation-neural-networks

% number of nuerons in layer 1
LayerOneNeurons = BestResults(2);

% number of nuerons in layer 2
LayerTwoNeurons = BestResults(3);

% create a neural network
net = feedforwardnet([LayerOneNeurons LayerTwoNeurons]);

% mu increase factor
net.trainParam.mu_inc = BestResults(4); 

% mu decrease factor
net.trainParam.mu_dec = BestResults(5);

% set validation set for early stopping parameters
net.divideParam.trainRatio = 0.9; % training set [%]
net.divideParam.valRatio = 0.1; % validation set [%]
net.divideParam.testRatio = 0; % test set [%]

% train a neural network
[net,tr] = train(net,trainX,trainTCategory);

% show net
view(net)

fig = plotperform(tr);
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 4 3];
print(fig,'TestingFeedForwardEpochValidation','-dpng','-r0')

clear fig LayerOneNeurons LayerTwoNeurons

%% Test the network

testX = x1_standardised(:,testind);
testT = t1category(:,testind);

%record how long it takes to test the MLP
t = cputime;

%Test Y returns the probabilities of each categrory
testY = net(testX);

%calculate cpu time taken to test MLP
e = cputime-t;

fprintf('Time second to test network (seconds): %f\n', e);

%The vec2ind function returns the row with the highest value
testingresults = vec2ind(testY);
trueresults = vec2ind(testT);

clear t e

%% Get results from network after testing

%Get mean squared error
%https://uk.mathworks.com/help/nnet/ref/mse.html
mse = perform(net, testT, testY);

% Get accuracy
[c,cm] = confusion(testT,testY);

fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);
fprintf('MSE : %f\n', mse);

clear mse c cm

%% Get accuracy

cp = classperf(trueresults, testingresults);
fprintf('Percentage accuracy : %f%%\n', cp.CorrectRate * 100);

clear cp

%% Plot confusion matrix

%Create an array for axis labels
chartlabels = {'A','B','C','D','E','F','G','H','I','J'};
chartlabels{1,11} = []; 

%Show confusion matrix
figure;
fig = plotconfusion(testT,testY);
h = gca;
h.XTickLabel = chartlabels;
h.YTickLabel = chartlabels;

% Save confusion matrix to png
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 6 6];
print(fig,'FeedFowardConfusionMatrix','-dpng','-r0')

clear fig chartlabels h

%% Show reciver operator curve

plotroc(testT,testY)

%% Put results onto chart
% Retrun vector that splits results into 4 categories:
% Correctly labelled letter
% Correctly not labelled letter
% Incorrectly labelled letter
% Incorrectly not labelled letter

trueresultslabels = transpose(mat2cell(char(trueresults + 64), 1, ones(size(trueresults',1), 1)));
testingresultslabels = transpose(mat2cell(char(testingresults + 64), 1, ones(size(testingresults',1), 1)));

fig = ClassificationChartForTestingresults(TestSetPCA(:,1), TestSetPCA(:,2), trueresultslabels, testingresultslabels, 'NorthOutside');
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 10 10];
print(fig,'MLPResultsTrellis','-dpng','-r0')

clear results fig
clear trueresultslabels testingresultslabels correct






