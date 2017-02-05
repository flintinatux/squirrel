local assert,ipairs,pairs=assert,ipairs,pairs;local a,b,c=string.format,string.len,string.match;local d,e=debug.getinfo,debug.getlocal;local f,g,h=table.insert,table.remove,table.unpack;local i,j,k,l,m,n,o,p,q,r,s,t;local u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;p={'first','second','third'}i=function(S,T)for U,V in pairs(T)do S[U]=V end;return S end;j=function(S)local T={}for W,V in ipairs(S)do f(T,V)end;return T end;k=function(S,T)local X=j(S)for W,V in ipairs(T)do f(X,V)end;return X end;l=function(Y)return m(n(Y),Y)end;m=function(Z,Y)if Z<1 then return Y end;return function(...)local _={...}if#_<Z then return m(Z-#_,L(Y,_))else return Y(...)end end end;n=function(Y)return d(Y,'u').nparams end;o=function()end;q=function(Y,_)return function(...)return Y(h(k(_,{...})))end end;r=function(...)local a0={...}local a1=g(a0,1)return function(...)local a2=a1(...)for W,Y in ipairs(a0)do a2=Y(a2)end;return a2 end end;s=function(S)local T={}for a3=#S,1,-1 do f(T,S[a3])end;return T end;t=m(2,not _DEBUG and o or function(a4,...)for a3,a5 in ipairs({...})do local a6=c(a5,'^%[(%a+)%]$')local a7=c(a5,'^%.%.%.(%a+)$')local a8,a2=e(2,a3)local a9=type(a2)local aa,ab;if a6 then aa=a('%s: %s arg must be list',a4,p[a3])ab=aa..a(', got %s',a9)assert(a9=='table',ab)if b(a6)>1 then aa=aa..a(' of %ss',a6)for W,V in ipairs(a2)do a9=type(V)ab=aa..a(', got %s element',a9)assert(a9==a6,ab)end end elseif a7 and b(a7)>1 then aa=a('%s: vararg must be all %ss',a4,a7)local ac=-1;a8,a2=e(2,ac)while a2 do a9=type(a2)ab=aa..a(', got a %s',a9)assert(a9==a7,ab)ac=ac-1;a8,a2=e(2,ac)end elseif b(a5)>1 then ab=a('%s: %s arg must be %s, got %s',a4,p[a3],a5,a9)assert(a9==a5,ab)end end end)u=m(2,function(S,T)t('add','number','number')return S+T end)v=m(2,function(ad,ae)t('all','function','[a]')for W,V in ipairs(ae)do if not ad(V)then return false end end;return true end)w=m(2,function(ad,ae)t('any','function','[a]')for W,V in ipairs(ae)do if ad(V)then return true end end;return false end)x=function(...)t('compose','...function')return r(h(s({...})))end;y=m(2,function(S,T)t('concat','[a]','[a]')return k(S,T)end)z=function(Y)t('curry','function')return l(Y)end;A=m(2,function(Z,Y)t('curryN','number','function')return m(Z,Y)end)C=m(2,function(S,T)return S==T end)D=m(2,function(af,ag)t('evolve','table','table')local ah={}for ai,a2 in pairs(ag)do local aj=af[ai]ah[ai]=type(aj)=='function'and aj(a2)or type(aj)=='table'and D(aj,a2)or a2 end;return ah end)B=function(Y)t('flip','function')Y=l(Y)return m(2,function(S,T,...)return Y(T,S,...)end)end;E=function(ae)t('head','[a]')return ae[1]end;F=function(...)return...end;G=function(S)t('init','[a]')local T=j(S)g(T)return T end;H=m(2,function(ak,S)t('is','string')return type(S)==ak end)I=function(ae)t('last','[a]')return ae[#ae]end;J=m(2,function(Y,S)t('map','function','[a]')local T={}for W,V in ipairs(S)do f(T,Y(V))end;return T end)K=m(2,function(S,T)t('multiply','number','number')return S*T end)L=m(2,function(Y,_)t('partial','function','[a]')return q(Y,_)end)M=m(2,function(al,S)t('pick','[string]','table')local T={}for W,ai in ipairs(al)do T[ai]=S[ai]end;return T end)N=function(...)t('pipe','...function')return r(...)end;O=m(2,function(ai,table)t('prop','string','table')return table[ai]end)P=m(3,function(Y,am,ae)t('reduce','function','a','[a]')for W,a2 in ipairs(ae)do am=Y(am,a2)end;return am end)Q=function(S)t('reverse','[a]')return s(S)end;R=function(S)t('tail','[a]')local T=j(S)g(T,1)return T end;local an={add=u,all=v,any=w,compose=x,concat=y,curry=z,curryN=A,equals=C,evolve=D,flip=B,head=E,identity=F,init=G,is=H,last=I,map=J,multiply=K,partial=L,pick=M,pipe=N,prop=O,reduce=P,reverse=Q,tail=R}an.import=function(ao)ao=ao or _G;return i(ao,an)end;return an
