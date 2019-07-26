
%% Quickly test neural network on data
function accuracy = TestNeuralNetwork(x1, t1)

    % create a neural network
    net = feedforwardnet([10 10]);

    % set early stopping parameters
    net.divideParam.trainRatio = 0.8; % training set [%]
    net.divideParam.valRatio = 0.1; % validation set [%]
    net.divideParam.testRatio = 0.1; % test set [%]

    % train a neural network
    [net,tr] = train(net,x1,t1);

    testX = x1(:,tr.testInd);
    testT = t1(:,tr.testInd);

    testY = net(testX);

    testingresults = vec2ind(testY);
    trueresults = vec2ind(testT);

    cp = classperf(trueresults, testingresults);
    
    accuracy = cp.CorrectRate;
end
