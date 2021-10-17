clc;
clear;
% 确定采样点数和中心点
% M为x轴方向半波对称阵子个数
% N为y轴方向对称阵子个数
M=43;
N=31;
% M1和N1分别为M和N的中位数
M1=(M-1)/2;
N1=(N-1)/2;
lambda=0.1;
% dx和dy为对称阵子沿x方向的间距和沿y方向的间距
% d和d1是取样面距离阵子面的距离
dx=0.7*lambda;
dy=dx;
d=4.5*lambda;
d1=6.5*lambda;
% deltax和deltay为在x轴和y轴上的采样间距
deltax=0.45*lambda;
deltay=0.45*lambda;
% Mc和Nc分别为沿x和y方向的采样点
Mc=133;
Nc=95;
% Mc1和Nc2为Mc和Nc的中位数
Mc1=(Mc-1)/2;
Nc1=(Nc-1)/2;
% 第(m,n)号阵列单元的中心点坐标为((m-M1-1)dx,(n-N1-1)dy)
% 第(m,n)号阵列单元的两个端点的坐标为((m-M1-1)dx+lanbda/4和(m-M1-1)dx-lanbda/4,(n-N1-1)dy,0)
% 我们令Xm1点的坐标为(m-M1-1)dx+lambda/4
% 令Xm11点的坐标为(m-M1-1)dx-lambda/4
% 令阵子y轴的坐标为(n-N1-1)dy即yn
% 令取样点x轴坐标为(l1-M2-1)*deltax即Xl1
% 令取样点y轴坐标为(l2-N2-1)*deltay即yl2
Xm1=[];
Xm11=[];
yn=[];
Xl1=[];
yl2=[];
% 在这里Xm1(m)是阵子上臂的坐标，验证的思路是第22个阵子的上臂坐标应该是0.025
for m=1:1:M
    Xm1(m)=(m-M1-1)*dx+lambda/4;
end
% 在这里Xm11(m)是阵子下臂的坐标，验证的思路是第22个阵子的下臂坐标应该是-0.025
for m=1:1:M
    Xm11(m)=(m-M1-1)*dx-lambda/4;
end
% 在这里yn(n)是阵子中心y轴的坐标，验证的思路是第16个阵子为0
for n=1:1:N
    yn(n)=(n-N1-1)*dy;
end
% 在这里l1为采样点的x轴坐标，验证的思路是第67个阵子x轴坐标为0
for l1=1:1:Mc
    Xl1(l1)=(l1-Mc1-1)*deltax;
end
% 在这里l2为采样点的y轴坐标，验证的思路是第48个为0
for l2=1:1:Nc
    yl2(l2)=(l2-Nc1-1)*deltay;
end
% 接下来计算R1mn,R2mn和Ex
% R1mn和R2mn分别为天线阵子上臂和下臂到取样点的距离
% Ex表示取样点x方向距离为d的电场
% Ex1表示取样点x方向距离为d1的电场
% Ey表示取样点y方向的电场
% add为叠加变量
R1mn=[];
R2mn=[];
Ex=[];
Ey=[];
Ex1=[];
Rhon=[];
add=0;
add1=0;
for p=1:1:Mc
    for q=1:1:Nc
        for m=1:1:M
            for n=1:1:N
                R1mn(m,n)=sqrt((Xm1(m)-Xl1(p))^2+(yn(n)-yl2(q))^2+d^2);
                R2mn(m,n)=sqrt((Xm11(m)-Xl1(p))^2+(yn(n)-yl2(q))^2+d^2);
                R1mn1(m,n)=sqrt((Xm1(m)-Xl1(p))^2+(yn(n)-yl2(q))^2+d1^2);
                R2mn1(m,n)=sqrt((Xm11(m)-Xl1(p))^2+(yn(n)-yl2(q))^2+d1^2);
                Rhon(n)=sqrt((yl2(q)-yn(n))^2+d^2);
                add1=add1+((Xl1(p)-Xm1(m))/Rhon(n)*exp(-1i*2*pi/lambda*R1mn(m,n))+(Xl1(p)-Xm11(m))/Rhon(n)*exp(-1i*2*pi/lambda*R2mn(m,n))/R2mn(m,n))*(yl2(q)-yn(n))/Rhon(n);
                add=add+exp(-1i*2*pi/lambda*R1mn(m,n))/R1mn(m,n)+exp(-1i*2*pi/lambda*R2mn(m,n))/R2mn(m,n);
                add2=add+exp(-1i*2*pi/lambda*R1mn1(m,n))/R1mn1(m,n)+exp(-1i*2*pi/lambda*R2mn1(m,n))/R2mn1(m,n);
            end
        end
        Ex(p,q)=-1i*30*add;
        Ey(p,q)=1i*30*add1;
        Ex1(p,q)=-1i*20*add2;
        add1=0;
        add=0;
        add2=0;
    end
end
% Ex_amp是d等于4.5个波长时电场的幅度
% Ex_phase是d等于4.5个波长时电场的相位
% Ex1_amp是d等于6.5个波长时电场的幅度
% Ex1_phase是d等于6.5个波长时电场的幅度
Ex_amp=20*log10(abs(Ex));
Ey_amp=20*log10(abs(Ey));
Ey_phase=angle(Ey)*180/pi;
Ex_phase=angle(Ex)*180/pi;
Ex1_amp=20*log10(abs(Ex1));
Ex1_phase=angle(Ex1)*180/pi;
% 将Ex的幅度和相位画成图像
figure(1)
subplot(211)
surf(Ex_amp);  
subplot(212)
surf(Ex_phase);
% 将Ey1的幅度和相位画成图像
figure(2)
subplot(211)
surf(Ey_amp);
subplot(212)
surf(Ey_phase);
% 将Ex1的幅度和相位画成图像
figure(3)
subplot(211)
surf(Ex1_amp);
subplot(212)
surf(Ex1_phase);