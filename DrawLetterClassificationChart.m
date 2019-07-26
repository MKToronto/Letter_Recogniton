%% Draw Letter classification chart
function fig = DrawLetterClassificationChart(Y1, t1labels)

    %plot data onto scatter plot
    labels = transpose(mat2cell(transpose(char(t1labels + 64)), 1, ones(size(t1labels,1), 1)));
    
    %Create figures for chart
    fig1 = figure

    %Letter A
    labelsA = labels;
    labelsA(cellfun(@(x) x ~= 'A', labelsA)) = {'Other'};
    [labelsA,IXA] = sortrows(labelsA,-1);
    
    subplot(3,4,1)
    gscatter(Y1(IXA,1),Y1(IXA,2),labelsA)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Subplot: A');

    %Letter B
    labelsB = labels;
    labelsB(cellfun(@(x) x ~= 'B', labelsB)) = {'Other'};
    [labelsB,IXB] = sortrows(labelsB,-1);

    subplot(3,4,2)
    gscatter(Y1(IXB,1),Y1(IXB,2),labelsB)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Subplot: B');
    
    %Letter C
    labelsC = labels;
    labelsC(cellfun(@(x) x ~= 'C', labelsC)) = {'Other'};
    [labelsC,IXC] = sortrows(labelsC,-1);

    subplot(3,4,3)
    gscatter(Y1(IXC,1),Y1(IXC,2),labelsC)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Subplot: C');
    
    %Letter D
    labelsD = labels;
    labelsD(cellfun(@(x) x ~= 'D', labelsD)) = {'Other'};
    [labelsD,IXD] = sortrows(labelsD,-1);

    subplot(3,4,4)
    gscatter(Y1(IXD,1),Y1(IXD,2),labelsD)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Subplot: D');
    
    %Letter E
    labelsE = labels;
    labelsE(cellfun(@(x) x ~= 'E', labelsE)) = {'Other'};
    [labelsE,IXE] = sortrows(labelsE,-1);

    subplot(3,4,5)
    gscatter(Y1(IXE,1),Y1(IXE,2),labelsE)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Subplot: E');
    
    %Letter F
    labelsF = labels;
    labelsF(cellfun(@(x) x ~= 'F', labelsF)) = {'Other'};
    [labelsF,IXF] = sortrows(labelsF,-1);

    subplot(3,4,6)
    gscatter(Y1(IXF,1),Y1(IXF,2),labelsF)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Subplot: F');
    
    %Letter G
    labelsG = labels;
    labelsG(cellfun(@(x) x ~= 'G', labelsG)) = {'Other'};
    [labelsG,IXG] = sortrows(labelsG,-1);

    subplot(3,4,7)
    gscatter(Y1(IXG,1),Y1(IXG,2),labelsG)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Subplot: G');
    
    %Letter H
    labelsH = labels;
    labelsH(cellfun(@(x) x ~= 'H', labelsH)) = {'Other'};
    [labelsH,IXH] = sortrows(labelsH,-1);

    subplot(3,4,8)
    gscatter(Y1(IXH,1),Y1(IXH,2),labelsH)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Subplot: H');
    
    %Letter I
    labelsI = labels;
    labelsI(cellfun(@(x) x ~= 'I', labelsI)) = {'Other'};
    [labelsI,IXI] = sortrows(labelsI,-1);

    subplot(3,4,9)
    gscatter(Y1(IXI,1),Y1(IXI,2),labelsI)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Subplot: I');
    
    %Letter J
    labelsJ = labels;
    labelsJ(cellfun(@(x) x ~= 'J', labelsJ)) = {'Other'};
    [labelsJ,IXJ] = sortrows(labelsJ,-1);

    subplot(3,4,10)
    gscatter(Y1(IXJ,1),Y1(IXJ,2),labelsJ)
    grid on
    xlabel('pca1');
    ylabel('pca2');
    title('Subplot: J');
    
    fig = fig1
    
end