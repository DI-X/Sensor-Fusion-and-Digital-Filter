function M=vec2Mat(v)

M=[0 -v(3) v(2);
   v(3) 0 -v(1);
   -v(2) v(1) 0;];