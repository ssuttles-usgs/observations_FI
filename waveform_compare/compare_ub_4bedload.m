%compare near-bed wave orbital velociy amplitudes for bedload calcs

%load data
emp=load('..\mat\vspec_uhat_tr_depc.mat'); % empirical data from workhorse using vspec & ubspecdat
load('..\waveforms\mat\9917adv_wfr.mat'); % direct waveform using uhat (mean) wfr
ubr=load('..\waveforms\mat\9917adv_wfr_ubr.mat')
ubs=load('..\waveforms\mat\9917adv_wfr_ubs.mat')
sig=load('..\waveforms\mat\9917adv_wfr_uhat_sig.mat')


% skewness R
figure
scrsz=get(0,'screensize');
set(gcf,'position',[1  1 scrsz(3)*0.9 scrsz(4)*0.9])
plot(emp.dn_wh,emp.uhat_wh,'r') 
 hold on
plot([wfr.dn],[wfr.uhat],'k');
plot([sig.wfr.dn],[sig.wfr.uhat],'--k')
plot([ubr.wfr.dn],[ubr.wfr.ubr],'--m')
plot([ubs.wfr.dn],[ubs.wfr.ubs],'--c')
plot(emp.dn_wh,emp.uhat_wh*sqrt(2),'--r') 


title('Near-bed Representative Orbital Velocity Amplitude from Fire Island 2014 site 3 using 9917adv and 9921wh data','fontweight','bold') 
ylabel('near-bed orbital velocity amplitude, [m ^. s^{-1}]')
datetick('x',2)

set(gca,'xlim',[datenum('3-Feb-2014') datenum('6-May-2014')])

legend({'wh.ubr' 'wfr.uhat' 'wfr.sig' 'wfr.ubr' 'wfr.ubs' 'wh.ubs'},'Location','Northeast')

saveas(gcf,'ub_4bedload_compare.fig','fig')
%saveas(gcf,'ub_4bedload_compare.png','png')
save2pdf('ub_4bedload_compare',gcf,300)