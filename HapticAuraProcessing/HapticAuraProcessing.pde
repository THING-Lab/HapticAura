import de.voidplus.leapmotion.*;
LeapMotion leap;


// Serial Port Output
import processing.serial.*; // Serial libraries, send OUTPUT through USB
Serial myPort;
int ledPin;
int checkPin;

void setup() {
  size(800, 500, P3D);
  background(255);
  noStroke();
  fill(50);
  
  // New port object
  //println(Serial.list());
  myPort = new Serial(this, Serial.list()[3], 9600);
  // New leap object
  leap = new LeapMotion(this);
}

void draw() {
  background(255);
  
  // Leap magic
  int fps = leap.getFrameRate();
  // Clean LEAP Hand position
  for (Hand hand : leap.getHands()) {
    hand.draw();
    PVector hand_position = hand.getPosition();
    //println("Hand on X: " + hand.getPosition().x );
    
      //PVector finger_position = hand.getFinger(1).getPosition();
      float pos = hand.getFinger(1).getPosition().z;
      println("finger on x: " + pos);
 
      if(pos >= 70){
        myPort.write('H');
      }
      else{
        myPort.write('L');
      }
  }
}
