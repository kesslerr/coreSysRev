
%% this script is to extract different values from BMS.mat files
%  and save them as .csv for easier handling in other languages

files = dir("*/BMS.mat");
for file = 1:length(files)
    cd(files(file).folder);
    load(files(file).name)
    exp = BMS.DCM.rfx.model.exp_r';
    xp  = BMS.DCM.rfx.model.xp';
    data = [exp, xp];
    
    csvwrite(strcat(files(file).name, ".csv"),data);
    cd("..");
end