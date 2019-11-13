clear all ; close all ; clc; 
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


% check Steve's wave form
%load('/media/taran/DATADRIVE2/Obs_data/matfiles/9917adv_wfr.mat')

load('..\waveforms\mat\9917adv_waveforms.mat'); 
% Use the detph from adv generated data 
load('..\mat\skewness_steve_depc.mat','Hrmsu')
load('..\depth\9917advs_depth_corrected.mat','depth_corrected')

h=depth_corrected; 

%wfr=[b(1).wf(1)]

it=0 ; 
s2=length(struct(b)); % length of the wavebursts saved here
for j=1:s2
 s1=length(struct(b(j).wf)); % find the lenght of all the waveforms 
 disp(sprintf('calc bedload for burst %d', j))
 % stored in the structure of 1 wave
 %within each wave burst
 for i=1:s1
   wfr=[b(j).wf(i)]; % check the first waveburst has 107 elements  
   umax=[wfr.umax] ; 
   umin=[wfr.umin] ;
   T_c=[wfr.Tc]   ;
   T_t=[wfr.Tt]   ;
   T_cu=[wfr.Tcu] ; 
   T_tu=[wfr.Ttu] ; 
   T=[wfr.T] ; 
    
   h_1d=h(j);    % Convert the dimensions of depth to what is needed ! 
   uhat=0.5*(umax-umin) ;
 % end
  %it=s1+it ;  
  
  

% Question- Would need to use peak wave period and not bottom wave period
waveavgd_stress_term=1; 
surface_wave=1;  
current_timeperiod=0; 


%for i=1:length(uhat)
   if(~isnan(uhat)) 
   Hs=0.0; % This is a redundant input( these are hardwired to be zero because they are not even needed for direct waveforms
   % as Steve already got all the inpputs.) ..........
   
   
   [bedldx_allwaveformi(i), bedldyi(i), bedldtxi(i), Uri(i), Ri(i), Betai(i)]=...........
                  vandera_function_directwaveform(i, Hs, T, h_1d, d50, d90, .....
                                                  umag_curr, phi_curwave, uhat, .....
 						                          umax, umin, ........
                                                  T_c, T_t, T_cu, T_tu, ............
 						                          Zref, delta, waveavgd_stress_term, ......
                                                  current_timeperiod, surface_wave); 
 end 
 end

 if exist('bedldx_allwaveformi')
 %get avg bedload for ea burst
 bedldx_allwaveform(j)=mean(bedldx_allwaveformi);
 bedldy(j)=mean(bedldyi);
 bedldtx(j)=mean(bedldtxi);
 Ur(j)=mean(Uri);
 R(j)=mean(Ri);
 Beta(j)=mean(Betai);
 else
 bedldx_allwaveform(j)=NaN;
 bedldy(j)=NaN;
 bedldtx(j)=NaN;
 Ur(j)=NaN;
 R(j)=NaN;
 Beta(j)=NaN;
 end
     
 
 clear bedldx_allwaveformi bedldyi bedldtxi Uri Ri Betai
end
 

save('..\mat\vandera_bedld_allwaveforms.mat','bedldx_allwaveform','R','Beta','Ur')
  