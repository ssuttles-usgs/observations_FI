clear
load('mat\9917adv_waveforms')
for ii=1:length(b)
    disp('.')
    if rem(ii,50)==0
        disp(ii)
    end
    wf=b(ii).wf;
    wfr(ii)=findwfr(wf);
    wf7(ii)=findwf7(wfr(ii));        
end

for ii=1:length(b)
wfr(ii).wf7=wf7(ii)
end

save mat\9917adv_wfr wfr