clear all ; close all ; clc; 
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

% VANDERA from workhorse using all the empircal waveform 
load('..\mat\vandera_bedld_workhorse_ubspecdat.mat','bedldx_wh_vspec','R','Beta','Ur')
bedld_empirical_vand=bedldx_wh_vspec; 
dn_empirical_vand=dn(~isnan(bedld_empirical_vand));
cumbedld_empirical_vand=cumtrapz(dn_empirical_vand,bedld_empirical_vand(~isnan(bedld_empirical_vand))).*86400;  

%load('/media/taran/DATADRIVE2/Obs_data/matfiles/vandera_bedld.mat','bedldx','R','Beta','Ur');
load('..\mat\vandera_bedld_allwaveforms.mat','bedldx_allwaveform','R','Beta','Ur')
dn_allwaveform=dn(~isnan(bedldx_allwaveform));
cumbedld_allwaveform=cumtrapz(dn_allwaveform,bedldx_allwaveform(~isnan(bedldx_allwaveform))).*86400;

% MPM bedload 
load('..\mat\taran\mpm_only_ss.mat');
bedld_mpm=qb_measured;
dn_mpm=dn(~isnan(bedld_mpm));
cumbedld_mpm=cumtrapz(dn_mpm,bedld_mpm(~isnan(bedld_mpm))).*86400;  


%Significant direct waveform
load('..\mat\vandera_bedld_directwaveform_sig.mat','bedldx_wfr_sig','R','Beta','Ur');
dn_sig=dn(~isnan(bedldx_wfr_sig));
cumbedld_wfr_sig=cumtrapz(dn_sig,bedldx_wfr_sig(~isnan(bedldx_wfr_sig))).*86400;


% 
figure
scrsz=get(0,'screensize');
set(gcf,'position',[scrsz(3)+1 -100 scrsz(3)-100 scrsz(4)-100])
plot(dn_empirical_vand,cumbedld_empirical_vand,'r') 
 hold on
plot(dn_directwaveform,cumbedld_directwaveform,'k');
plot(dn_allwaveform,cumbedld_allwaveform,'g');
plot(dn_mpm,cumbedld_mpm,'b');
plot(dn_sig,cumbedld_wfr_sig,'--k')

title('Cummulative Bedload comparison from Fire Island 2014 site 3 using 9917adv and 9921wh data','fontweight','bold') 
ylabel('Cummulative bedload transport')
datetick('x',2)

saveas(gcf,'bedload_compare_sig.png','png')
save2pdf('bedload_compare_sig',gcf,300)

legend({'empirical' 'waveform averaged' 'all waveforms direct' 'mpm ss' 'waveform sigificant'},'Location','Northwest')
%legend('direct waveform vand','emp. waveform vand','mpm','Location','Northwest')
xlim([dn(nt1) dn(nt2)]);
