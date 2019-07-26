function result = SVMResultsChartLabelNumber(label, testresult, letter)
    
    if label == letter && testresult == letter
        myresult = '1';
    elseif label ~= letter && testresult ~= letter
        myresult = '2';
    elseif label ~= letter && testresult == letter
        myresult = '3';
    elseif label == letter && testresult ~= letter
        myresult = '4';
    end
    
    result = myresult
end