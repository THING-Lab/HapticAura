int sValve_1  = 30;
int sValve_2  = 32;
int sValve_3  = 34;
int sValve_4  = 36;
int sValve_5  = 38;
int sValve_6  = 40;
int sValve_7  = 42;
int sValve_8  = 44;
int sValve_9  = 31;
int sValve_10 = 33;
int sValve_11 = 35;
int sValve_12 = 37;
int sValve_13 = 39;
int sValve_14 = 41;
int sValve_15 = 43;
int sValve_16 = 45;
int sValve_17 = 48;
int sValve_18 = 50;
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
  pinMode(sValve_9, OUTPUT);
  pinMode(sValve_10, OUTPUT);
  pinMode(sValve_11, OUTPUT);
  pinMode(sValve_12, OUTPUT);
  pinMode(sValve_13, OUTPUT);
  pinMode(sValve_14, OUTPUT);
  pinMode(sValve_15, OUTPUT);
  pinMode(sValve_16, OUTPUT);
  pinMode(sValve_17, OUTPUT);
  pinMode(sValve_18, OUTPUT);

  digitalWrite(sValve_1, LOW);
  digitalWrite(sValve_2, LOW);
  digitalWrite(sValve_3, LOW);
  digitalWrite(sValve_4, LOW);
  digitalWrite(sValve_5, LOW);
  digitalWrite(sValve_6, LOW);
  digitalWrite(sValve_7, LOW);
  digitalWrite(sValve_8, LOW);
  digitalWrite(sValve_9, LOW);
  digitalWrite(sValve_10, LOW);
  digitalWrite(sValve_11, LOW);
  digitalWrite(sValve_12, LOW);
  digitalWrite(sValve_13, LOW);
  digitalWrite(sValve_14, LOW);
  digitalWrite(sValve_15, LOW);
  digitalWrite(sValve_16, LOW);
  digitalWrite(sValve_17, LOW);
  digitalWrite(sValve_18, LOW);


  Serial.begin(9600);
}

void loop() {

    Serial.println("2"); 
  
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
    if(currentRead == 17) {
      digitalWrite(sValve_9, HIGH);
    }

    if(currentRead == 18) {
      digitalWrite(sValve_9, LOW);
    }
    if(currentRead == 19) {
      digitalWrite(sValve_10, HIGH);
    }

    if(currentRead == 20) {
      digitalWrite(sValve_10, LOW);
    }
    if(currentRead == 21) {
      digitalWrite(sValve_11, HIGH);
    }

    if(currentRead == 22) {
      digitalWrite(sValve_11, LOW);
    }
    if(currentRead == 23) {
      digitalWrite(sValve_12, HIGH);
    }

    if(currentRead == 24) {
      digitalWrite(sValve_12, LOW);
    }
    if(currentRead == 25) {
      digitalWrite(sValve_13, HIGH);
    }

    if(currentRead == 26) {
      digitalWrite(sValve_13, LOW);
    }
    if(currentRead == 27) {
      digitalWrite(sValve_14, HIGH);
    }

    if(currentRead == 28) {
      digitalWrite(sValve_14, LOW);
    }
    if(currentRead == 29) {
      digitalWrite(sValve_15, HIGH);
    }

    if(currentRead == 30) {
      digitalWrite(sValve_15, LOW);
    }
    if(currentRead == 31) {
      digitalWrite(sValve_16, HIGH);
    }

    if(currentRead == 32) {
      digitalWrite(sValve_16, LOW);
    }
    if(currentRead == 33) {
      digitalWrite(sValve_17, HIGH);
    }

    if(currentRead == 34) {
      digitalWrite(sValve_17, LOW);
    }
    if(currentRead == 35) {
      digitalWrite(sValve_18, HIGH);
    }

    if(currentRead == 36) {
      digitalWrite(sValve_18, LOW);
    }
  }
}


