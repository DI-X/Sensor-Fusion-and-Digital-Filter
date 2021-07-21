function x=vectorCross(v1,v2)

x(1)=v1(2)*v2(3)-v1(3)*v2(2);
x(2)=-(v1(1)*v2(3)-v1(3)*v2(1));
x(3)=v1(1)*v2(2)-v1(2)*v2(1);