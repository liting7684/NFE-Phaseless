function Y=fft2b(X)
    %Y=fftshift(fft2(ifftshift(X)));
    %Y=fft2(X);
    Y=fftshift(fft2(X));
end