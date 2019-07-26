%% Classification of 26 letters
% This code follows the example at:
% https://uk.mathworks.com/help/nnet/examples/wine-classification.html

%% Clear current variables

close all, clear all, clc, format compact

%% Open Data

%filename = 'C:/Users/User/OneDrive - City, University of London/Core Modules/Neural Computing/Coursework/Letter Recognition/letter-recognition.txt'
filename = 'C:/Users/User/OneDrive - City, University of London/Core Modules/Neural Computing/Coursework/Letter Recognition/letter-recognition.txt'


fid = fopen(filename);
A = textscan(fid, '%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'delimiter', ',');
fclose(fid);

x1 = transpose(cell2mat(A(2:17)));

T1 = grp2idx(A{1,1})';
t1 = full(ind2vec(T1,26)) 

clear T1 fid A filename ans

%% Tidy the data

%% Set neural network

%Need to use feedforwardnet for multi-layer perceptron
%Need to use second algorithm for comparison
%Try different numbers of hodden layers
%Try different numbers of neurons

net = patternnet([10 5]);
view(net)

%% Train the neural network

[net,tr] = train(net,x1,t1);
nntraintool

%% Show performance during training

plotperform(tr)

%% Test the network

testX = x1(:,tr.testInd);
testT = t1(:,tr.testInd);

%Test Y returns the probabilities of each categrory
testY = net(testX);

%The vec2ind function returns the row with the highest value
testIndices = vec2ind(testY)

%% Plot confusion matrix

plotconfusion(testT,testY)

%% Print overall percentages of correct and incorrectg classifications

[c,cm] = confusion(testT,testY);

fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);

%% Show reciver operator curve

plotroc(testT,testY)

%% Work out how to do cross validation






