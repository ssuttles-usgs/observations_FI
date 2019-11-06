function wfr=findwfr(wf)

% for i=1:length(wf)
% ubh(i)=wf(i).umax-wf(i).umin;
% T(i)=wf(i).T;
% end
% Uw=mean(ubh)/2;
% T=mean(T);

for i=1:length(wf)
Uw(i)=(wf(i).umax-wf(i).umin)/2;

% Use Eqn 8 from van der A for representative near-bed orbital amplitude
try
uhat(i)=sqrt((2/wf(i).T).*trapz(wf(i).t,wf(i).ub.^2));
catch
uhat(i)=NaN;
end

T(i)=wf(i).T;
Tr(i)=wf(i).T/T(i);    
Tcr(i)=wf(i).Tc/T(i);
Ttr(i)=wf(i).Tt/T(i);
Acr(i)=wf(i).Ac/(uhat(i)*T(i));
Atr(i)=wf(i).At/(uhat(i)*T(i));
umaxr(i)=wf(i).umax/uhat(i);
uminr(i)=wf(i).umin/uhat(i);
Tcur(i)=wf(i).Tcu/T(i);
Ttur(i)=wf(i).Ttu/T(i);
end

wfr.dn=wf(1).dn(1);
wfr.Uw=mean(Uw);
wfr.uhat=mean(uhat);
wfr.T=mean(T);
wfr.umax=mean(umaxr)*wfr.uhat;
wfr.umin=mean(uminr)*wfr.uhat;
wfr.Tc=mean(Tcr)*wfr.T;
wfr.Tt=mean(Ttr)*wfr.T;
wfr.Tcu=mean(Tcur)*wfr.T;
wfr.Ttu=mean(Ttur)*wfr.T;
wfr.Ac=mean(Acr)*(wfr.uhat*wfr.T);
wfr.At=mean(Atr)*(wfr.uhat*wfr.T);
wfr.R=wfr.umax/(wfr.umax-wfr.umin);
wfr.alpha=2*wfr.Tcu/wfr.T;