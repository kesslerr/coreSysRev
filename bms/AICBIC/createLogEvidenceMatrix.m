
% create log evidence matrix

% Optional:  load .mat file with log-evidence values for comparison.
% This option is a faster alternative to selecting the DCM.mat files for
% each subject/model (above in 'Data') but it does not allow for 
% Bayesian Model Averaging. To compute BMA the user needs to specify
% the DCM.mat files or the model space.
% This  file  should  contain an F matrix consisting of [s x m] log-evidence 
% values, where s is the number of subjects and m the number
% of models.

addpath("/Users/roman/projects/coreSysRev/bms/AICBIC"); % add getVarName

cd("/Users/roman/projects/coreSysRev/dcms/original");

savepathprefix = "/Users/roman/projects/coreSysRev/bms/AICBIC/log_evidence_matrix_";

studies = ["A" "B" "C_M" "C_P"];
Nm      = 24; % number of different models

for study = studies
    display(study)
    
    modelfiles = dir(strcat("study_",study,"/DCM*.mat"));
    
    k = length(modelfiles);
    Ns = k / Nm; % number of subjects
    
    AICs = zeros(k,1);
    BICs = zeros(k,1);
    Fs   = zeros(k,1);
    
    for i = 1:k
        load(fullfile(modelfiles(i).folder, modelfiles(i).name));
        try
            AICs(i) = DCM.AIC;
            BICs(i) = DCM.BIC;
            Fs(i)   = DCM.F;
        catch
            display(strcat("not estimated:", modelfiles(i).name));
        end
    end
    
    AICs = reshape(AICs, [Ns, Nm]); % this reshape seems to be correct
    BICs = reshape(BICs, [Ns, Nm]);
    Fs   = reshape(Fs, [Ns, Nm]);
    
    F = AICs;
    save(strcat(savepathprefix, study, "_AIC.mat"), "F");
    F = BICs;
    save(strcat(savepathprefix, study, "_BIC.mat"), "F");
    F = Fs;
    save(strcat(savepathprefix, study, "_F.mat"),   "F");

end