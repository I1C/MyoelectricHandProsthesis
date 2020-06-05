%//valori initiale pozitii
pos22=40;%/*se inlocuieste cu valoarea testata in lab*/
pos33=70;%/*se inlocuieste cu valoarea testata in lab*/
pos44=80;%/*se inlocuieste cu valoarea testata in lab*/
pos55=70;%/*se inlocuieste cu valoarea testata in lab*/
%//valori finale pozitii
fpos22=100;%/*se inlocuieste cu valoarea testata in lab*/
fpos33=150;%/*se inlocuieste cu valoarea testata in lab*/
fpos44=160;%/*se inlocuieste cu valoarea testata in lab*/
fpos55=170;%/*se inlocuieste cu valoarea testata in lab*/
%//indecsii maximi ai vectorilor calculati cunoscand pozitia initiala si finala si pasul de incrementare
   ipos2=round((fpos22-pos22)/4)+1;
   ipos3=round((fpos33-pos33)/4)+1;
   ipos4=round((fpos44-pos44)/4)+1;
   ipos5=round((fpos55-pos55)/4)+1;
 % // calcul index maxim
  
   maxipos=max(ipos2,ipos3);
   maxipos2=max(maxipos,ipos4);
   maxipos3=max(maxipos2,ipos5);%//maximul celor patru numere
  %// vectorii care stocheaza pozitiile motoarelor
% pos2[maxipos3];
% pos3[maxipos3];
% pos4[maxipos3];
% pos5[maxipos3];

%// calcul vectori de pozitie pentru fiecare servo
if (ipos2==maxipos3)
  for i=1:ipos2
    pos2(i)=pos22+4*(i-1);
  end
else%//pentru ca vectorii sa aiba aceeasi lungime si miscarile...
    ...sa fie sincrone, repetam, unde este cazul, valorile pentru pozitiile...
        ...ramase necompletate pana la maxim-maxipos3
        coef=(round(fpos22-pos22)/maxipos3)
    for i=1:maxipos3
    pos2(i)=pos22+coef*(i-1);
  end

end
    if (ipos3==maxipos3)
        for i=1:ipos3
            pos3(i)=pos33+4*(i-1);
        end
    else
    coef=(round(fpos33-pos33)/maxipos3)
    
        for i=1:maxipos3
        pos3(i)=pos33+coef*(i-1);
        end
    end

        
if (ipos4==maxipos3)
        for i=1:ipos4
            pos4(i)=pos44+4*(i-1);
        end
    else
    coef=(round(fpos44-pos44)/maxipos3)
    
        for i=1:maxipos3
        pos4(i)=pos44+coef*(i-1);
        end
    end
    
    if (ipos5==maxipos3)
        for i=1:ipos5
            pos5(i)=pos55+4*(i-1);
        end
    else
    coef=(round(fpos55-pos55)/maxipos3)
    
        for i=1:maxipos3
        pos5(i)=pos55+coef*(i-1);
        end
    end

figure(1), plot(pos2)
hold on
plot(pos3)
hold on
plot(pos4)
hold on
plot(pos5)
hold off
legend('pos2', 'pos3', 'pos4', 'pos5');

figure(2), plot(fliplr(pos2))
hold on
plot(fliplr(pos3))
hold on
plot(fliplr(pos4))
hold on
plot(fliplr(pos5))
hold off
legend('pos2r', 'pos3r', 'pos4r', 'pos5r');