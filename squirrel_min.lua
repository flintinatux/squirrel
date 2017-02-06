local assert,ipairs,pairs=assert,ipairs,pairs;local a,b,c=string.format,string.len,string.match;local d,e=debug.getinfo,debug.getlocal;local f,g,h=table.insert,table.remove,table.unpack;local i,j,k,l,m,n,o,p,q,r,s,t;local u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U;p={'first','second','third'}i=function(V,W)for X,Y in pairs(W)do V[X]=Y end;return V end;j=function(V)local W={}for Z,Y in ipairs(V)do f(W,Y)end;return W end;k=function(V,W)local _=j(V)for Z,Y in ipairs(W)do f(_,Y)end;return _ end;l=function(a0)return m(n(a0),a0)end;m=function(a1,a0)if a1<1 then return a0 end;return function(...)local a2={...}if#a2<a1 then return m(a1-#a2,N(a0,a2))else return a0(...)end end end;n=function(a0)return d(a0,'u').nparams end;o=function()end;q=function(a0,a2)return function(...)return a0(h(k(a2,{...})))end end;r=function(...)local a3={...}local a4=g(a3,1)return function(...)local a5=a4(...)for Z,a0 in ipairs(a3)do a5=a0(a5)end;return a5 end end;s=function(V)local W={}for a6=#V,1,-1 do f(W,V[a6])end;return W end;t=m(2,not _DEBUG and o or function(a7,...)for a6,a8 in ipairs({...})do local a9=c(a8,'^%[(%a+)%]$')local aa=c(a8,'^%.%.%.(%a+)$')local ab,a5=e(2,a6)local ac=type(a5)local ad,ae;if a9 then ad=a('%s: %s arg must be list',a7,p[a6])ae=ad..a(', got %s',ac)assert(ac=='table',ae)if b(a9)>1 then ad=ad..a(' of %ss',a9)for Z,Y in ipairs(a5)do ac=type(Y)ae=ad..a(', got %s element',ac)assert(ac==a9,ae)end end elseif aa and b(aa)>1 then ad=a('%s: vararg must be all %ss',a7,aa)local af=-1;ab,a5=e(2,af)while a5 do ac=type(a5)ae=ad..a(', got a %s',ac)assert(ac==aa,ae)af=af-1;ab,a5=e(2,af)end elseif b(a8)>1 then ae=a('%s: %s arg must be %s, got %s',a7,p[a6],a8,ac)assert(ac==a8,ae)end end end)u=m(2,function(V,W)t('add','number','number')return V+W end)v=m(2,function(ag,ah)t('all','function','[a]')for Z,Y in ipairs(ah)do if not ag(Y)then return false end end;return true end)w=m(2,function(ag,ah)t('any','function','[a]')for Z,Y in ipairs(ah)do if ag(Y)then return true end end;return false end)x=function(...)t('compose','...function')return r(h(s({...})))end;y=m(2,function(V,W)t('concat','[a]','[a]')return k(V,W)end)z=function(a0)t('curry','function')return l(a0)end;A=m(2,function(a1,a0)t('curryN','number','function')return m(a1,a0)end)C=m(2,function(V,W)return V==W end)D=m(2,function(ai,aj)t('evolve','table','table')local ak={}for al,a5 in pairs(aj)do local am=ai[al]ak[al]=type(am)=='function'and am(a5)or type(am)=='table'and D(am,a5)or a5 end;return ak end)B=function(a0)t('flip','function')a0=l(a0)return m(2,function(V,W,...)return a0(W,V,...)end)end;E=function(ah)t('head','[a]')return ah[1]end;F=function(...)return...end;G=m(3,function(ag,an,ao)t('ifElse','function','function','function')return function(...)return ag(...)and an(...)or ao(...)end end)H=function(V)t('init','[a]')local W=j(V)g(W)return W end;I=m(2,function(ap,V)t('is','string')return type(V)==ap end)J=function(ah)t('last','[a]')return ah[#ah]end;K=m(2,function(a0,V)t('map','function','[a]')local W={}for Z,Y in ipairs(V)do f(W,a0(Y))end;return W end)L=m(2,function(V,W)t('multiply','number','number')return V*W end)M=function(ag)t('non','function')return function(...)return not ag(...)end end;N=m(2,function(a0,a2)t('partial','function','[a]')return q(a0,a2)end)O=m(2,function(aq,V)t('pick','[string]','table')local W={}for Z,al in ipairs(aq)do W[al]=V[al]end;return W end)P=function(...)t('pipe','...function')return r(...)end;Q=m(2,function(al,table)t('prop','string','table')return table[al]end)R=m(3,function(a0,ar,ah)t('reduce','function','a','[a]')for Z,a5 in ipairs(ah)do ar=a0(ar,a5)end;return ar end)S=function(V)t('reverse','[a]')return s(V)end;T=function(V)t('tail','[a]')local W=j(V)g(W,1)return W end;U=m(2,function(ag,an)t('when','function','function')return function(...)return ag(...)and an(...)or...end end)local as={add=u,all=v,any=w,compose=x,concat=y,curry=z,curryN=A,equals=C,evolve=D,flip=B,head=E,identity=F,ifElse=G,init=H,is=I,last=J,map=K,multiply=L,non=M,partial=N,pick=O,pipe=P,prop=Q,reduce=R,reverse=S,tail=T,when=U}as.import=function(at)at=at or _G;return i(at,as)end;return as
