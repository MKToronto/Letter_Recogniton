function accuracy = CrossValidationMLPFunction(XTRAIN, YTRAIN, XTEST, YTEST, LayerOneNeurons, LayerTwoNeurons, LearningRate, Momentum)
    
    %create network
    net = feedforwardnet([LayerOneNeurons LayerTwoNeurons]);
    
    % Learning rate
    %net.trainParam.lr = LearningRate; 

    % momentum
    %net.trainParam.mc = Momentum;
    
    %train network
    net = train(net, XTRAIN', YTRAIN');

    yNet = net(XTEST');
    
    %'// find which output (of the three dummy variables) has the highest probability
    [~,classNet] = max(yNet',[],2);

    %// convert YTEST into a format that can be compared with classNet
    [~,classTest] = find(YTEST);
    
    %'// Check the success of the classifier
    cp = classperf(classTest, classNet);
    accuracy = cp; %// replace this with your preferred metric
    
end