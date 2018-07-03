int sValve_1 = 0;
int sValve_2 = 1;
int sValve_3 = 2;
int sValve_4 = 3;
int sValve_5 = 4;
int sValve_6 = 5;
int sValve_7 = 6;
int sValve_8 = 7;
int delayMill = 1000;

void setup() {

  pinMode(sValve_1, OUTPUT);
  pinMode(sValve_2, OUTPUT);
  pinMode(sValve_3, OUTPUT);
  pinMode(sValve_4, OUTPUT);
  pinMode(sValve_5, OUTPUT);
  pinMode(sValve_6, OUTPUT);
  pinMode(sValve_7, OUTPUT);
  pinMode(sValve_8, OUTPUT);

  Serial.begin(9600);
}

void loop() {
  if (Serial.available()) {
    char currentRead = Serial.read();
  
    if(currentRead == 'A') {
      digitalWrite(sValve_3, LOW);
    }

    if(currentRead == 'B') {
      digitalWrite(sValve_3, HIGH);
    }

    
//    if(currentRead == "AL") {
//      digitalWrite(sValve_1, LOW);
//    }

//    if(currentRead == "BH") {
//      digitalWrite(sValve_2, LOW);
//      digitalWrite(sValve_2, HIGH);
//      delay(delayMill);
//      digitalWrite(sValve_2, LOW);
//      delay(delayMill);
//    }
////    if(currentRead == "BL") {
////      digitalWrite(sValve_2, LOW);
////    }
//
//    if(currentRead == "CH") {
//      digitalWrite(sValve_3, LOW);
//      digitalWrite(sValve_3, HIGH);
//      delay(delayMill);
//      digitalWrite(sValve_3, LOW);
//      delay(delayMill);
//    }
////    if(currentRead == "CL") {
////      digitalWrite(sValve_3, LOW);
////    }
//
//    if(currentRead == "DH") {
//      digitalWrite(sValve_4, LOW);
//      digitalWrite(sValve_4, HIGH);
//      delay(delayMill);
//      digitalWrite(sValve_4, LOW);
//      delay(delayMill);
//    }
////    if(currentRead == "DL") {
////      digitalWrite(sValve_4, LOW);
////    }
//
//    if(currentRead == "EH") {
//      digitalWrite(sValve_5, LOW);
//      digitalWrite(sValve_5, HIGH);
//      delay(delayMill);
//      digitalWrite(sValve_5, LOW);
//      delay(delayMill);
//    }
////    if(currentRead == "EL") {
////      digitalWrite(sValve_5, LOW);
////    }
//
//    if(currentRead == "FH") {
//      digitalWrite(sValve_6, LOW);
//      digitalWrite(sValve_6, HIGH);
//      delay(delayMill);
//      digitalWrite(sValve_6, LOW);
//      delay(delayMill);
//    }
////    if(currentRead == "FL") {
////      digitalWrite(sValve_6, LOW);
////    }
//
//    if(currentRead == "GH") {
//      digitalWrite(sValve_7, LOW);
//      digitalWrite(sValve_7, HIGH);
//      delay(delayMill);
//      digitalWrite(sValve_7, LOW);
//      delay(delayMill);
//    }
////    if(currentRead == "GL") {
////      digitalWrite(sValve_7, LOW);
////    }
//
//    if(currentRead == "HH") {
//      digitalWrite(sValve_8, LOW);
//      digitalWrite(sValve_8, HIGH);
//      delay(delayMill);
//      digitalWrite(sValve_8, LOW);
//      delay(delayMill);
//    }
//    if(currentRead == "HL") {
//      digitalWrite(sValve_8, LOW);
//    }
  }
}


