clear all ; 
%close all ; clc; 
% This is based on the prototype code intended for ROMS, as of
% April 15, 2019
% code to call vandera bedload routines for a time-series 
% based on workhorse and ADV data
% Code written by Tarandeep S. Kalra and Chris Sherwood

% Enter sediment information in meters
d50 = 0.4e-3 ; %0.2e-3;
d90 = 1.3*d50;
% Near bottom current data
% This is constant
deg2rad=pi/180.0; 
umag_curr=0.0; %.2814;% abs(0.0);
phi_curwave=0.0;% 79.92*deg2rad ;% 0.0*deg2rad;
% Zref is a reference height for computing current friction factor 
Zref=0.04 ;
% delta is the reference height at which current velocity is computed (Wave boundary layer thickness) 
delta=0.2;

nt1=1; nt2= 2044;
%  
% UISNG the ADV data only 
load('..\mat\skewness_steve_depc.mat','Hrmsu','depth')
h=depth;%corrected depth now

% load('..\depth\9917advs_depth_corrected.mat','depth_corrected')
% h=depth_corrected; %need to add sensor ht

waveavgd_stress_term=1; 
surface_wave=0;  
current_timeperiod=0; 

% Read in Steve's waveform to get umax, umin, T_c, T_t....
%
load('..\waveforms\mat\9917adv_wfr_ubs.mat')
% AVERAGED WAVEFORM 
umax=[wfr.umax]; 
umin=[wfr.umin];
T_c=[wfr.Tc];
T_t=[wfr.Tt];
T_cu=[wfr.Tcu];
T_tu=[wfr.Ttu] ; 
T=[wfr.Tr] ; 
%R=[wfr.R] ;
uhat=[wfr.ubs];%
%  
 for ii=1:nt2
     Hs(ii)=0;  %This is a redundant input to the code now that we have the waveform
      disp(sprintf('calc bedload for burst %d', ii))
      if(~isnan(uhat(ii)))  
        [bedldx_wfr(ii), bedldy(ii), bedldtx(ii), Ur(ii), R(ii), Beta(ii)]=vandera_function_directwaveform(ii, Hs(ii), T(ii), h(ii), d50, d90, .....
                                                  umag_curr, phi_curwave, uhat(ii), .....
 						                          umax(ii), umin(ii), ........
                                                  T_c(ii), T_t(ii), T_cu(ii), T_tu(ii), ............
 						                          Zref, delta, waveavgd_stress_term, ......
                                                  current_timeperiod, surface_wave);
      else
          bedldx_wfr(ii)=NaN;
          bedldy(ii)=NaN;
          bedldtx(ii)=NaN;
          Ur(ii)=NaN;
          R(ii)=NaN;
          Beta(ii)=NaN;
      end 
 end
 bedldx_wfr_ubs=bedldx_wfr;
 
 save('..\mat\vandera_bedld_directwaveform_ubs.mat','bedldx_wfr_ubs','R','Beta','Ur')
 %plot(cumtrapz(bedldx)*3600)
 %load('/media/taran/DATADRIVE2/Obs_data/matfiles/vandera_bedld_directwaveform.mat',....
 %                                                        'bedldx','R','Beta','Ur')
 