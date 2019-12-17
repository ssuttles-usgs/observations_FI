function [r,phi,wf7]=wfr_utfit_eqn7(wfr,bnum)

%find nearbed velocity time-series by fitting eqn 7 from Abreu etal
%CoastEng 2010 to reprensentative waveform parameters

%from Abreu etal 2010 Eqn (7)

%Input from waveform
%Uw
%umax
%umin
%T
%Tc
%Tcu
%Tt
%Ttu

%clear

% load('mat\9917adv_wfr.mat')
% iburst=153
Uw=wfr.Uw;
umax=wfr.umax;
umin=wfr.umin;
T=wfr.T;
Tc=wfr.Tc;
Tcu=wfr.Tcu;
Tt=wfr.Tt;
Ttu=wfr.Ttu;


%phi=-pi/2; %assume velocity skewed at first
om=2*pi/T;


%tt=[0 Tcu Tc Tc+Ttu T]; %
tt=[-1:T/128:T+1];

err=1e35;


for phiphi=-pi/2:pi/10:pi/2
    
for rr=0:0.001:0.9
 f=sqrt(1-rr^2);

for i=1:length(tt)
u(i)=Uw*f*((sin(om*tt(i))+(rr*sin(phiphi)/(1+f)))/(1-rr*cos(om*tt(i)+phiphi)));
end
try
wf2=calcwfparams(u,tt);
%find error from wfr values
uerr=sqrt(sum([(wf2.ub(1)-0)^2,(interp1(wf2.t,wf2.ub,Tcu)-umax)^2,(interp1(wf2.t,wf2.ub,Tc)-0)^2,(interp1(wf2.t,wf2.ub,Tc+Ttu)-umin)^2,(interp1(wf2.t,wf2.ub,T)-0)^2]))/Uw; %normalized u rms error 
    Terr=sqrt(sum([(wf2.t(1)-0)^2,(wf2.Tcu-Tcu)^2,(wf2.Tc-Tc)^2,(wf2.Ttu-Ttu)^2,(wf2.T-T)^2]))/T; %normalized T rms error 
    comberr=uerr+Terr;
catch
    comberr=1e35;
end

if comberr<err
    err=comberr;
    r=rr;
    phi=phiphi;
end
end
end

t=-1:T/128:T+1;
for ii=1:length(t)
f=sqrt(1-r^2);    
ut(ii)=Uw*f*((sin(om.*t(ii))+(r*sin(phi)/(1+f)))/(1-r*cos(om.*t(ii)+phi)));
end
wf7=calcwfparams(ut,t);
ut=wf7.ub;
t=wf7.t;
wf7.err=err;
wf7.burst=bnum;
wf7.dn=wfr.dn;

if 1
    figure
    scrsz=get(0,'screensize')
    %set(gcf,'position',[scrsz(3)+scrsz(3)*0.1 -50 scrsz(3)*0.8 scrsz(4)*0.8])
    set(gcf,'position',[scrsz(3)*0.1 50 scrsz(3)*0.8 scrsz(4)*0.8])
    set(gca,'xlim',[0 14])
    xlim=get(gca,'xlim');
   line(xlim,[0 0],'color',[0.75 0.75 0.75])
    hold on
    plot(t,ut)
    pltpts=[0 0;Tcu umax;Tc 0;Tc+Ttu umin;T 0];
    plot(pltpts(:,1),pltpts(:,2),'or','MarkerFaceColor','r')
    
    box on
    
    xlabel('time, [s]')
    ylabel('near-bed wave orbital velocity, [m ^. s^{-1}]')
    
    
    title('FI14- Burst Representative Near-Bed Waveform Velocity time-series using Abreu etal(2010) Eqn7','fontsize',12)
    
    hdgstr=sprintf('burst = %d,  %s',bnum,datestr(wfr.dn))
    text(7,0.9,hdgstr,'fontsize',12,'fontweight','bold','horizontalalignment','center')
    
    legend({'0' 'wf-eqn7' 'wfr'})
   
    tstr1(1)={'\fontsize{12}\bf wfr \rm'};
    tstr1(2)={sprintf('\\fontsize{10} Uw      = %5.2f',Uw)};
    tstr1(3)={sprintf(' T         =   %5.2f',T)};
    tstr1(4)={sprintf(' umin    =   %5.2f',umin)};
    tstr1(5)={sprintf(' umax   =   %5.2f',umax)};
    tstr1(6)={sprintf(' Tc        =   %5.2f',Tc)};
    tstr1(7)={sprintf(' Tcu      =   %5.2f',Tcu)};
    tstr1(8)={sprintf(' Tt         =   %5.2f',Tt)};
    tstr1(9)={sprintf(' Ttu       =   %5.2f',Ttu)};
    tstr1(10)={sprintf(' R          =   %5.2f',wfr.R)};
    tstr1(11)={sprintf(' alpha    =   %5.2f',wfr.alpha)};
    
    tstr2(1)={'\fontsize{12}\bf wf-eqn7 \rm'}
    tstr2(2)={sprintf('\\fontsize{10} Uw      = %5.2f     [m ^. s^{-1}]',(wf7.umax-wf7.umin)/2)};
    tstr2(3)={sprintf(' T         =   %5.2f   [s]',wf7.T)};
    tstr2(4)={sprintf(' umin   =   %5.2f   [m ^. s^{-1}]',wf7.umin)};
    tstr2(5)={sprintf(' umax  =   %5.2f   [m ^. s^{-1}]',wf7.umax)};
    tstr2(6)={sprintf(' Tc       =   %5.2f   [s]',wf7.Tc)};
    tstr2(7)={sprintf(' Tcu     =   %5.2f   [s]',wf7.Tcu)};
    tstr2(8)={sprintf(' Tt        =   %5.2f   [s]',wf7.Tt)};
    tstr2(9)={sprintf(' Ttu      =   %5.2f   [s]',wf7.Ttu)};
    tstr2(10)={sprintf(' R         =   %5.2f',wf7.R)};
    tstr2(11)={sprintf(' alpha   =   %5.2f',wf7.alpha)};
    tstr2(12)={sprintf(' r          =   %5.2f',r)};
    tstr2(13)={sprintf(' phi       =   %5.2f',phi)};
     
        set(gca,'ylim',[-1 1])
        htxt=text(8,0.8,tstr1,'horizontalalignment','left','verticalalignment','top')
        htxt=text(10.5,0.8,tstr2,'horizontalalignment','left','verticalalignment','top')
        %htxt(1).FontSize=14;
end
    
%%
function wf=calcwfparams(ut,t)
%function wf=calcwfparams(ut,t)
%script to find waveform parameters from velocity time-series of a single
%wave form
%
%INPUT:
%ut = nearbed velocity time series(m/s)
%t = time (s)
%
%OUTPUT:
%wf - sturct of individual waveforms in burst
%   .t = wave form time (s)
%   .ub = wave nearbed velocity
%   .Tc = time crest (s)
%   .Tt = time trough (s)
%   .umax = amplitude crest (m/s)
%   .umin = amplitude trough (m/s)
%   .Ac = area crest (m/s * s)
%   .At = area trough (m/s *s)


try
    %find zero crossing times
    tz=findzs(ut,t);
   
    %loop to find crest/trough info
    for ii=1:length(tz)-1;
        %find half wave signal
        idx=find(t>tz(ii) & t<tz(ii+1));
        s(ii)={[0 ut(idx) 0]};
        ts(ii)={[tz(ii) t(idx) tz(ii+1)]};
        A(ii)=trapz(ts{ii},s{ii});
        S_max(ii)=max(s{ii});
        S_min(ii)=min(s{ii});
        T(ii)=tz(ii+1)-tz(ii);
    end

    cnt=0;
    xlim=[0 15];
    if sign(A(1))>=0
        for i=1:2:length(ts)-1;
        cnt=cnt+1;
        wf(cnt).t=[ts{i}-ts{i}(1) ts{i+1}(2:end)-ts{i}(1)];
        wf(cnt).ub=[s{i} s{i+1}(2:end)];
        wf(cnt).T=T(i)+T(i+1);
        wf(cnt).umax=S_max(i);
        wf(cnt).umin=S_min(i+1);
        wf(cnt).Tc=T(i);
        wf(cnt).Tt=T(i+1);
        wf(cnt).Tcu=wf(cnt).t(wf(cnt).ub==wf(cnt).umax);
        wf(cnt).Ttu=wf(cnt).t(wf(cnt).ub==wf(cnt).umin)-wf(cnt).Tc;
        wf(cnt).Ac=A(i);
        wf(cnt).At=A(i+1);
        wf(cnt).R=wf(cnt).umax/(wf(cnt).umax-wf(cnt).umin);
        wf(cnt).alpha=2*wf(cnt).Tcu/wf(cnt).T;
        wf(cnt).Su=mean(wf(cnt).ub.^3)/(std(wf(cnt).ub)).^3;

    %     plot(wf(cnt).t,wf(cnt).s)
    %     set(gca,'xlim',xlim)
    %     line(xlim, [0 0],'color',[0.5 0.5 0.5])
    %     set(gca,'ylim',[-1.5 1.5])
    %     pause(0.5)
    %     cla
        end

    else
        for i=2:2:length(ts)-2
        cnt=cnt+1;
        wf(cnt).t=[ts{i}-ts{i}(1) ts{i+1}(2:end)-ts{i}(1)];
        wf(cnt).ub=[s{i} s{i+1}(2:end)];
        wf(cnt).T=T(i)+T(i+1);
        wf(cnt).umax=S_max(i);
        wf(cnt).umin=S_min(i+1);
        wf(cnt).Tc=T(i);
        wf(cnt).Tt=T(i+1);
        wf(cnt).Tcu=wf(cnt).t(wf(cnt).ub==wf(cnt).umax);
        wf(cnt).Ttu=wf(cnt).t(wf(cnt).ub==wf(cnt).umin)-wf(cnt).Tc;
        wf(cnt).Ac=A(i);
        wf(cnt).At=A(i+1);
        wf(cnt).R=wf(cnt).umax/(wf(cnt).umax-wf(cnt).umin);
        wf(cnt).alpha=2*wf(cnt).Tcu/wf(cnt).T;
        wf(cnt).Su=mean(wf(cnt).ub.^3)/(std(wf(cnt).ub)).^3;
    %     plot(wf(cnt).t,wf(cnt).s)
    %     set(gca,'xlim',xlim)
    %     line(xlim, [0 0],'color',[0.5 0.5 0.5])
    %     set(gca,'ylim',[-1.5 1.5])
    %     pause(0.5)
    %     cla
        end
    end
catch
        wf.t=NaN;
        wf.ub=NaN;
        wf.T=NaN;
        wf.umax=NaN;
        wf.umin=NaN;
        wf.Tc=NaN;
        wf.Tt=NaN;
        wf.Tcu=NaN;
        wf.Ttu=NaN;       
        wf.Ac=NaN;
        wf.At=NaN;
        wf.R=NaN;
        wf.alpha=NaN;
        wf.Su=NaN;
end

return


%%
function tz=findzs(s,t)
%function tz=findzs(s,t)
%
%m-fcn to find zero crossing times of a signal s
%
%INPUT:
% s = signal
% t = time
len=length(s);

idx=1;
cnt=0;
c=sign(s(idx));
while idx < len
cnt=cnt+1;
c=sign(s(idx));
while c==sign(s(idx)) & idx < len
idx=idx+1;
end
tz(cnt)=interp1([s(idx-1) s(idx)],[t(idx-1) t(idx)],0);
end
return