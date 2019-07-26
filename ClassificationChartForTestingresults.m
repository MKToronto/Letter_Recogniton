function fig = ClassificationChartForTestingresults(PCAColumnOne, PCAColumnTwo, trueresultslabels, testingresultslabels, LegendLocation)
    
    fig1 = figure

    %Letter A
    correctA = cellfun(@(x, y) SVMResultsChartLabelName(x, y, 'A'), trueresultslabels, testingresultslabels, 'un',0);
    sortA = cellfun(@(x, y) SVMResultsChartLabelNumber(x, y, 'A'), trueresultslabels, testingresultslabels, 'un',0);
    [sortA,IXA] = sort(sortA);

    subplot(3,4,1)
    gscatter(PCAColumnOne(IXA,:),PCAColumnTwo(IXA,:),correctA(IXA,:))
    grid on
    xlabel('pca1');
    ylabel('pca2');
    legend('Location',LegendLocation);
    title('Subplot: A');
    
    %Letter B
    correctB = cellfun(@(x, y) SVMResultsChartLabelName(x, y, 'B'), trueresultslabels, testingresultslabels, 'un',0);
    sortB = cellfun(@(x, y) SVMResultsChartLabelNumber(x, y, 'B'), trueresultslabels, testingresultslabels, 'un',0);
    [sortB,IXB] = sort(sortB);
    
    subplot(3,4,2)
    gscatter(PCAColumnOne(IXB,:),PCAColumnTwo(IXB,:),correctB(IXB,:))
    grid on
    xlabel('pca1');
    ylabel('pca2');
    legend('Location',LegendLocation);
    title('Subplot: B');
    
    %Letter C
    correctC = cellfun(@(x, y) SVMResultsChartLabelName(x, y, 'C'), trueresultslabels, testingresultslabels, 'un',0);
    sortC = cellfun(@(x, y) SVMResultsChartLabelNumber(x, y, 'C'), trueresultslabels, testingresultslabels, 'un',0);
    [sortC,IXC] = sort(sortC);
    
    subplot(3,4,3)
    gscatter(PCAColumnOne(IXC,:),PCAColumnTwo(IXC,:),correctC(IXC,:))
    grid on
    xlabel('pca1');
    ylabel('pca2');
    legend('Location',LegendLocation);
    title('Subplot: C');
    
    %Letter D
    correctD = cellfun(@(x, y) SVMResultsChartLabelName(x, y, 'D'), trueresultslabels, testingresultslabels, 'un',0);
    sortD = cellfun(@(x, y) SVMResultsChartLabelNumber(x, y, 'D'), trueresultslabels, testingresultslabels, 'un',0);
    [sortD,IXD] = sort(sortD);
    
    subplot(3,4,4)
    gscatter(PCAColumnOne(IXD,:),PCAColumnTwo(IXD,:),correctD(IXD,:))
    grid on
    xlabel('pca1');
    ylabel('pca2');
    legend('Location',LegendLocation);
    title('Subplot: D');
    
    %Letter E
    correctE = cellfun(@(x, y) SVMResultsChartLabelName(x, y, 'E'), trueresultslabels, testingresultslabels, 'un',0);
    sortE = cellfun(@(x, y) SVMResultsChartLabelNumber(x, y, 'E'), trueresultslabels, testingresultslabels, 'un',0);
    [sortE,IXE] = sort(sortE);
    
    subplot(3,4,5)
    gscatter(PCAColumnOne(IXE,:),PCAColumnTwo(IXE,:),correctE(IXE,:))
    grid on
    xlabel('pca1');
    ylabel('pca2');
    legend('Location',LegendLocation);
    title('Subplot: E');
    
    %Letter F
    correctF = cellfun(@(x, y) SVMResultsChartLabelName(x, y, 'F'), trueresultslabels, testingresultslabels, 'un',0);
    sortF = cellfun(@(x, y) SVMResultsChartLabelNumber(x, y, 'F'), trueresultslabels, testingresultslabels, 'un',0);
    [sortF,IXF] = sort(sortF);
    
    subplot(3,4,6)
    gscatter(PCAColumnOne(IXF,:),PCAColumnTwo(IXF,:),correctF(IXF,:))
    grid on
    xlabel('pca1');
    ylabel('pca2');
    legend('Location',LegendLocation);
    title('Subplot: F');
    
    %Letter G
    correctG = cellfun(@(x, y) SVMResultsChartLabelName(x, y, 'G'), trueresultslabels, testingresultslabels, 'un',0);
    sortG = cellfun(@(x, y) SVMResultsChartLabelNumber(x, y, 'G'), trueresultslabels, testingresultslabels, 'un',0);
    [sortG,IXG] = sort(sortG);
    
    subplot(3,4,7)
    gscatter(PCAColumnOne(IXG,:),PCAColumnTwo(IXG,:),correctG(IXG,:))
    grid on
    xlabel('pca1');
    ylabel('pca2');
    legend('Location',LegendLocation);
    title('Subplot: G');
    
    %Letter H
    correctH = cellfun(@(x, y) SVMResultsChartLabelName(x, y, 'H'), trueresultslabels, testingresultslabels, 'un',0);
    sortH = cellfun(@(x, y) SVMResultsChartLabelNumber(x, y, 'H'), trueresultslabels, testingresultslabels, 'un',0);
    [sortH,IXH] = sort(sortH);
    
    subplot(3,4,8)
    gscatter(PCAColumnOne(IXH,:),PCAColumnTwo(IXH,:),correctH(IXH,:))
    grid on
    xlabel('pca1');
    ylabel('pca2');
    legend('Location',LegendLocation);
    title('Subplot: H');
    
    %Letter I
    correctI = cellfun(@(x, y) SVMResultsChartLabelName(x, y, 'I'), trueresultslabels, testingresultslabels, 'un',0);
    sortI = cellfun(@(x, y) SVMResultsChartLabelNumber(x, y, 'I'), trueresultslabels, testingresultslabels, 'un',0);
    [sortI,IXI] = sort(sortI);
    
    subplot(3,4,9)
    gscatter(PCAColumnOne(IXI,:),PCAColumnTwo(IXI,:),correctI(IXI,:))
    grid on
    xlabel('pca1');
    ylabel('pca2');
    legend('Location',LegendLocation);
    title('Subplot: I');
    
    %Letter J
    correctJ = cellfun(@(x, y) SVMResultsChartLabelName(x, y, 'J'), trueresultslabels, testingresultslabels, 'un',0);
    sortJ = cellfun(@(x, y) SVMResultsChartLabelNumber(x, y, 'J'), trueresultslabels, testingresultslabels, 'un',0);
    [sortJ,IXJ] = sort(sortJ);
    
    subplot(3,4,10)
    gscatter(PCAColumnOne(IXJ,:),PCAColumnTwo(IXJ,:),correctJ(IXJ,:))
    grid on
    xlabel('pca1');
    ylabel('pca2');
    legend('Location',LegendLocation);
    title('Subplot: J');
    
    fig = fig1
end