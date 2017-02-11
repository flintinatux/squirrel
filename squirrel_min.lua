local assert,ipairs,pairs=assert,ipairs,pairs;local a,b,c=string.format,string.len,string.match;local d,e=debug.getinfo,debug.getlocal;local f,g=table.insert,table.remove;local unpack=table.unpack or unpack;local h,i,j,k,l,m,n,o,p,q,r,s,t,u;local v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,_,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,aa;local ab=_VERSION=='Lua 5.1'local ac=type(jit)=='table'local ad=ab and not ac and 3 or 2;local ae={'first','second','third'}m=function(...)return...end;p=function()end;h=function(af,ag)for ah,ai in pairs(ag)do af[ah]=ai end;return af end;i=function(af)local ag={}for aj,ai in ipairs(af)do f(ag,ai)end;return ag end;j=function(af,ag)local ak=i(af)for aj,ai in ipairs(ag)do f(ak,ai)end;return ak end;k=ab and m or function(al)return l(o(al),al)end;l=function(am,al)if am<1 then return al end;return function(...)local an={...}if#an<am then return l(am-#an,a0(al,an))else return al(...)end end end;n=function(af)local ag={}for ah,ai in pairs(af)do ag[ai]=ah end;return ag end;o=function(al)return d(al,'u').nparams end;q=function(al,an)return function(...)return al(unpack(j(an,{...})))end end;r=function(...)local ao={...}local ap=g(ao,1)return function(...)local aq=ap(...)for aj,al in ipairs(ao)do aq=al(aq)end;return aq end end;s=function(...)local ao={...}return l(2,function(ar,aq)for aj,al in ipairs(ao)do ar=al(ar,aq)end;return ar end)end;t=function(af)local ag={}for as=#af,1,-1 do f(ag,af[as])end;return ag end;u=l(2,not _DEBUG and p or function(at,...)for as,au in ipairs({...})do local av=c(au,'^%[(%a+)%]$')local aw=c(au,'^%.%.%.(%a+)$')local ax,aq=e(ad,as)local ay=type(aq)local az,aA;if av then az=a('%s: %s arg must be list',at,ae[as])aA=az..a(', got %s',ay)assert(ay=='table',aA)if b(av)>1 then az=az..a(' of %ss',av)for aj,ai in ipairs(aq)do ay=type(ai)aA=az..a(', got %s element',ay)assert(ay==av,aA)end end elseif aw and b(aw)>1 then if not ab then az=a('%s: vararg must be all %ss',at,aw)local aB=-1;ax,aq=e(ad,aB)while aq do ay=type(aq)aA=az..a(', got a %s',ay)assert(ay==aw,aA)aB=aB-1;ax,aq=e(ad,aB)end end elseif b(au)>1 then aA=a('%s: %s arg must be %s, got %s',at,ae[as],au,ay)assert(ay==au,aA)end end end)v=l(2,function(af,ag)u('add','number','number')return af+ag end)w=l(2,function(aC,aD)u('all','function','[a]')for aj,ai in ipairs(aD)do if not aC(ai)then return false end end;return true end)x=l(2,function(aC,aD)u('any','function','[a]')for aj,ai in ipairs(aD)do if aC(ai)then return true end end;return false end)y=function(...)u('compose','...function')return r(unpack(t({...})))end;z=function(...)u('composeR','...function')return s(unpack(t({...})))end;A=l(2,function(af,ag)u('concat','[a]','[a]')return j(af,ag)end)B=l(1,function(aq)return function()return aq end end)C=l(1,function(al)u('curry','function')return k(al)end)D=l(2,function(am,al)u('curryN','number','function')return l(am,al)end)E=l(2,function(al,aD)u('each','function','[a]')for aj,ai in ipairs(aD)do al(ai)end;return aD end)F=l(2,function(af,ag)return af==ag end)G=l(2,function(aE,aF)u('evolve','table','table')local aG={}for aH,aq in pairs(aF)do local aI=aE[aH]aG[aH]=type(aI)=='function'and aI(aq)or type(aI)=='table'and G(aI,aq)or aq end;return aG end)H=l(2,function(aC,aD)u('filter','function','[a]')local aG={}for aj,aq in ipairs(aD)do if aC(aq)then f(aG,aq)end end;return aG end)I=l(1,function(al)u('flip','function')return l(2,function(af,ag,...)return al(ag,af,...)end)end)J=l(2,function(aC,aD)u('groupWith','function','[a]')local aG={{}}for as,ai in ipairs(aD)do f(aG[#aG],ai)if as<#aD and not aC(ai,aD[as+1])then f(aG,{})end end;return aG end)K=l(2,function(af,ag)u('gt','number','number')return af>ag end)L=l(1,function(aD)u('head','[a]')return aD[1]end)M=l(1,m)N=l(3,function(aC,aJ,aK)u('ifElse','function','function','function')return function(...)return aC(...)and aJ(...)or aK(...)end end)O=l(1,function(af)u('init','[a]')local ag=i(af)g(ag)return ag end)P=l(1,function(aL)u('invert','table')return n(aL)end)Q=l(2,function(aM,af)u('is','string')return type(af)==aM end)R=l(1,function(aD)u('last','[a]')return aD[#aD]end)S=l(2,function(af,ag)u('lt','number','number')return af<ag end)T=l(2,function(al,af)u('map','function','[a]')local ag={}for aj,ai in ipairs(af)do f(ag,al(ai))end;return ag end)U=l(2,function(af,ag)u('max','number','number')return af>ag and af or ag end)V=l(2,function(af,ag)u('merge','table','table')local aG={}h(aG,af)h(aG,ag)return aG end)W=l(2,function(af,ag)u('min','number','number')return af<ag and af or ag end)X=l(2,function(af,ag)u('multiply','number','number')return af*ag end)Y=l(1,function(aC)u('non','function')return function(...)return not aC(...)end end)Z=p;_=l(2,function(aN,aL)u('omit','[string]','table')local aG={}aN=n(aN)for aH,aq in pairs(aL)do if not aN[aH]then aG[aH]=aq end end;return aG end)a0=l(2,function(al,an)u('partial','function','[a]')return q(al,an)end)a1=l(2,function(aN,af)u('pick','[string]','table')local ag={}for aj,aH in ipairs(aN)do ag[aH]=af[aH]end;return ag end)a2=function(...)u('pipe','...function')return r(...)end;a3=function(...)u('pipeR','...function')return s(...)end;a4=l(2,function(aH,aD)u('pluck','string','[table]')local aG={}for as,aO in ipairs(aD)do aG[as]=aO[aH]end;return aG end)a5=l(2,function(aH,table)u('prop','string','table')return table[aH]end)a6=l(3,function(al,ar,aD)u('reduce','function','a','[a]')for aj,aq in ipairs(aD)do ar=al(ar,aq)end;return ar end)a7=l(1,function(af)u('reverse','[a]')return t(af)end)a8=l(1,function(af)u('tail','[a]')local ag=i(af)g(ag,1)return ag end)a9=l(1,function(al)u('tap','function')return function(...)al(...)return...end end)aa=l(2,function(aC,aJ)u('when','function','function')return function(...)return aC(...)and aJ(...)or...end end)local aP={add=v,all=w,any=x,compose=y,composeR=z,concat=A,constant=B,curry=C,curryN=D,each=E,equals=F,evolve=G,filter=H,flip=I,groupWith=J,gt=K,head=L,identity=M,ifElse=N,init=O,invert=P,is=Q,last=R,lt=S,map=T,max=U,merge=V,min=W,multiply=X,omit=_,non=Y,noop=Z,partial=a0,pick=a1,pipe=a2,pipeR=a3,pluck=a4,prop=a5,reduce=a6,reverse=a7,tail=a8,tap=a9,when=aa}aP.import=function(aQ)aQ=aQ or _G;return h(aQ,aP)end;return aP
