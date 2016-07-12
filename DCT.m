function [C,E] = DCT( I )
A=double(I)/255;

for i=1:8
    X=maska(i);
    T=dctmtx(8);
    B=blkproc(A,[8 8],'P1*x*P2',T,T');
    B2=blkproc(B,[8 8],'P1.*x',X);
    I2=blkproc(B2,[8 8],'P1*x*P2',T',T);
        
        %wspolczynnik kompresji
        %b - ilosc jedynek w masce
        b=0;
        for m=1:8
            for n=1:8
                if X(m,n)==1
                    b=b+1;
                end
            end
        end
        C(i,1) = 64/b;

        %blad sredniokwadratowy
        suma=sum(sum((I2(:)-A(:)).^2));
        E(i,1)=(suma/numel(I))^0.5;
        
        figure; subplot(1,2,1); imshow(I);
        subplot(1,2,2); imshow(I2);
end

%rysujemy CR(MSE)
figure; plot(C,E,'* r');
title('CR(MSE)');

end

