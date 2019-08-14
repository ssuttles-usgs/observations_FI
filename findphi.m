function [phid,wdir,cdir]=findphi(wdir,umean,vmean)
%function phid=findphi(wdir,umean,vmean)
%m-fcn to find angle between mean currents and wave propogation direction
%
%INPUT:
%wdir = wave propogation direction in degrees (compass notation) traveling towards
%umean = mean current in easterly direction
%vmean = mean current in northerly direction
%
%OUTPUT:
%phid= angle between mean currents and wave propogation direction in degrees.

[s,cdir]=pcoord(umean,vmean);

d=cdir-(wdir-90);
[umeanr,vmeanr]=xycoord(s,d);
phi=findang([umeanr,vmeanr], [1,0]); %rads
phid=phi*180/pi %deg
end

function theta = findang(v1,v2 )
%function theta = findang(v1,v2 )
%m-fc finds angle (rads) between two vectors v1 and v2
%inputs
%v1- vector 1 of components v1(1)=x/east and v1(2)= y/north
%v2- vector 2 of components v2(1)=x/east and v2(2)=y/north
%
%output
%theta in radians

theta=acos((dot(v1(1),v2(1))+dot(v1(2),v2(2)))/(dot(sqrt(v1(1)^2+v1(2)^2),sqrt(v2(1)^2+v2(2)^2))));

end
