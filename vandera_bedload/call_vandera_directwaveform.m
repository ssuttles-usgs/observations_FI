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
load('..\mat\taran\skewness_steve.mat','Hrmsu','depth')
h=depth; 

waveavgd_stress_term=1; 
surface_wave=1;  
current_timeperiod=0; 

% Read in Steve's waveform to get umax, umin, T_c, T_t....
%
load('/media/taran/DATADRIVE2/Obs_data/matfiles/matfiles_Steve/9917adv_wfr.mat')
% AVERAGED WAVEFORM 
umax=[wfr.umax] ; 
umin=[wfr.umin] ;
T_c=[wfr.Tc]   ;
T_t=[wfr.Tt]   ;
T_cu=[wfr.Tcu] ;
T_tu=[wfr.Ttu] ; 
T=[wfr.T] ; 
R=[wfr.R] ;
uhat=[wfr.Uw] ;% Multiplying this by 2 led to the old plot of bedload
%  
 for i=1:nt2
     Hs(i)=0.0;  %This is a redundant input to the code now that we have the waveform
      if(~isnan(uhat(i)))  
    [bedldx1(i), bedldy(i), bedldtx(i), Ur(i), R(i), Beta(i)]=........
                         vandera_function_directwaveform(i, Hs(i), T(i), h(i), d50, d90, .....
                         umag_curr, phi_curwave, uhat(i), .....
 						 umax(i), umin(i), ........
                         T_c(i), T_t(i), T_cu(i), T_tu(i), ............
 						  Zref, delta, waveavgd_stress_term, ....
                          current_timeperiod, surface_wave);
      end 
 end
 %plot(cumtrapz(bedldx)*3600)
 %load('/media/taran/DATADRIVE2/Obs_data/matfiles/vandera_bedld_directwaveform.mat',....
 %                                                        'bedldx','R','Beta','Ur')
 