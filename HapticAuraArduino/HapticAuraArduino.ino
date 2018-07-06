int sValve_1 = 8;
int sValve_2 = 9;
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
  
  }
}


