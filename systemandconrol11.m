clear all
clc
close all

G=tf([900],[1 30 900]);
H=tf([1],[1]);
TF=feedback(G,H)

% system=append(G,H);
% Q=[1 -2;2 1];
% total=connect(system,Q,1,1);
% total=tf(total);

% title('systemtype:type 0')
t=0:0.01:2;
sys=G
figure;
   step(sys,t)
     figure;
  impulse(sys,t)

disp(stepinfo(TF))
% title('systemtype:type 0')
t=0:0.01:2;
systotal=TF
 figure;
 step(TF,t)
 figure;
  impulse(TF,t)
 
%  lsim(TF,(t.^2)/2,t)

%root locus 
figure;
rlocus(G)

% bodeplot
figure;
bode(G)




% steadystate error
syms t s

rt1=1*t/t;
rt2=t;
rt3=t^2/2;

r1=laplace(rt1)
r2=laplace(rt2)
r3=laplace(rt3)
g=900/s^2+30*s+900;
h=1;

ess1=limit(s*r1/(1+g),0)
ess2=limit(s*r2/(1+g),0)
ess3=limit(s*r3/(1+g),0)

% ess1 = limit(a1,0)
% ess2 = limit(a2,0)
% ess3 = limit(a3,0)



%%%%%%%%%%%%%%%%%(PID)%%%%%%%%%%%%%%%%%%%%%%

GCpid=tf([0.0202 1.42426 20],[1  0]);

GGCpid=G*GCpid
finalpid=feedback(GGCpid,H,-1)


gpid=((0.0202*s^2+1.42426*s+20)/s)

ess1pid= limit(s*r1/(1+g*gpid),0)
% ess2=limit(s*r2/(1+g*gpid),0)
% ess3=limit(s*r3/(1+g*gpid),0)
figure;
step(finalpid)
figure;
impulse(finalpid)
figure;
rlocus(GGCpid)
figure;
bodeplot(GGCpid)


%%%%%%%%%%%%%%%%%%%%%%(lagcompensator)%%%%%%%%%%%%%%%%%


Gclag=tf([1 1/5],[1 1/(19*5)])
GGClag=G*Gclag
finallag=feedback(GGClag,H,-1)



glag=(s+0.2)/(s+(1/95));
g=900/(s^2+30*s+900);

 ess1lag = limit(s*r1/(1+glag*g),0)
% ess2lag = limit(s*r2/(1+glag*g),0)
% ess3lag= limit(s*r3/(1+glag*g),0)


figure;
step(finallag)
figure;
impulse(finallag)
figure;
rlocus(GGClag)
figure;
bodeplot(GGClag)






