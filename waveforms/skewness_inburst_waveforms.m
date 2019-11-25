% plot in burst skewness for FI 2014 ADV 9917 data

%iwaves
load('mat\9917adv_waveforms.mat')
load('mat\9917adv_wfr_ubs.mat')
url='C:\Users\ssuttles\data\FireIsland\analysis\Taran\9921whp-cal.nc'
ncload(url)


%plot for max and min R
figure
scrsz=get(0,'screensize');
set(gcf,'position',[100 50 scrsz(3)*0.9 scrsz(4)*0.9]);
[Rmax,Imax]=max([wfr.R]);
t=([b(Imax).wf.dn]-b(Imax).wf(1).dn(1))*86400;
tt=cumsum([b(Imax).wf.T]);
subplot(2,1,1)
yyaxis left
plot(tt,movmean([b(Imax).wf.R],5),'b')
set(gca,'ylim',[0.2 0.7])
set(gca,'ycolor','b')
hold on
yyaxis right
plot(tt,movmean([b(Imax).wf.Su],5),'r')
set(gca,'ylim',[-3 2])
set(gca,'ycolor','r')
line([0 1200],[0 0],'color',[0.5 0.5 0.5])
legend({'movmean(R,5)' 'movmean(Su,5)'},'location','Northeast')
title(sprintf('9917adv- Near-bed, within burst, moving mean velocity skewness from iwaves band waveforms @ max burst skewness, burst = %d',Imax))

txtstr(1)={sprintf('mean(R) = %6.4f',mean([b(Imax).wf.R]))}
txtstr(2)={sprintf('mean(Su) = %6.4f',mean([b(Imax).wf.Su]))}
% txtstr(3)={sprintf('mean(umax) = %6.4f [m ^. s^{-1}]',mean([b(Imax).wf.umax]))}
% txtstr(4)={sprintf('mean(umin) = %6.4f [m ^. s^{^-1}]',mean([b(Imax).wf.umin]))}
txtstr(3)={sprintf('ubs = %6.4f [m ^. s^{-1}]',wfr(Imax).ubs)}
txtstr(4)={sprintf('Hs = %5.2f [m]',wh_4061(Imax))}
txtstr(5)={sprintf('Tp = %5.2f [s]',wp_peak(Imax))}
txtstr(6)={sprintf('wvdir = %5.1f [^oT]',wvdir(Imax))}

text(1000,-1,txtstr,'verticalalignment','top')


%min R
subplot(2,1,2)
% scrsz=get(0,'screensize');
% set(gcf,'position',[100 50 scrsz(3)*0.9 scrsz(4)*0.9]);
[Rmax,Imin]=min([wfr.R]);
t=([b(Imin).wf.dn]-b(Imin).wf(1).dn(1))*86400;
tt=cumsum([b(Imin).wf.T]);
yyaxis left
plot(tt,movmean([b(Imin).wf.R],5),'b')
set(gca,'ylim',[0.2 0.7])
hold on
yyaxis right
plot(tt,movmean([b(Imin).wf.Su],5),'r')
set(gca,'ylim',[-3 2])
set(gca,'ycolor','r')
line([0 1200],[0 0],'color',[0.5 0.5 0.5])
legend({'movmean(R,5)' 'movmean(Su,5)'},'location','Northeast')
title(sprintf('9917adv- Near-bed, within burst, moving mean velocity skewness from iwaves band waveforms @ minimum burst skewness, burst = %d',Imin))
xlabel('burst time, [s]')

txtstr(1)={sprintf('mean(R) = %6.4f',mean([b(Imin).wf.R]))}
txtstr(2)={sprintf('mean(Su) = %6.4f',mean([b(Imin).wf.Su]))}
% txtstr(3)={sprintf('mean(umax) = %6.4f [m ^. s^{-1}]',mean([b(Imin).wf.umax]))}
% txtstr(4)={sprintf('mean(umin) = %6.4f [m ^. s^{-1}]',mean([b(Imin).wf.umin]))}
txtstr(3)={sprintf('ubs = %6.4f [m ^. s^{-1}]',wfr(Imin).ubs)}
txtstr(4)={sprintf('Hs = %5.2f [m]',wh_4061(Imin))}
txtstr(5)={sprintf('Tp = %5.2f [s]',wp_peak(Imin))}
txtstr(6)={sprintf('wvdir = %5.1f [^oT]',wvdir(Imin))}

text(1000,-1,txtstr,'verticalalignment','top')


save2pdf('pngfiles\9917adv_iwaves_inburst_skewness_min_max',gcf,300)
saveas(gcf,'pngfiles\9917adv_iwaves_inburst_skewness_min_max.png','png')


%loop
nt1=1;nt2=2044;
ubs=[wfr.ubs];
figure
scrsz=get(0,'screensize');
set(gcf,'position',[100 50 scrsz(3)*0.9 scrsz(4)*0.9]);

for ii=nt1:nt2
    %check uhat to see if > 0.5 m/s
    if ubs(ii) > 0.5
    
    t=([b(ii).wf.dn]-b(ii).wf(1).dn(1))*86400;
    tt=cumsum([b(ii).wf.T]);
    clf
    yyaxis left
    plot(tt,movmean([b(ii).wf.R],5),'b')
    set(gca,'ylim',[0.2 0.7])
    set(gca,'ycolor','b')
    hold on
    yyaxis right
    plot(tt,movmean([b(ii).wf.Su],5),'r')
    set(gca,'ylim',[-3 2])
    set(gca,'ycolor','r')
    line([0 1200],[0 0],'color',[0.5 0.5 0.5])
    legend({'movmean(R,5)' 'movmean(Su,5)'},'location','Northeast')
    title(sprintf('9917adv- Near-bed, within burst, moving mean velocity skewness from iwaves band waveforms @ %s, burst = %d',datestr(wfr(ii).dn),ii))

    txtstr(1)={sprintf('mean(R) = %6.4f',mean([b(ii).wf.R]))}
    txtstr(2)={sprintf('mean(Su) = %6.4f',mean([b(ii).wf.Su]))}
%     txtstr(3)={sprintf('mean(umax) = %6.4f [m ^. s^{-1}]',mean([b(ii).wf.umax]))}
%     txtstr(4)={sprintf('mean(umin) = %6.4f [m ^. s^{^-1}]',mean([b(ii).wf.umin]))}
    txtstr(3)={sprintf('ubs = %6.4f [m ^. s^{-1}]',wfr(ii).ubs)}
    txtstr(4)={sprintf('Hs = %5.2f [m]',wh_4061(ii))}
    txtstr(5)={sprintf('Tp = %5.2f [s]',wp_peak(ii))}
    txtstr(6)={sprintf('wvdir = %5.1f [^oT]',wvdir(ii))}

    text(1000,-1,txtstr,'verticalalignment','top')


    %save2pdf(sprintf('9917adv_iwaves_inburst_skewness_%s',gcf,300)
    saveas(gcf,sprintf('pngfiles\\9917adv_iwaves_inburst_skewness_%s.png',datestr(wfr(ii).dn,30)),'png')
    pause(1)
    
      
    end
end
