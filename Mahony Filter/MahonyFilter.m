function [bhatNew,RhatNew]=MahonyFilter(bhat,Rhat,gyro,v,R,deltaT)
kI=0.5;
kP=1.5;
deltaT=0.005;

wmes=0;

for i=1:size(v,2)
    v0(:,i)=R*v(:,i);
    v0(:,i)=normalize(v0(:,i));
    vihat(:,i)=Rhat'*v0(:,i);
    vihat(:,i)=normalize(vihat(:,i));
    
    wmes=kI*vectorCross(v0(:,i),vihat(:,i))+wmes;
end

bhatNew=bhat-kI*wmes'*deltaT;
RhatNew=Rhat+deltaT*Rhat*(vec2Mat(gyro-bhatNew)+kP*vec2Mat(wmes));