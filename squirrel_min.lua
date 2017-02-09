local assert,ipairs,pairs=assert,ipairs,pairs;local a,b,c=string.format,string.len,string.match;local d,e=debug.getinfo,debug.getlocal;local f,g=table.insert,table.remove;local unpack=table.unpack or unpack;local h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w;local x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,_,a0,a1,a2,a3,a4,a5,a6;m=_VERSION=='Lua 5.1'p=m and 3 or 2;r={'first','second','third'}n=function(...)return...end;q=function()end;h=function(a7,a8)for a9,aa in pairs(a8)do a7[a9]=aa end;return a7 end;i=function(a7)local a8={}for ab,aa in ipairs(a7)do f(a8,aa)end;return a8 end;j=function(a7,a8)local ac=i(a7)for ab,aa in ipairs(a8)do f(ac,aa)end;return ac end;k=m and n or function(ad)return l(o(ad),ad)end;l=function(ae,ad)if ae<1 then return ad end;return function(...)local af={...}if#af<ae then return l(ae-#af,X(ad,af))else return ad(...)end end end;o=function(ad)return d(ad,'u').nparams end;s=function(ad,af)return function(...)return ad(unpack(j(af,{...})))end end;t=function(...)local ag={...}local ah=g(ag,1)return function(...)local ai=ah(...)for ab,ad in ipairs(ag)do ai=ad(ai)end;return ai end end;u=function(...)local ag={...}return l(2,function(aj,ai)for ab,ad in ipairs(ag)do aj=ad(aj,ai)end;return aj end)end;v=function(a7)local a8={}for ak=#a7,1,-1 do f(a8,a7[ak])end;return a8 end;w=l(2,not _DEBUG and q or function(al,...)for ak,am in ipairs({...})do local an=c(am,'^%[(%a+)%]$')local ao=c(am,'^%.%.%.(%a+)$')local ap,ai=e(p,ak)local aq=type(ai)local ar,as;if an then ar=a('%s: %s arg must be list',al,r[ak])as=ar..a(', got %s',aq)assert(aq=='table',as)if b(an)>1 then ar=ar..a(' of %ss',an)for ab,aa in ipairs(ai)do aq=type(aa)as=ar..a(', got %s element',aq)assert(aq==an,as)end end elseif ao and b(ao)>1 then if not m then ar=a('%s: vararg must be all %ss',al,ao)local at=-1;ap,ai=e(p,at)while ai do aq=type(ai)as=ar..a(', got a %s',aq)assert(aq==ao,as)at=at-1;ap,ai=e(p,at)end end elseif b(am)>1 then as=a('%s: %s arg must be %s, got %s',al,r[ak],am,aq)assert(aq==am,as)end end end)x=l(2,function(a7,a8)w('add','number','number')return a7+a8 end)y=l(2,function(au,av)w('all','function','[a]')for ab,aa in ipairs(av)do if not au(aa)then return false end end;return true end)z=l(2,function(au,av)w('any','function','[a]')for ab,aa in ipairs(av)do if au(aa)then return true end end;return false end)A=function(...)w('compose','...function')return t(unpack(v({...})))end;B=function(...)w('composeR','...function')return u(unpack(v({...})))end;C=l(2,function(a7,a8)w('concat','[a]','[a]')return j(a7,a8)end)D=function(ad)w('curry','function')return k(ad)end;E=l(2,function(ae,ad)w('curryN','number','function')return l(ae,ad)end)G=l(2,function(ad,av)w('each','function','[a]')for ab,aa in ipairs(av)do ad(aa)end;return av end)H=l(2,function(a7,a8)return a7==a8 end)I=l(2,function(aw,ax)w('evolve','table','table')local ay={}for az,ai in pairs(ax)do local aA=aw[az]ay[az]=type(aA)=='function'and aA(ai)or type(aA)=='table'and I(aA,ai)or ai end;return ay end)F=function(ad)w('flip','function')return l(2,function(a7,a8,...)return ad(a8,a7,...)end)end;J=l(2,function(au,av)w('groupWith','function','[a]')local ay={{}}for ak,aa in ipairs(av)do f(ay[#ay],aa)if ak<#av and not au(aa,av[ak+1])then f(ay,{})end end;return ay end)K=l(2,function(a7,a8)w('gt','number','number')return a7>a8 end)L=function(av)w('head','[a]')return av[1]end;M=n;N=l(3,function(au,aB,aC)w('ifElse','function','function','function')return function(...)return au(...)and aB(...)or aC(...)end end)O=function(a7)w('init','[a]')local a8=i(a7)g(a8)return a8 end;P=l(2,function(aD,a7)w('is','string')return type(a7)==aD end)Q=function(av)w('last','[a]')return av[#av]end;R=l(2,function(a7,a8)w('lt','number','number')return a7<a8 end)S=l(2,function(ad,a7)w('map','function','[a]')local a8={}for ab,aa in ipairs(a7)do f(a8,ad(aa))end;return a8 end)T=l(2,function(a7,a8)w('max','number','number')return a7>a8 and a7 or a8 end)U=l(2,function(a7,a8)w('min','number','number')return a7<a8 and a7 or a8 end)V=l(2,function(a7,a8)w('multiply','number','number')return a7*a8 end)W=function(au)w('non','function')return function(...)return not au(...)end end;X=l(2,function(ad,af)w('partial','function','[a]')return s(ad,af)end)Y=l(2,function(aE,a7)w('pick','[string]','table')local a8={}for ab,az in ipairs(aE)do a8[az]=a7[az]end;return a8 end)Z=function(...)w('pipe','...function')return t(...)end;_=function(...)w('pipeR','...function')return u(...)end;a0=l(2,function(az,av)w('pluck','string','[table]')local ay={}for ak,aF in ipairs(av)do ay[ak]=aF[az]end;return ay end)a1=l(2,function(az,table)w('prop','string','table')return table[az]end)a2=l(3,function(ad,aj,av)w('reduce','function','a','[a]')for ab,ai in ipairs(av)do aj=ad(aj,ai)end;return aj end)a3=function(a7)w('reverse','[a]')return v(a7)end;a4=function(a7)w('tail','[a]')local a8=i(a7)g(a8,1)return a8 end;a5=function(ad)w('tap','function')return function(...)ad(...)return...end end;a6=l(2,function(au,aB)w('when','function','function')return function(...)return au(...)and aB(...)or...end end)local aG={add=x,all=y,any=z,compose=A,composeR=B,concat=C,curry=D,curryN=E,each=G,equals=H,evolve=I,flip=F,groupWith=J,gt=K,head=L,identity=M,ifElse=N,init=O,is=P,last=Q,lt=R,map=S,max=T,min=U,multiply=V,non=W,partial=X,pick=Y,pipe=Z,pipeR=_,pluck=a0,prop=a1,reduce=a2,reverse=a3,tail=a4,tap=a5,when=a6}aG.import=function(aH)aH=aH or _G;return h(aH,aG)end;return aG
