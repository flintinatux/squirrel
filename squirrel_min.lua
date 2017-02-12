local assert,ipairs,pairs=assert,ipairs,pairs;local a,b,c=string.format,string.len,string.match;local d,e=debug.getinfo,debug.getlocal;local f,g=table.insert,table.remove;local unpack=table.unpack or unpack;local h,i,j,k,l,m,n,o,p,q,r,s,t,u;local v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,_,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,aa,ab,ac;local ad=_VERSION=='Lua 5.1'local ae=type(jit)=='table'local af=ad and not ae and 3 or 2;local ag={'first','second','third'}m=function(...)return...end;p=function()end;h=function(ah,ai)for aj,ak in pairs(ai)do ah[aj]=ak end;return ah end;i=function(ah)local ai={}for al,ak in ipairs(ah)do f(ai,ak)end;return ai end;j=function(ah,ai)local am=i(ah)for al,ak in ipairs(ai)do f(am,ak)end;return am end;k=ad and m or function(an)return l(o(an),an)end;l=function(ao,an)if ao<1 then return an end;return function(...)local ap={...}if#ap<ao then return l(ao-#ap,a1(an,ap))else return an(...)end end end;n=function(ah)local ai={}for aj,ak in pairs(ah)do ai[ak]=aj end;return ai end;o=function(an)return d(an,'u').nparams end;q=function(an,ap)return function(...)return an(unpack(j(ap,{...})))end end;r=function(...)local aq={...}local ar=g(aq,1)return function(...)local as=ar(...)for al,an in ipairs(aq)do as=an(as)end;return as end end;s=function(...)local aq={...}return l(2,function(at,as)for al,an in ipairs(aq)do at=an(at,as)end;return at end)end;t=function(ah)local ai={}for au=#ah,1,-1 do f(ai,ah[au])end;return ai end;u=l(2,not _DEBUG and p or function(av,...)for au,aw in ipairs({...})do local ax=c(aw,'^%[(%a+)%]$')local ay=c(aw,'^%.%.%.(%a+)$')local az,as=e(af,au)local aA=type(as)local aB,aC;if ax then aB=a('%s: %s arg must be list',av,ag[au])aC=aB..a(', got %s',aA)assert(aA=='table',aC)if b(ax)>1 then aB=aB..a(' of %ss',ax)for al,ak in ipairs(as)do aA=type(ak)aC=aB..a(', got %s element',aA)assert(aA==ax,aC)end end elseif ay and b(ay)>1 then if not ad then aB=a('%s: vararg must be all %ss',av,ay)local aD=-1;az,as=e(af,aD)while as do aA=type(as)aC=aB..a(', got a %s',aA)assert(aA==ay,aC)aD=aD-1;az,as=e(af,aD)end end elseif b(aw)>1 then aC=a('%s: %s arg must be %s, got %s',av,ag[au],aw,aA)assert(aA==aw,aC)end end end)v=l(2,function(ah,ai)u('add','number','number')return ah+ai end)w=l(2,function(aE,aF)u('all','function','[a]')for al,ak in ipairs(aF)do if not aE(ak)then return false end end;return true end)x=l(2,function(aE,aF)u('any','function','[a]')for al,ak in ipairs(aF)do if aE(ak)then return true end end;return false end)y=function(...)u('compose','...function')return r(unpack(t({...})))end;z=function(...)u('composeR','...function')return s(unpack(t({...})))end;A=l(2,function(ah,ai)u('concat','[a]','[a]')return j(ah,ai)end)B=l(1,function(as)return function()return as end end)C=l(1,function(an)u('curry','function')return k(an)end)D=l(2,function(ao,an)u('curryN','number','function')return l(ao,an)end)E=l(2,function(an,aF)u('each','function','[a]')for al,ak in ipairs(aF)do an(ak)end;return aF end)F=l(2,function(ah,ai)return ah==ai end)G=l(2,function(aG,aH)u('evolve','table','table')local aI={}for aJ,as in pairs(aH)do local aK=aG[aJ]aI[aJ]=type(aK)=='function'and aK(as)or type(aK)=='table'and G(aK,as)or as end;return aI end)H=l(2,function(aE,aF)u('filter','function','[a]')local aI={}for al,as in ipairs(aF)do if aE(as)then f(aI,as)end end;return aI end)I=l(1,function(an)u('flip','function')return l(2,function(ah,ai,...)return an(ai,ah,...)end)end)J=l(2,function(aE,aF)u('groupWith','function','[a]')local aI={{}}for au,ak in ipairs(aF)do f(aI[#aI],ak)if au<#aF and not aE(ak,aF[au+1])then f(aI,{})end end;return aI end)K=l(2,function(ah,ai)u('gt','number','number')return ah>ai end)L=l(1,function(aF)u('head','[a]')return aF[1]end)M=l(1,m)N=l(3,function(aE,aL,aM)u('ifElse','function','function','function')return function(...)return aE(...)and aL(...)or aM(...)end end)O=l(1,function(ah)u('init','[a]')local ai=i(ah)g(ai)return ai end)P=l(1,function(aN)u('invert','table')return n(aN)end)Q=l(2,function(aO,ah)u('is','string')return type(ah)==aO end)R=l(1,function(aH)u('keys','table')local aI={}for aj,al in pairs(aH)do f(aI,aj)end;return aI end)S=l(1,function(aF)u('last','[a]')return aF[#aF]end)T=l(2,function(ah,ai)u('lt','number','number')return ah<ai end)U=l(2,function(an,ah)u('map','function','[a]')local ai={}for al,ak in ipairs(ah)do f(ai,an(ak))end;return ai end)V=l(2,function(ah,ai)u('max','number','number')return ah>ai and ah or ai end)W=l(2,function(ah,ai)u('merge','table','table')local aI={}h(aI,ah)h(aI,ai)return aI end)X=l(2,function(ah,ai)u('min','number','number')return ah<ai and ah or ai end)Y=l(2,function(ah,ai)u('multiply','number','number')return ah*ai end)Z=l(1,function(aE)u('non','function')return function(...)return not aE(...)end end)_=p;a0=l(2,function(aP,aN)u('omit','[string]','table')local aI={}aP=n(aP)for aJ,as in pairs(aN)do if not aP[aJ]then aI[aJ]=as end end;return aI end)a1=l(2,function(an,ap)u('partial','function','[a]')return q(an,ap)end)a2=l(2,function(aP,ah)u('pick','[string]','table')local ai={}for al,aJ in ipairs(aP)do ai[aJ]=ah[aJ]end;return ai end)a3=function(...)u('pipe','...function')return r(...)end;a4=function(...)u('pipeR','...function')return s(...)end;a5=l(2,function(aJ,aF)u('pluck','string','[table]')local aI={}for au,aQ in ipairs(aF)do aI[au]=aQ[aJ]end;return aI end)a6=l(2,function(aJ,table)u('prop','string','table')return table[aJ]end)a7=l(3,function(an,at,aF)u('reduce','function','a','[a]')for al,as in ipairs(aF)do at=an(at,as)end;return at end)a8=l(1,function(ah)u('reverse','[a]')return t(ah)end)a9=l(1,function(ah)u('tail','[a]')local ai=i(ah)g(ai,1)return ai end)aa=l(1,function(an)u('tap','function')return function(...)an(...)return...end end)ab=l(2,function(an,aR)u('unfold','function','a')local aI={}local as=an(aR)while as do f(aI,as[1])as=an(as[2])end;return aI end)ac=l(2,function(aE,aL)u('when','function','function')return function(...)return aE(...)and aL(...)or...end end)local aS={add=v,all=w,any=x,compose=y,composeR=z,concat=A,constant=B,curry=C,curryN=D,each=E,equals=F,evolve=G,filter=H,flip=I,groupWith=J,gt=K,head=L,identity=M,ifElse=N,init=O,invert=P,is=Q,keys=R,last=S,lt=T,map=U,max=V,merge=W,min=X,multiply=Y,omit=a0,non=Z,noop=_,partial=a1,pick=a2,pipe=a3,pipeR=a4,pluck=a5,prop=a6,reduce=a7,reverse=a8,tail=a9,tap=aa,unfold=ab,when=ac}aS.import=function(aT)aT=aT or _G;return h(aT,aS)end;return aS
