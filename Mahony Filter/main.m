%% generate trajectroy of Pendulum
tspan=[0 60];
q0=[30/180*pi; 0];

[tf,qf]=ode45(@(tf,qf) ODEpen(qf,tf),tspan,q0); 

%% initial guess of bias and rotation matrix
bhat=[0;0;0;];
Rhat=[1 0 0;
      0 1 0;
      0 0 1;];

%% test Mahony filter  

Rhat=rotationalMatricCalc(90/180*pi,q0(1,1))';

t=0;
deltTm=0;
for i=1:12000
    
    t=t+0.005;  % sampling frequency 200 Hz
    [I,d]=min(abs(tf-t));
    theta2=qf(d,1);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%% set gyro
    if t<30
        b=[1;2;0.5];        %gyro bias
    else
        b=[1.5;2.5;1];
    end
    
    gyrTrue=[0;0;qf(d,2);]; %gyro - angular vel   
    myu=randn*0.05;          %gyro noise
    gyro=gyrTrue+b+myu;     %gyro sensor output
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    deltaT=tf(d)-deltTm;
    theta1=90/180*pi;
    R=rotationalMatricCalc(theta1,theta2); % calculate the orientation of gyro
    
    v(:,1)=[0;0;1];
    v(:,2)=[0;1;0];
    v(:,3)=[1;0;0];
    [bhat,Rhat]=MahonyFilter(bhat,Rhat,gyro,v,R,deltaT);
    
    %%%%%%%%%%%%%%%% post process
    deltTm=tf(d);
    bhatHis(:,i)=bhat;
    bHis(:,i)=b;
    timeHis(i)=t;
    gyroHis(:,i)=gyro;
    %%%%%%%%%%%%%%%%%%%%
end

%% Draw Graph

figure(1)
plot(timeHis,bHis(1,:),timeHis,bHis(2,:),timeHis,bHis(3,:))
hold on
plot(timeHis,bhatHis(1,:),timeHis,bhatHis(2,:),timeHis,bhatHis(3,:))
legend('b1','b2','b3','b1hat','b2hat','b3hat')
title('Gyro Bias estimation')
xlabel('time (sec)')
ylabel('rad/sec')
hold off

figure(2)
plot(timeHis,gyroHis(1,:),timeHis,gyroHis(2,:),timeHis,gyroHis(3,:))
legend('g1','g2','g3')
title('Gyro output')
xlabel('time (sec)')
ylabel('rad/sec')

figure(3)
plot(timeHis,gyroHis(1,:)-bhatHis(1,:))
hold on
plot(timeHis,gyroHis(2,:)-bhatHis(2,:))
plot(timeHis,gyroHis(3,:)-bhatHis(3,:))

legend('angV1','angV2','angV3')
title('Filtered Gyro output')
xlabel('time (sec)')
ylabel('rad/sec')
hold off