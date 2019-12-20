%load mat\puv_proc_FI_iwaves2 raw depth fs zr zp dn

datin.bn=bn;
datin.dn=dn(bn);
datin.depth=depth(bn);
datin.fs=fs;
datin.zr=zr(bn)
datin.zp=zp(bn)
datin.u=raw(bn).u;
datin.v=raw(bn).v;
datin.p=raw(bn).p;