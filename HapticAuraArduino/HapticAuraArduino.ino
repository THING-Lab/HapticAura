<<<<<<< HEAD
const int selectPins[4] = {1, 2, 3, 4}; 
// S-pins to Arduino pins: S0~1, S1~2, S2~3, S3~4
int sValve_1 = 0;
int sValve_2 = 1;
=======
int sValve_1 = 8;
int sValve_2 = 9;
>>>>>>> aea6d244ebd19649d2618c7c956c1dd4771737e6
int sValve_3 = 2;
int sValve_4 = 3;
int sValve_5 = 4;
int sValve_6 = 5;
int sValve_7 = 6;
int sValve_8 = 7;
int delayMill = 1000;

// The selectMuxPin function sets the S0, S1, and S2 pins to select the give pin
void selectMuxPin(byte pin)
{
  if (pin > 7) return; // Exit if pin is out of scope
  for (int i=0; i<3; i++)
  {
    if (pin & (1<<i))
      digitalWrite(selectPins[i], HIGH);
    else
      digitalWrite(selectPins[i], LOW);
  }
}

void setup() {

  pinMode(sValve_1, OUTPUT);
  pinMode(sValve_2, OUTPUT);
  pinMode(sValve_3, OUTPUT);
  pinMode(sValve_4, OUTPUT);
  pinMode(sValve_5, OUTPUT);
  pinMode(sValve_6, OUTPUT);
  pinMode(sValve_7, OUTPUT);
  pinMode(sValve_8, OUTPUT);

  digitalWrite(sValve_1, HIGH);
  digitalWrite(sValve_2, HIGH);
  digitalWrite(sValve_3, HIGH);
  digitalWrite(sValve_4, HIGH);
  digitalWrite(sValve_5, HIGH);
  digitalWrite(sValve_6, HIGH);
  digitalWrite(sValve_7, HIGH);
  digitalWrite(sValve_8, HIGH);


  Serial.begin(9600);
}

void loop() {
  if (Serial.available()) {
<<<<<<< HEAD
    char currentRead = Serial.read();

    digitalWrite(sValve_1, LOW);
    digitalWrite(sValve_1, HIGH);
    delay(delayMill);
    digitalWrite(sValve_1, LOW);
    delay(delayMill);

     digitalWrite(sValve_2, LOW);
    digitalWrite(sValve_2, HIGH);
    delay(delayMill);
    digitalWrite(sValve_2, LOW);
    delay(delayMill);

    digitalWrite(sValve_3, LOW);
    digitalWrite(sValve_3, HIGH);
    delay(delayMill);
    digitalWrite(sValve_3, LOW);
    delay(delayMill);

    digitalWrite(sValve_4, LOW);
    digitalWrite(sValve_4, HIGH);
    delay(delayMill);
    digitalWrite(sValve_4, LOW);
    delay(delayMill);

    digitalWrite(sValve_5, LOW);
    digitalWrite(sValve_5, HIGH);
    delay(delayMill);
    digitalWrite(sValve_5, LOW);
    delay(delayMill);

    digitalWrite(sValve_6, LOW);
    digitalWrite(sValve_6, HIGH);
    delay(delayMill);
    digitalWrite(sValve_6, LOW);
    delay(delayMill);

    digitalWrite(sValve_7, LOW);
    digitalWrite(sValve_7, HIGH);
    delay(delayMill);
    digitalWrite(sValve_7, LOW);
    delay(delayMill);

    digitalWrite(sValve_8, LOW);
    digitalWrite(sValve_8, HIGH);
    delay(delayMill);
    digitalWrite(sValve_8, LOW);
    delay(delayMill);


=======
    int currentRead = Serial.read();
  
    if(currentRead == 1) {
      digitalWrite(sValve_1, HIGH);
    }

    if(currentRead == 2) {
      digitalWrite(sValve_1, LOW);
    }
    if(currentRead == 3) {
      digitalWrite(sValve_2, HIGH);
    }

    if(currentRead == 4) {
      digitalWrite(sValve_2, LOW);
    }
    if(currentRead == 5) {
      digitalWrite(sValve_3, HIGH);
    }

    if(currentRead == 6) {
      digitalWrite(sValve_3, LOW);
    }
    if(currentRead == 7) {
      digitalWrite(sValve_4, HIGH);
    }

    if(currentRead == 8) {
      digitalWrite(sValve_4, LOW);
    }
    if(currentRead == 9) {
      digitalWrite(sValve_5, HIGH);
    }

    if(currentRead == 10) {
      digitalWrite(sValve_5, LOW);
    }
    if(currentRead == 11) {
      digitalWrite(sValve_6, HIGH);
    }

    if(currentRead == 12) {
      digitalWrite(sValve_6, LOW);
    }
    if(currentRead == 13) {
      digitalWrite(sValve_7, HIGH);
    }

    if(currentRead == 14) {
      digitalWrite(sValve_7, LOW);
    }
    if(currentRead == 15) {
      digitalWrite(sValve_8, HIGH);
    }

    if(currentRead == 16) {
      digitalWrite(sValve_8, LOW);
    }
  
>>>>>>> aea6d244ebd19649d2618c7c956c1dd4771737e6
  }
}



