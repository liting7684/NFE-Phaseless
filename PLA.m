% 产生#1平面的范围为[-180,180]的随机相位
Ex_arb_phase=randi([-180,180],133,95);
% 生成初始迭代场E_iter_1
E_iter_1=[];
for i=1:1:Mc
    for j=1:1:Nc
        E_iter_1=Ex_amp.*cosd(Ex_arb_phase)+1i*Ex_amp.*sind(Ex_arb_phase);
    end
end
% E_iter_1_amp为初始迭代场E_iter_1的幅度
% E_iter_1_phase为初始迭代场E_iter_1的相位
E_iter_1_amp=20*log10(abs(E_iter_1));
E_iter_1_phase=angle(E_iter_1)*180/pi;
E_iter_2=fft2(E_iter_1);
E_iter_3=ifft2(E_iter_2);
surf(20*log10(abs(E_iter_3)))