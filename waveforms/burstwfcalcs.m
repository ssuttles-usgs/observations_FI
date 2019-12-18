function [wf,UBS,PUV]=burstwfcalcs(datin,filttype)
%function [wf,wfr,UBS,PUV]=burstwfcalcs(datin,filttype)
%m-fcn to perform in-burst wave form anaylsis of near-bed velocity data
%INPUT:
%datin.bn= burst number
%datin.dn= matlab datnum for burst
%datin.depth= total water depth [m]
%datin.fs= sampling freq of puv data [hz]
%datin.zr= height of adv sample vol above seabed
%datin.zp= height of pressure sensor above seabed
%datin.u = raw east velocity component [m/s]
%datin.v = raw north velocity component [m/s]
%datin.p = pressure [dbar] 1xN
%filttype = signal filter type (0 = keep IG, 1 = remove IG)


%detrend and filter data
        
      bn=datin.bn;
      dn=datin.dn;
      u=detrend(datin.u);
      v=detrend(datin.v);
      p=detrend(datin.p);
      
      fs=datin.fs;
            
      T_long= 20; %longest wave period in bandpass filter (s)
      T_short = 4; %shortest wave period in bandpass filter (s)
      
        
      u1=iwaveslp(u,fs,T_short);
      v1=iwaveslp(v,fs,T_short);
      p1=iwaveslp(p,fs,T_short);
      
      u2=iwaveslp(u,fs,T_long);
      v2=iwaveslp(v,fs,T_long);
      p2=iwaveslp(p,fs,T_long);
      
      switch filttype
          case 0 % remove high freq only T < T_short (retain IG signal)
                u=u1;
                v=v1;
                p=p1;
              
          case 1 % remove low (T>T_long) and high (T<T_short) freq (removes IG singal)
                u=u1-u2;
                v=v1-v2;
                p=p1-p2;
          otherwise
              disp('Exception- filter method must be not specified in function call 0=keep IG, 1 = remove IG')
              return
      end
      
      %find near-bed velocity stats and do rotation into wave coordinates
     %[sd1 az1 sd2 az2]=pcastats(u*100,v*100,50,0);
      UBS = ubstatsr( u, v, fs );
     % find wave stats from near-bed puv data 
      PUV = puvq(p,u,v, datin.depth, datin.zp, datin.zr, fs, 512, 1030., 0.05, 1/4);
     
     %find individual waveforms for rotated near-bed data
     wf=findurwaveform(UBS.ur',fs,dn);
     
     %find representative waveform for burst or sub-burst
%      wfr=findwfr(wf);
%      wfr.wf7=findwf7(wfr);
     
     
     
     