clear
load('..\mat\puv_proc_FI_iwaves_depc.mat')
clearvars -except PUV
load('mat\9917adv_waveforms')
for ii=1:length(b)
    wf=b(ii).wf;
    wfr(ii)=findwfrubr(wf,PUV(ii).ubr,PUV(ii).Tr);
end

save mat\9917adv_wfr_ubr wfr