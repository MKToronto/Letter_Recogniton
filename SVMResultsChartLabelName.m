function result = SVMResultsChartLabelName(label, testresult, letter)
    
    if label == letter && testresult == letter
        myresult = ['correct ', letter];
    elseif label ~= letter && testresult ~= letter
        myresult = ['correct not ', letter];
    elseif label ~= letter && testresult == letter
        myresult = ['incorrect given ', letter];
    elseif label == letter && testresult ~= letter
        myresult = ['incorrect not given ', letter];
    end
    
    result = myresult
end