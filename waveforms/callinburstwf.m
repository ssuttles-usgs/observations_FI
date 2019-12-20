%load raw puv data from near-bed adv
load ..\mat\puv_proc_FI_iwaves2 raw depth fs zr zp dn

%set burst number to process
bn=153

%make input data to m-fcn
datin.bn=bn;
datin.dn=dn(bn);
datin.depth=depth(bn);
datin.fs=fs;
datin.zr=zr(bn)
datin.zp=zp(bn)
datin.u=raw(bn).u;
datin.v=raw(bn).v;
datin.p=raw(bn).p;

%set filttype
filttype=1; %remove ig

[wf,UBS,PUV]=burstwfcalcs(datin,filttype);

%%
figure(1)
clf
scrsz=get(0,'screensize');
set(gcf,'position',[50 50 scrsz(3)*0.8 scrsz(4)*0.8]);

ax0=axes('position',[0.1 0.7 0.8 0.2]);
ax1=axes('position',[0.1 0.45 0.8 0.2]);
ax2=axes('position',[0.1 0.1 0.2 0.3])
ax3=axes('position',[0.4 0.1 0.2 0.3])
ax4=axes('position',[0.7 0.1 0.2 0.3])


tall=([wf.dn]-[wf(1).dn(1)])*86400;
uball=[wf.ub];

len=length(wf);

nwf=len


for ii=1:len-nwf+1

if exist('ax1')
    cla(ax1,'reset')
end
if exist('ax2')
    cla(ax2,'reset')
end
if exist('ax3')
    cla(ax3,'reset')
end
 
axes(ax1)    
plot(tall,uball,'b')
hold on
swf=ii;
for i=swf:swf+nwf-1
axes(ax2)
uhat=sqrt((2/wf(i).T).*trapz(wf(i).t,wf(i).ub.^2));
plot(wf(i).t./wf(i).T,wf(i).ub./uhat)
hold on
end
line([0 1],[0 0],'color',[0.75 0.75 0.75])

wfr=findwfr(wf(swf:swf+nwf-1));
%tic
wfr.wf7=findwf7(wfr);
%toc

axes(ax3)
plot(0,0,'ok','MarkerFaceColor','r')
hold on
plot(wfr.Tcu,wfr.umax,'ok','MarkerFaceColor','r')
plot(wfr.Tc,0,'ok','MarkerFaceColor','r')
plot(wfr.Tc+wfr.Ttu,wfr.umin,'ok','MarkerFaceColor','r')
plot(wfr.T,0,'ok','MarkerFaceColor','r')
line([0 wfr.T],[0 0],'color',[0.75 0.75 0.75])
plot(wfr.wf7.t,wfr.wf7.ub,'-k')

axes(ax1)
iplt=swf:swf+nwf-1;
tplt=([wf(iplt).dn]-[wf(1).dn(1)])*86400;
ubplt=[wf(iplt).ub];
plot(tplt,ubplt,'r')

figure(1)
pause(1)


end
%%
% nseg=floor(length(p2)/nfft);
%  m=fix(length(p2)/nseg);
%  speclen=2^nextpow2(m);
%  nx = length(p2);
%  na = nx/nfft;
%  w = hanning(floor(nx/na));
%  [Pxx,F]=pwelch(p2,w,0,nfft,fs);
% for i=1:length(wf)
% Uw(i)=(wf(i).umax-wf(i).umin)/2;
% 
% % Use Eqn 8 from van der A for representative near-bed orbital amplitude
% try
% uhat(i)=sqrt((2/wf(i).T).*trapz(wf(i).t,wf(i).ub.^2));
% catch
% uhat(i)=NaN;
% end
% 
% T(i)=wf(i).T;
% Tr(i)=wf(i).T/T(i);    
% Tcr(i)=wf(i).Tc/T(i);
% Ttr(i)=wf(i).Tt/T(i);
% Acr(i)=wf(i).Ac/(uhat(i)*T(i));
% Atr(i)=wf(i).At/(uhat(i)*T(i));
% umaxr(i)=wf(i).umax/uhat(i);
% uminr(i)=wf(i).umin/uhat(i);
% Tcur(i)=wf(i).Tcu/T(i);
% Ttur(i)=wf(i).Ttu/T(i);
% end
