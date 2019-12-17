clear all ; %close all ; clc; 
% Comparing three bedload formulations
% MPM
% Direct waveform with averaged waveforms manually from ADV data
% all direct waveforms from ADV data
% STEVE's claculations of directly obtained ADV data 
nt1=1; nt2= 2044; 
% % 
% % 
% load('../../matfiles/skewness_steve.mat','Su_skewness','ur_maj_rot','vr_min_rot',........
%             'Hrmsu','omega_br','Ubr','Ursell','dn','jtb_rec','ur_bar',...
%             'ur_cube','ang_rot','Au_skewness')
%  
  load('..\mat\skewness_steve.mat','dn') 
     
 % STEVE's WAVEFORM
load('..\mat\vandera_bedld_directwaveform.mat','bedldx_wfr','R','Beta','Ur');
bedld_directwaveform=bedldx_wfr; 
dn_directwaveform=dn(~isnan(bedld_directwaveform));
cumbedld_directwaveform=cumtrapz(dn_directwaveform,bedld_directwaveform(~isnan(bedld_directwaveform))).*86400;%skip Nans and change time units to seconds
R_directwaveform=R;
clear R

% VANDERA from workhorse using all the empircal waveform 
load('..\mat\vandera_bedld_workhorse_ubspecdat.mat','bedldx_wh_vspec','R','Beta','Ur')
bedld_empirical_vand=bedldx_wh_vspec; 
dn_empirical_vand=dn(~isnan(bedld_empirical_vand));
cumbedld_empirical_vand=cumtrapz(dn_empirical_vand,bedld_empirical_vand(~isnan(bedld_empirical_vand))).*86400;  
R_empirical_vand=R;
clear R

%load('/media/taran/DATADRIVE2/Obs_data/matfiles/vandera_bedld.mat','bedldx','R','Beta','Ur');
load('..\mat\vandera_bedld_allwaveforms.mat','bedldx_allwaveform','R','Beta','Ur')
dn_allwaveform=dn(~isnan(bedldx_allwaveform));
cumbedld_allwaveform=cumtrapz(dn_allwaveform,bedldx_allwaveform(~isnan(bedldx_allwaveform))).*86400;
R_allwaveform=R;
clear R

% MPM bedload 
load('..\mat\taran\mpm_only_ss.mat');
bedld_mpm=qb_measured;
dn_mpm=dn(~isnan(bedld_mpm));
cumbedld_mpm=cumtrapz(dn_mpm,bedld_mpm(~isnan(bedld_mpm))).*86400;  


%Significant direct waveform
load('..\mat\vandera_bedld_directwaveform_sig.mat','bedldx_wfr_sig','R','Beta','Ur');
dn_sig=dn(~isnan(bedldx_wfr_sig));
cumbedld_wfr_sig=cumtrapz(dn_sig,bedldx_wfr_sig(~isnan(bedldx_wfr_sig))).*86400;
R_sig=R;
clear R

%represntative direct waveform using ubr and Tr from puvq
load('..\mat\vandera_bedld_directwaveform_ubr.mat','bedldx_wfr_ubr','R','Beta','Ur');
dn_ubr=dn(~isnan(bedldx_wfr_ubr));
cumbedld_wfr_ubr=cumtrapz(dn_ubr,bedldx_wfr_ubr(~isnan(bedldx_wfr_ubr))).*86400;
R_ubr=R;
clear R

% VANDERA from workhorse using all the empircal waveform 
load('..\mat\vandera_bedld_workhorse_ubspecdat_depc.mat','bedldx_wh_vspec','R','Beta','Ur')
bedld_empirical_vand_depc=bedldx_wh_vspec; 
dn_empirical_vand_depc=dn(~isnan(bedld_empirical_vand_depc));
cumbedld_empirical_vand_depc=cumtrapz(dn_empirical_vand_depc,bedld_empirical_vand_depc(~isnan(bedld_empirical_vand_depc))).*86400;
R_empirical_vand_depc=R;
clear R

%Significant direct waveform
load('..\mat\vandera_bedld_directwaveform_ubs.mat','bedldx_wfr_ubs','R','Beta','Ur');
dn_ubs=dn(~isnan(bedldx_wfr_ubs));
cumbedld_wfr_ubs=cumtrapz(dn_ubs,bedldx_wfr_ubs(~isnan(bedldx_wfr_ubs))).*86400;
R_ubs=R;
clear R

% VANDERA from workhorse using all the empircal significant waveform
load('..\mat\vandera_bedld_workhorse_ubspecdat_ubs.mat','bedldx_wh_vspec_ubs','R','Beta','Ur')
bedld_empirical_vand_ubs=bedldx_wh_vspec_ubs; 
dn_empirical_vand_ubs=dn(~isnan(bedld_empirical_vand_ubs));
cumbedld_empirical_vand_ubs=cumtrapz(dn_empirical_vand_ubs,bedld_empirical_vand_ubs(~isnan(bedld_empirical_vand_ubs))).*86400; 
R_empirical_vand_ubs=R;
clear R

%load('/media/taran/DATADRIVE2/Obs_data/matfiles/vandera_bedld.mat','bedldx','R','Beta','Ur');
load('..\mat\vandera_bedld_allwaveforms_nostream.mat','bedldx_allwaveform_nostream','R','Beta','Ur')
dn_allwaveform_nostream=dn(~isnan(bedldx_allwaveform_nostream));
cumbedld_allwaveform_nostream=cumtrapz(dn_allwaveform_nostream,bedldx_allwaveform_nostream(~isnan(bedldx_allwaveform))).*86400;
R_allwaveform_nostream=R;
clear R;


% Cummulative bedload transport
figure
scrsz=get(0,'screensize');
set(gcf,'position',[1  1 scrsz(3)*0.9 scrsz(4)*0.9])
plot(dn_empirical_vand_depc,cumbedld_empirical_vand_depc,'r') 
 hold on
plot(dn_directwaveform,cumbedld_directwaveform,'k');
plot(dn_allwaveform,cumbedld_allwaveform,'g');
plot(dn_mpm,cumbedld_mpm,'b');
plot(dn_sig,cumbedld_wfr_sig,'--k')
plot(dn_ubr,cumbedld_wfr_ubr,'m')
%plot(dn_empirical_vand_ses,cumbedld_empirical_vand_ses,'--r') 
%plot(dn_sig_12m,cumbedld_wfr_sig_12m,'c')
plot(dn_ubs,cumbedld_wfr_ubs,'--c')
plot(dn_empirical_vand_ubs,cumbedld_empirical_vand_ubs,'--r') 
plot(dn_allwaveform_nostream,cumbedld_allwaveform_nostream,'--g') 

title('Cummulative Bedload comparison from Fire Island 2014 site 3 using 9917adv and 9921wh data','fontweight','bold') 
ylabel('Cummulative bedload transport, [m^2]')
datetick('x',2)

set(gca,'xlim',[datenum('3-Feb-2014') datenum('6-May-2014')])

legend({'empirical ubr,Tr' 'waveform averaged' 'all waveforms direct' 'mpm ss' 'waveform sigificant' 'waveform ubr,Tr' 'waveform ubs,Tr' 'empirical ubs,Tr' 'all waveform nostream'},'Location','Northwest')

saveas(gcf,'bedload_compare_ubs.fig','fig')
%saveas(gcf,'bedload_compare_ubs.png','png')
save2pdf('bedload_compare_ubs',gcf,300)

% bedload rate
figure
scrsz=get(0,'screensize');
set(gcf,'position',[1  1 scrsz(3)*0.9 scrsz(4)*0.9])
set(gca,'xlim',[datenum('3-Feb-2014') datenum('6-May-2014')])
xlim=get(gca,'xlim');
line(xlim,[0 0],'color',[0.7 0.7 0.7])
hold on
plot(dn,bedld_empirical_vand_depc,'r') 
 %hold on
plot(dn,bedld_directwaveform,'k');
plot(dn,bedldx_allwaveform,'g');
plot(dn_mpm,bedld_mpm,'b');
plot(dn,bedldx_wfr_sig,'--k')
plot(dn,bedldx_wfr_ubr,'m')
%plot(dn_empirical_vand_ses,cumbedld_empirical_vand_ses,'--r') 
%plot(dn_sig_12m,cumbedld_wfr_sig_12m,'c')
plot(dn,bedldx_wfr_ubs,'--c')
plot(dn,bedld_empirical_vand_ubs,'--r') 
plot(dn,bedldx_allwaveform_nostream,'--g')

title('Bedload comparison from Fire Island 2014 site 3 using 9917adv and 9921wh data','fontweight','bold') 
ylabel('bedload transport, [m^2 ^. s^{-1}]')
datetick('x',2)

box on

set(gca,'xlim',[datenum('3-Feb-2014') datenum('6-May-2014')])
set(gca,'ylim',[-2e-6 20e-6])

legend({'0' 'empirical ubr,Tr' 'waveform averaged' 'all waveforms direct' 'mpm ss' 'waveform sigificant' 'waveform ubr,Tr' 'waveform ubs,Tr' 'empirical ubs,Tr' 'all waveforms nostream'},'Location','Northeast')

saveas(gcf,'bedload_compare_rate.fig','fig')
%saveas(gcf,'bedload_compare_rate.png','png')
save2pdf('bedload_compare_rate',gcf,300)


% skewness R
figure
scrsz=get(0,'screensize');
set(gcf,'position',[1  1 scrsz(3)*0.9 scrsz(4)*0.9])
plot(dn,R_empirical_vand_depc,'r','linewidth',2) 
 hold on
plot(dn,R_directwaveform,'*k');
plot(dn,R_allwaveform,'g');
%plot(dn_mpm,bedld_mpm,'b');
plot(dn,R_sig,'--k')
plot(dn,R_ubr,'m')
%plot(dn_empirical_vand_ses,cumbedld_empirical_vand_ses,'--r') 
%plot(dn_sig_12m,cumbedld_wfr_sig_12m,'c')
plot(dn,R_ubs,'--c')
plot(dn,R_empirical_vand_ubs,'*r') 
%plot(dn,R_allwaveform_nostream,'+g')

title('Skewness parameter comparison from Fire Island 2014 site 3 using 9917adv and 9921wh data','fontweight','bold') 
ylabel('R')
datetick('x',2)

set(gca,'xlim',[datenum('3-Feb-2014') datenum('6-May-2014')])



xlim=get(gca,'xlim');
line([xlim(1) xlim(2)],[0.5 0.5],'color','k','linestyle','-.')


legend({'empirical ubr,Tr' 'waveform averaged' 'all waveforms direct' 'waveform sigificant' 'waveform ubr,Tr' 'waveform ubs,Tr' 'empirical ubs,Tr' '0.5'},'Location','North')

saveas(gcf,'bedload_compare_R.fig','fig')
%saveas(gcf,'R_compare.png','png')
save2pdf('bedload_compare_R',gcf,300)