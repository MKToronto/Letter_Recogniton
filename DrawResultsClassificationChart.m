%% Draw Results classification chart
function fig = DrawResultsClassificationChart(results, testpca)

    fig1 = figure

    %Letter A
    letter = 'A';
    correct = cellfun(@(x, y) SVMResultsChartLabelName(x, y, letter), results(:,1), results(:,2), 'un',0);
    
    subplot(3,4,1)
    gscatter(testpca(:,1),testpca(:,2),correct)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Letter A classification');
    
    %Letter B
    letter = 'B';
    correct = cellfun(@(x, y) SVMResultsChartLabelName(x, y, letter), results(:,1), results(:,2), 'un',0);
    
    subplot(3,4,1)
    gscatter(testpca(:,1),testpca(:,2),correct)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Letter B classification');
    
    %Letter C
    letter = 'C';
    correct = cellfun(@(x, y) SVMResultsChartLabelName(x, y, letter), results(:,1), results(:,2), 'un',0);
    
    subplot(3,4,1)
    gscatter(testpca(:,1),testpca(:,2),correct)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Letter C classification');
    
    %Letter D
    letter = 'D';
    correct = cellfun(@(x, y) SVMResultsChartLabelName(x, y, letter), results(:,1), results(:,2), 'un',0);
    
    subplot(3,4,1)
    gscatter(testpca(:,1),testpca(:,2),correct)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Letter D classification');
    
    %Letter E
    letter = 'E';
    correct = cellfun(@(x, y) SVMResultsChartLabelName(x, y, letter), results(:,1), results(:,2), 'un',0);
    
    subplot(3,4,1)
    gscatter(testpca(:,1),testpca(:,2),correct)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Letter E classification');
    
    %Letter F
    letter = 'F';
    correct = cellfun(@(x, y) SVMResultsChartLabelName(x, y, letter), results(:,1), results(:,2), 'un',0);
    
    subplot(3,4,1)
    gscatter(testpca(:,1),testpca(:,2),correct)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Letter F classification');
    
    %Letter G
    letter = 'G';
    correct = cellfun(@(x, y) SVMResultsChartLabelName(x, y, letter), results(:,1), results(:,2), 'un',0);
    
    subplot(3,4,1)
    gscatter(testpca(:,1),testpca(:,2),correct)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Letter G classification');
    
    %Letter H
    letter = 'H';
    correct = cellfun(@(x, y) SVMResultsChartLabelName(x, y, letter), results(:,1), results(:,2), 'un',0);
    
    subplot(3,4,1)
    gscatter(testpca(:,1),testpca(:,2),correct)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Letter H classification');
    
    %Letter I
    letter = 'I';
    correct = cellfun(@(x, y) SVMResultsChartLabelName(x, y, letter), results(:,1), results(:,2), 'un',0);
    
    subplot(3,4,1)
    gscatter(testpca(:,1),testpca(:,2),correct)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Letter I classification');
    
    %Letter J
    letter = 'J';
    correct = cellfun(@(x, y) SVMResultsChartLabelName(x, y, letter), results(:,1), results(:,2), 'un',0);
    
    subplot(3,4,1)
    gscatter(testpca(:,1),testpca(:,2),correct)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Letter J classification');
    
    fig = fig1
    
end
    
    
    