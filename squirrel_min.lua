local assert,ipairs,pairs=assert,ipairs,pairs;local a,b,c=string.format,string.len,string.match;local d,e=debug.getinfo,debug.getlocal;local f,g=table.insert,table.remove;local unpack=table.unpack or unpack;local h,i,j,k,l,m,n,o,p,q,r,s,t;local u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,_,a0,a1,a2,a3;local a4=_VERSION=='Lua 5.1'local a5=type(jit)=='table'local a6=a4 and not a5 and 3 or 2;local a7={'first','second','third'}m=function(...)return...end;o=function()end;h=function(a8,a9)for aa,ab in pairs(a9)do a8[aa]=ab end;return a8 end;i=function(a8)local a9={}for ac,ab in ipairs(a8)do f(a9,ab)end;return a9 end;j=function(a8,a9)local ad=i(a8)for ac,ab in ipairs(a9)do f(ad,ab)end;return ad end;k=a4 and m or function(ae)return l(n(ae),ae)end;l=function(af,ae)if af<1 then return ae end;return function(...)local ag={...}if#ag<af then return l(af-#ag,U(ae,ag))else return ae(...)end end end;n=function(ae)return d(ae,'u').nparams end;p=function(ae,ag)return function(...)return ae(unpack(j(ag,{...})))end end;q=function(...)local ah={...}local ai=g(ah,1)return function(...)local aj=ai(...)for ac,ae in ipairs(ah)do aj=ae(aj)end;return aj end end;r=function(...)local ah={...}return l(2,function(ak,aj)for ac,ae in ipairs(ah)do ak=ae(ak,aj)end;return ak end)end;s=function(a8)local a9={}for al=#a8,1,-1 do f(a9,a8[al])end;return a9 end;t=l(2,not _DEBUG and o or function(am,...)for al,an in ipairs({...})do local ao=c(an,'^%[(%a+)%]$')local ap=c(an,'^%.%.%.(%a+)$')local aq,aj=e(a6,al)local ar=type(aj)local as,at;if ao then as=a('%s: %s arg must be list',am,a7[al])at=as..a(', got %s',ar)assert(ar=='table',at)if b(ao)>1 then as=as..a(' of %ss',ao)for ac,ab in ipairs(aj)do ar=type(ab)at=as..a(', got %s element',ar)assert(ar==ao,at)end end elseif ap and b(ap)>1 then if not a4 then as=a('%s: vararg must be all %ss',am,ap)local au=-1;aq,aj=e(a6,au)while aj do ar=type(aj)at=as..a(', got a %s',ar)assert(ar==ap,at)au=au-1;aq,aj=e(a6,au)end end elseif b(an)>1 then at=a('%s: %s arg must be %s, got %s',am,a7[al],an,ar)assert(ar==an,at)end end end)u=l(2,function(a8,a9)t('add','number','number')return a8+a9 end)v=l(2,function(av,aw)t('all','function','[a]')for ac,ab in ipairs(aw)do if not av(ab)then return false end end;return true end)w=l(2,function(av,aw)t('any','function','[a]')for ac,ab in ipairs(aw)do if av(ab)then return true end end;return false end)x=function(...)t('compose','...function')return q(unpack(s({...})))end;y=function(...)t('composeR','...function')return r(unpack(s({...})))end;z=l(2,function(a8,a9)t('concat','[a]','[a]')return j(a8,a9)end)A=function(ae)t('curry','function')return k(ae)end;B=l(2,function(af,ae)t('curryN','number','function')return l(af,ae)end)D=l(2,function(ae,aw)t('each','function','[a]')for ac,ab in ipairs(aw)do ae(ab)end;return aw end)E=l(2,function(a8,a9)return a8==a9 end)F=l(2,function(ax,ay)t('evolve','table','table')local az={}for aA,aj in pairs(ay)do local aB=ax[aA]az[aA]=type(aB)=='function'and aB(aj)or type(aB)=='table'and F(aB,aj)or aj end;return az end)C=function(ae)t('flip','function')return l(2,function(a8,a9,...)return ae(a9,a8,...)end)end;G=l(2,function(av,aw)t('groupWith','function','[a]')local az={{}}for al,ab in ipairs(aw)do f(az[#az],ab)if al<#aw and not av(ab,aw[al+1])then f(az,{})end end;return az end)H=l(2,function(a8,a9)t('gt','number','number')return a8>a9 end)I=function(aw)t('head','[a]')return aw[1]end;J=m;K=l(3,function(av,aC,aD)t('ifElse','function','function','function')return function(...)return av(...)and aC(...)or aD(...)end end)L=function(a8)t('init','[a]')local a9=i(a8)g(a9)return a9 end;M=l(2,function(aE,a8)t('is','string')return type(a8)==aE end)N=function(aw)t('last','[a]')return aw[#aw]end;O=l(2,function(a8,a9)t('lt','number','number')return a8<a9 end)P=l(2,function(ae,a8)t('map','function','[a]')local a9={}for ac,ab in ipairs(a8)do f(a9,ae(ab))end;return a9 end)Q=l(2,function(a8,a9)t('max','number','number')return a8>a9 and a8 or a9 end)R=l(2,function(a8,a9)t('min','number','number')return a8<a9 and a8 or a9 end)S=l(2,function(a8,a9)t('multiply','number','number')return a8*a9 end)T=function(av)t('non','function')return function(...)return not av(...)end end;U=l(2,function(ae,ag)t('partial','function','[a]')return p(ae,ag)end)V=l(2,function(aF,a8)t('pick','[string]','table')local a9={}for ac,aA in ipairs(aF)do a9[aA]=a8[aA]end;return a9 end)W=function(...)t('pipe','...function')return q(...)end;X=function(...)t('pipeR','...function')return r(...)end;Y=l(2,function(aA,aw)t('pluck','string','[table]')local az={}for al,aG in ipairs(aw)do az[al]=aG[aA]end;return az end)Z=l(2,function(aA,table)t('prop','string','table')return table[aA]end)_=l(3,function(ae,ak,aw)t('reduce','function','a','[a]')for ac,aj in ipairs(aw)do ak=ae(ak,aj)end;return ak end)a0=function(a8)t('reverse','[a]')return s(a8)end;a1=function(a8)t('tail','[a]')local a9=i(a8)g(a9,1)return a9 end;a2=function(ae)t('tap','function')return function(...)ae(...)return...end end;a3=l(2,function(av,aC)t('when','function','function')return function(...)return av(...)and aC(...)or...end end)local aH={add=u,all=v,any=w,compose=x,composeR=y,concat=z,curry=A,curryN=B,each=D,equals=E,evolve=F,flip=C,groupWith=G,gt=H,head=I,identity=J,ifElse=K,init=L,is=M,last=N,lt=O,map=P,max=Q,min=R,multiply=S,non=T,partial=U,pick=V,pipe=W,pipeR=X,pluck=Y,prop=Z,reduce=_,reverse=a0,tail=a1,tap=a2,when=a3}aH.import=function(aI)aI=aI or _G;return h(aI,aH)end;return aH
