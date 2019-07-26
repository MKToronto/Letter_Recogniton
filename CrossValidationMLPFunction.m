function accuracy = CrossValidationMLPFunction(XTRAIN, YTRAIN, XTEST, YTEST, LayerOneNeurons, LayerTwoNeurons, muincrease, mudecrease)
    
    %take cpu time at start of procedure
    t = cputime;
    
    %create network
    net = feedforwardnet([LayerOneNeurons LayerTwoNeurons]);
    
    % Set network to use Levenberg-Marquardt backpropagation
    net.trainFcn = 'trainlm';
    
    % MSE goal
    net.trainParam.goal = 0;
    
    % mu increase factor
    net.trainParam.mu_inc = muincrease;
    
    % mu decrease factor
    net.trainParam.mu_dec = mudecrease;
    
    %train network
    net = train(net, XTRAIN', YTRAIN');
    
    %obtain the mean squared error
    y = net(XTRAIN');
    mse = perform(net, YTRAIN', y);
    
    %test the network using testing set
    testY = net(XTEST');
     
    %put testing results into a 1x1173 matrix with classes 1-9
    testingresults = vec2ind(testY);
    %put actual results of testing set into a 1x1173 matrix with classes 1-9
    trueresults = vec2ind(YTEST');

    %Calculate classification performance of neural network on testing set
    cp = classperf(trueresults, testingresults);
    
    %calculate cpu time taken to run procedure
    e = cputime-t;

    %return accuracy
    accuracy = [cp.CorrectRate mse e]; 
 
end