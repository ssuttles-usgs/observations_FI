%calling script to find angle psi between wave propogation direction and
%mean currents

%load processed data iwaves and no filtering for 9917 adv data
nofilt=load('mat\puv_proc_FI_nofilt.mat'); %need unfiltered data to find mean current vectors
iwaves=load('mat\puv_proc_FI_iwaves.mat'); %processed incident wave filtered data to find wave rotation direction

%start loop to find psi for each burst
for ii=1:iwaves.n
    [psid(ii),wdir(ii),cdir(ii)]=findpsi(iwaves.UBS(ii).maj_az, nofilt.UBS(ii).umean, nofilt.UBS(ii).vmean);
end

save('mat\9917adv_psi.mat','psid','wdir','cdir')