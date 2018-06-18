// Define main variables
int ledPin = 13;
// Slowing down the process
//unsigned long millisCounter = 0;
//int interval = 10;
// activate the pins I want to use on my board
int myPin = 13;


void setup() {
// Activate all Digital pins on my board
  for (int i = 0; i < 5; i++) {
    pinMode(myPin, OUTPUT);
  }
  Serial.begin(9600);
}

void loop() {
  if (Serial.available()) {
    char currentRead = Serial.read();
  
    if(currentRead == 'H') {
      digitalWrite(ledPin, HIGH);
    }
    if(currentRead == 'L') {
      digitalWrite(ledPin, LOW);
    }
  }
}


