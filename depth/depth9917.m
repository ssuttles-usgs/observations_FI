%find corrected depth for site 3, using pressure from ADV 9917, baromteric pressure data
%from met buoy at 985, and SeaCat TC logger at 991.

%files needed
cdffn='C:\Users\ssuttles\data\FireIsland\analysis\Taran\9917advs1.cdf'; %raw pressure data in frequency
metfn='C:\Users\ssuttles\data\FireIsland\analysis\Taran\9851met.cdf'; %nearby met buoy data
advsfn = fullfile('C:\Users\ssuttles\data\FireIsland\analysis\Taran\9917advs-cal.nc'); % statistics filename
scfn='C:\Users\ssuttles\data\FireIsland\analysis\Taran\9912sc-a.cdf'; %seacat logger with temp and salinity data

%create struct P with raw pressure and converted press to decibars
P=pfreq2db_paros(cdffn);
P.dn=nctime2dn(cdffn)';

%correct pressdb for offset and changes in atmospheric pressure
    %load met data with barometric pressure
    baro=squeeze(ncread(metfn,'BP_915')); %barometric pressure in millibars
    dnbaro=nctime2dn(metfn);
    
    %find atmospheric press zero offset
    if 0 ; bproff=findatmoffset2p1_interactive(P.pressdb,P.dn,baro./100,dnbaro); end
    bproff = 0.0470; %found with function above
    
    P.pressdb_ac=p1ac(P.pressdb,P.dn,baro/100,dnbaro,bproff); %correct pressure for zero offset and atmosperic pressure changes over deployment
    
   
%% find where to trim raw data
 %use start & stop time from stats processed file
time=ncread(advsfn,'time');
time2=ncread(advsfn,'time2') ; 

jt = time+time2/(3600*24*1000);
dn = j2dn(time,time2);

igb=find(P.dn>=dn(1)-0.5/24 & P.dn<dn(end)+0.5/24);

clear dn jt time time2
%% Find time series of pressure sensor elevation above seabed
    
    %use brange from ADV raw file and instrument offsets to get time series
    %of pressure sensor elevation above seabed
    
    brange=squeeze(ncread(cdffn,'brange'))/1000;
    
    %interpolate bad values of brange
    brangei=interp1(P.dn(brange>0),brange(brange>0),P.dn(igb));
    
    %find all of the offsets 
    zoff = ncreadatt(cdffn,'/','ADVProbeSamplingVolumeOffset')/100.
    zr = brangei-zoff; % time series of ADV sample locations
    z_init = ncreadatt(advsfn,'u_1205','initial_sensor_height')
    p_z = ncreadatt(advsfn,'P_4023','initial_sensor_height');
    pdelz = p_z-(z_init-zoff); % elevation diff. between velocity and pressure- NEED to include zoff to get distance between velocity and pressure measuremens
    zp = zr+pdelz; % elevation of pressure measurements [m] accounting for variable brange
    
    zpmf=medfilt(zp,15); %smooth using median filter
%% need to convert corrected pressure to depth using temp & salinity data from deployed TC data

sc.sal=squeeze(ncread(scfn,'S_41'));
sc.temp=squeeze(ncread(scfn,'T_28'));
sc.dn = nctime2dn(scfn)';

rhosw = sw_dens0(sc.sal,sc.temp);
rhoswi=interp1(sc.dn,rhosw,P.dn(igb));

depac = P.pressdb_ac(igb).*10^4./rhoswi./9.81; %depth of sensor
    
depth_corrected = zpmf+depac; % time series of depth [meters]
depth_corrected=depth_corrected';

dn=P.dn(igb)';
save 9917advs_depth_corrected depth_corrected dn