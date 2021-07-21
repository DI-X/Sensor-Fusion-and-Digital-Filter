function N=normalize(v)
normmm=sqrt(v(1)^2+v(2)^2+v(3)^2);
%normmm=v(1)+v(2)+v(3);
N(1,1)=v(1)/normmm;
N(2,1)=v(2)/normmm;
N(3,1)=v(3)/normmm;

