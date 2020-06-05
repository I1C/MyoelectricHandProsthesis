/* Sweep 
 by BARRAGAN <http://barraganstudio.com>
 This example code is in the public domain.

 modified 8 Nov 2013
 by Scott Fitzgerald
 http://www.arduino.cc/en/Tutorial/Sweep
*/

#include <Servo.h>

Servo deg2;  // create servo object to control a servo
// twelve servo objects can be created on most boards
Servo deg3;
Servo deg4;
Servo deg5;
#define MAX 180
//valori initiale pozitii
int pos22=0;/*se inlocuieste cu valoarea testata in lab*/
int pos33=0;/*se inlocuieste cu valoarea testata in lab*/
int pos44=140;/*se inlocuieste cu valoarea testata in lab*/
int pos55=180;/*se inlocuieste cu valoarea testata in lab*/
//valori finale pozitii
int fpos22=180;/*se inlocuieste cu valoarea testata in lab*/
int fpos33=140;/*se inlocuieste cu valoarea testata in lab*/
int fpos44=0;/*se inlocuieste cu valoarea testata in lab*/
int fpos55=0;/*se inlocuieste cu valoarea testata in lab*/
//indecsii maximi ai vectorilor calculati cunoscand pozitia initiala si finala si pasul de incrementare
  int ipos2=round((fpos22-pos22)/4)+1;
  int ipos3=round((fpos33-pos33)/4)+1;
  int ipos4=round((fpos44-pos44)/4)+1;
  int ipos5=round((fpos55-pos55)/4)+1;

 // functie calcul lungime maxima a vectorilor
 const int maxpoz(int i2,int i3,int i4,int i5){
  
  const int maxipos=max(i2,i3);
  const int maxipos2=max(maxipos,i4);
  const int max3=int(max(maxipos2,i5));//maximul celor patru numere
  return max3;
}

//lungime maxima a vectorilor calculata
const int maxipos3=maxpoz(ipos2,ipos3,ipos4,ipos5);
// definire vectori de pozitie
int pos2[MAX];
int pos3[MAX];
int pos4[MAX];
int pos5[MAX];


void setup() {
  int i,coef;
  deg2.attach(3);  // atasare pini servomotoare
  deg3.attach(5);
  deg4.attach(6);
  deg5.attach(9);
  
  // calcul vectori de pozitie pentru fiecare servo
  //!!! Am modificat indexul de start de la 1 la 0 pt ca in ARDUINO IDE vectorii sunt zero indexed !!!
if (ipos2==maxipos3)
        for (i=0;i<=ipos2-1;i++){
            pos2[i]=pos22+4*i;
        }
    else
    {coef=(round(fpos22-pos22)/maxipos3);
    
        for (i=0;i<=maxipos3-1;i++){
        pos2[i]=pos22+coef*i;
    }
}

  
  if (ipos3==maxipos3)
        for (i=0;i<=ipos3-1;i++){
            pos3[i]=pos33+4*i;
        }
    else
    {coef=(round(fpos33-pos33)/maxipos3);
    
        for (i=0;i<=maxipos3-1;i++){
        pos3[i]=pos33+coef*i;
    }
}

if (ipos4==maxipos3)
        for (i=0;i<=ipos4-1;i++){
            pos4[i]=pos44+4*i;
        }
    else
    {coef=(round(fpos44-pos44)/maxipos3);
    
        for (i=0;i<=maxipos3-1;i++){
        pos4[i]=pos44+coef*i;
    }
}

if (ipos5==maxipos3)
        for (i=0;i<=ipos5-1;i++){
            pos5[i]=pos55+4*i;
        }
    else
    {coef=(round(fpos55-pos55)/maxipos3);
    
        for (i=0;i<=maxipos3-1;i++){
        pos5[i]=pos55+coef*i;
    }
}


}

void loop() {
  int i;
  for (i=0;i<=maxipos3-1;i++){
  deg2.write(pos2[i]);
  deg3.write(pos3[i]);
  deg4.write(pos4[i]);
  deg5.write(pos5[i]);
  
    delay(15);                       // waits 15ms for the servo to reach the position
  }
  for (i = maxipos3-1; i >= 0; i -=1.5) { // 
    deg2.write(pos2[i]);
  deg3.write(pos3[i]);
  deg4.write(pos4[i]);
  deg5.write(pos5[i]);              
  delay(15);                       // waits 15ms for the servo to reach the position
  }
}
