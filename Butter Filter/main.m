%% get butter filter
fc = 5; %cut off frequency
fs = 100; %sampling frequency

[b,a] = butter(4,fc/(fs/2));
%% implement butter filter

t=0;
for n=1:200
    t=t+0.01;
    x(n)=sin(2*pi*t)+0.5*sin(10*2*pi*t); %input signal
    if n>4
        Y(n)=1/a(1)*(-(a(2)*Y(n-1)+a(3)*Y(n-2)+a(4)*Y(n-3)+a(5)*Y(n-4))...
            +(b(1)*x(n)+b(2)*x(n-1)+b(3)*x(n-2)+b(4)*x(n-3)+b(5)*x(n-4)));
    else
        Y(n)=x(n);
    end
    tHi(n)=t;
end

%% Draw figures

figure(1)
plot(tHi,x)
title('input');
xlabel('time (sec)');

figure(2)
plot(tHi,Y)
title('Filtered output');
xlabel('time (sec)');