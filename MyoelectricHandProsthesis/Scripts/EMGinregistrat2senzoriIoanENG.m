clear all
close all
clc

title0='Definire scenarii'; % (1)Titlul casutei de dialog
prompt='Introduceti tipul experimentului';  % (2)Mesajul afisat/instructiunea afisata catre...
...utilizator
tips=newid(prompt,title0);%(3)crearea casutei de dialog cu tasta enter configurata pt OK...
... si preluarea caracterelor tastate de utilizator, aici numele experimentului
title3='Numar grupe de muschi implicate';% vezi (1)

% prompt3='Introduceti numarul de grupe de muschi implicate'; % vezi (2)
% nrg=newid(prompt3,title3); % vezi (3). Lui nrg i se atribuie numarul de grupe ales de...
% ...utilizator
% nrg = cellfun(@str2num,nrg); %newid returneaza o celula cu un string...
...(string=vector de caractere), nu un numar. Asadar, aici cellfun converteste celula in numar.
nrg=2

% for i=1:nrg % pentru fiecare grupa de muschi, preluam numele acesteia
% title2='Define muscle name';
% prompt2='Fill in the muscle(s) name(s)';
% grupa(i)=newid(prompt2,title2);
% end
grupa={'flexor pollicis longus muscle', 'flexor digitorum profundus muscle'};
% Scenarii
msgbox('Starting the acquisition...');
msgbox(['Experiment type ', tips{1}]);% Crearea unor ferestre de mesaj
nresantioane=300;% Initializam nr de esantioane ale semnalelor EMG ...
...pe care dorim sa le achizitionam
    
s3=serial('COM5'); %crearea unui obiect pentru portul serial -police
s4=serial('COM6');%crearea unui obiect pentru portul serial -4 degete
% s = arduino('com3', 'uno');

%%
%setarea proprietatilor porturilor
set(s3, 'FlowControl', 'none');
set(s3, 'BaudRate', 115200); 
set(s3, 'Parity', 'none');
set(s3, 'DataBits', 8); 
set(s3, 'StopBit', 1);
 
set(s4, 'FlowControl', 'none');
set(s4, 'BaudRate', 115200); 
set(s4, 'Parity', 'none');
set(s4, 'DataBits', 8); 
set(s4, 'StopBit', 1);
pause(5);%Pauza pt pregatirea subiectului
fopen(s3); %Deschidem portul serial COM3
fopen(s4);%Deschidem portul serial COM4

h=waitbar(0,'Signal acquisition...'); %crearea si initializarea unei figuri...
...ce arata statusul achizitiei de semnale
 for i=1:nresantioane
waitbar(i/nresantioane,h);%updatarea figurii cu statusul achizitiei
%citirea datelor de la porturile seriale
b3=fgetl(s3);
b4=fgetl(s4);

%convertirea datelor de la cele doua porturi seriale in valori din stringuri in numere in...
...in baza 10 si memorarea lor intr-o matrice cu 2 linii si nresantioane coloane...
    ...daca nresantioane=300, matricea are 2 linii si 300 de coloane
d(1,i)=5*str2num(b3)/1024;% 
d(2,i)=5*str2num(b4)/1024;% 
  end %for
  close(h);%inchiderea figurii cu statusul achizitiei
for i=1:nrg
 figure(i),plot(d(i,:));%deschiderea si afisarea unei figuri diferite pt fiecare semnal
 xlabel('Samples number');%etichetarea axei x
 ylabel('Amplitude [V]');%etichetarea axei y
 title(['Sensor EMG: ',grupa{i}]);%titlul figurii personalizat cu numele grupei
 ylim([0 1]);%setarea limitelor axei y
 
 print([tips{1},grupa{i}],'-dpng','-r0');%salvarea figurii la rezolutia ecranului
 ...cu titlul obtinut prin concatenarea numelui experimentului si a denumirii grupei...
     ...de muschi

end

%tips{1} citeste primul element al celulei ca string
 figure%crearea si afisarea unei figuri ce contine graficele pentru grupele de muschi alese
 for i=1:nrg
    subplot(nrg,1,i);
    plot(d(i,:));
  yyy=[0 1];
    xlabel('Samples number');%etichetarea axei x
 ylabel('Amplitude [V]');%etichetarea axei y
 title(['Sensor: EMG ',grupa{i}]);%titlul subgraficului personalizat cu numele grupei
  set(gca,'Ylim',yyy);%setarea limitelor axei y pentru toate subgraficele
print([tips{1},'Subplots'],'-dpng','-r0');%titlul figurii personalizat cu numele...
...experimentului 
 end
 
%%Test praguri constante
Prag1=0.28;
Prag2=0.45;
emg1=d(1,:);
emg2=d(2,:);
%% Lungimile vectorilor emg1 si emg2 sunt egale intotdeauna
for ll=1:length(emg1)
    if emg1(ll)<Prag1
        if emg2(ll)<Prag2
            Decizii{ll}='Decizia 1';
            fprintf(s3,'d1');% transmisa pe portul care contine servomotoarele
        else
            Decizii{ll}='Decizia 2';
            fprintf(s3,'d2');% transmisa pe portul care contine servomotoarele
        end
        elseif emg1(ll)>Prag1
                if emg2(ll)<Prag2
                    Decizii{ll}='Decizia 3';
                    fprintf(s3,'d3');% transmisa pe portul care contine servomotoarele
                else
                    Decizii{ll}='Decizia 4';
                    fprintf(s3,'d4');% transmisa pe portul care contine servomotoarele
                end
    end
end
            
  save ([tips{1} '.mat']);      