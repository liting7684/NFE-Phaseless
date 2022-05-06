function Y=ifft2b(X)
    %Y=fftshift(ifft2(ifftshift(X)));
    %Y=ifft2(X);
    Y=ifft2(ifftshift(X));
end