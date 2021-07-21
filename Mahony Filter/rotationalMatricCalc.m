function R=rotationalMatricCalc(theta1,theta2)

    Ry=[cos(theta1) 0 sin(theta1);
        0 1 0;
       -sin(theta1) 0 cos(theta1);];
   
   Rz=[cos(theta2) -sin(theta2) 0;
       sin(theta2) cos(theta2) 0;
       0 0 1;];
   
   R=Rz*Ry;
end