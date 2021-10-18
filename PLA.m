% 产生#1平面的范围为[-180,180]的随机相位
Ex_arb_phase=randi([-180,180],133,95);
% 生成初始迭代场E_iter_1
E_iter_1=[];
for i=1:1:Mc
    for j=1:1:Nc
        E_iter_1=Ex_amp.*cosd(Ex_arb_phase)+1i*Ex_amp.*sind(Ex_arb_phase);
    end
end
%使用近场数据变换远场和迭代场做下对比
% figure(1)
% Ex_Far=fftshift(fft2(Ex1));
% surf(20*log10(abs(Ex_Far)));
%我们尝试用迭代场变换远场，发现迭代场变换的远场完全不对
% figure(2)
% E_iter_1_Far=fftshift(fft2(E_iter_1,512,512));
% surf(20*log10(abs(E_iter_1_Far)))
%对迭代场进行傅里叶变换
E_iter_2_1=fftshift(fft2(E_iter_1,512,512));
p=1;
q=1;
for j=-256:1:255
    for k=-256:1:255
        E_iter_2(p,q)=E_iter_2_1(p,q)*exp(1i*sqrt((2*pi/lambda)^2-(2*pi*j/512/deltax)^2-(2*pi*k/512/deltay)));        
        q=q+1;
    end
    p=p+1;
    q=1;
end
E_iter_2_ifft=fftshift(ifft2(E_iter_2,512,512));

        