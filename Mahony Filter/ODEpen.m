function dy=ODEpen(q,t)
g=9.81;
L=0.5;

dy(1,1)=q(2);
dy(2,1)=-g*sin(q(1))/L^2;